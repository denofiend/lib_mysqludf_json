
		
DELIMITER $$
		
		
CREATE TRIGGER mx_user_transfer AFTER INSERT ON extend_user_info
FOR EACH ROW BEGIN
INSERT INTO base_user_info_tmp
	select 
	a.user_id,
	a.account,
	a.password,
	a.nickname,
	a.gender,
	a.status,
	a.ip,
	a.register_time,
	a.update_time,
	a.language,
	a.`from`,
	a.`email`,
	a.mobile,
	a.country_code,
	a.region,1 from base_user_info a where a.`user_id` = NEW.`user_id`;

INSERT INTO `extend_user_info_tmp` 
			select b.`user_id`, b.`first_name`,
			b.`last_name`,
			b.`birthday`,
			b.`timezone`,
			b.`location`,
			b.`province`,
			b.`city`,
			b.`address`,
			b.`zipcode`,
			b.`phone_number`,
			b.`mobile_number`,
			b.`backup_email`,
			b.`avatarurl`,
			b.`im_type`,
			b.`im_value`,
			b.`realname`,
			b.`home_location`,
			b.`home_province`,
			b.`home_city`,
			b.`personalid`,
			b.`qq`,
			0 as `flag`,
			b.`skype`  from `extend_user_info` b where b.`user_id` = NEW.`user_id`;

	INSERT INTO `roll_transaction`(`user_id`, `type`, `json`) 
		select a.`user_id`, 0 as `type`, 
				json_object(
					a.user_id as user_id,
					a.account as account,
					a.password as password,
					a.nickname as nickname,
					a.gender as gender,
					a.status as status,
					a.ip as register_ip,
					a.register_time as register_time,
					a.update_time as update_time,
					a.language as language,
					a.`from` as `from`,
					a.`email` as email,
					a.mobile as mobile,
					a.country_code as country_code,
					a.region as region,
					a.id as id,
					b.`first_name` as frist_name,
					b.`last_name` as last_name,
					b.`birthday` as brithday,
					b.`timezone` as timezone,
					b.`location` as location,
					b.`province` as province,
					b.`city` as city,
					b.`address` as address,
					b.`zipcode` as zipcode,
					b.`phone_number` as phone_number,
					b.`mobile_number` as mobile_number,
					b.`backup_email` as backup_email,
					b.`avatarurl` as avatarurl,
					b.`im_type` as im_type,
					b.`im_value` as im_value,
					b.`realname` as realname,
					b.`home_location` as home_location,
					b.`home_province` as home_province,
					b.`home_city` as home_city,
					b.`personalid` as personalid,
					b.`qq` as qq,
					b.`flag` as flag,
					b.`skype` as skype
				) as `json` from `base_user_info_tmp` a, `extend_user_info_tmp` b where a.`user_id` = NEW.`user_id` and b.`user_id` = a.`user_id`;

END;
$$


insert into base_user_info (user_id, nickname, account, email)values(1, 'b', 'b@a.com', 'b@a.com');
insert into extend_user_info (user_id)values(1);

