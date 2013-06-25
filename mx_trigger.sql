CREATE TABLE `base_user_info_tmp` (
	`user_id` int(11) NOT NULL,
	`account` varchar(255) DEFAULT NULL,
	`password` char(64) DEFAULT NULL,
	`nickname` varchar(255) DEFAULT NULL,
	`gender` tinyint(4) DEFAULT '0',
	`status` tinyint(4) DEFAULT '2',
	`ip` varchar(50) DEFAULT NULL,
	`register_time` char(10) DEFAULT NULL,
	`update_time` char(10) DEFAULT NULL,
	`language` char(50) DEFAULT NULL,
	`from` char(20) DEFAULT NULL,
	`email` varchar(255) DEFAULT NULL,
	`mobile` varchar(255) DEFAULT NULL,
	`country_code` int(11) DEFAULT NULL,
	`region` varchar(255) DEFAULT NULL,
	`id` bigint(20) NOT NULL,
	UNIQUE KEY `nickname` (`nickname`),
	UNIQUE KEY `account` (`account`),
	UNIQUE KEY `email` (`email`),
	UNIQUE KEY `mobile` (`mobile`,`country_code`),
	KEY `register` (`register_time`),
	KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `extend_user_info_tmp` (
	`user_id` int(11) NOT NULL,
	`first_name` varchar(50) DEFAULT NULL,
	`last_name` varchar(50) DEFAULT NULL,
	`birthday` date DEFAULT NULL,
	`timezone` tinyint(4) DEFAULT NULL,
	`location` char(2) DEFAULT NULL,
	`province` varchar(50) DEFAULT NULL,
	`city` varchar(255) DEFAULT NULL,
	`address` varchar(255) DEFAULT NULL,
	`zipcode` varchar(50) DEFAULT NULL,
	`phone_number` varchar(50) DEFAULT NULL,
	`mobile_number` varchar(50) DEFAULT NULL,
	`backup_email` varchar(50) DEFAULT NULL,
	`avatarurl` varchar(255) DEFAULT NULL,
	`im_type` varchar(50) DEFAULT NULL,
	`im_value` varchar(255) DEFAULT NULL,
	`realname` varchar(50) DEFAULT NULL,
	`home_location` char(2) DEFAULT NULL,
	`home_province` char(50) DEFAULT NULL,
	`home_city` varchar(255) DEFAULT NULL,
	`personalid` varchar(40) DEFAULT NULL,
	`qq` varchar(40) DEFAULT NULL,
	`flag` tinyint(4) DEFAULT NULL,
	`skype` varchar(255) DEFAULT NULL,
	PRIMARY KEY (`user_id`),
	KEY `BackupEmail` (`backup_email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

		
DELIMITER $$
		
		
CREATE TRIGGER mx_user_transfer AFTER INSERT ON extend_user_info_tmp
FOR EACH ROW BEGIN
INSERT INTO base_user_info
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
	a.region,1 from base_user_info_tmp a where a.`user_id` = NEW.`user_id`;

INSERT INTO `extend_user_info` 
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
			b.`skype`  from `extend_user_info_tmp` b where b.`user_id` = NEW.`user_id`;

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
					b.`first_name` as first_name,
					b.`last_name` as last_name,
					b.`birthday` as birthday,
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
				) as `json` from `base_user_info` a, `extend_user_info` b where a.`user_id` = NEW.`user_id` and b.`user_id` = a.`user_id`;

END;
$$


insert into base_user_info (user_id, nickname, account, email)values(1, 'b', 'b@a.com', 'b@a.com');
insert into extend_user_info (user_id)values(1);

