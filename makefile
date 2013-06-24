#
## Simple .so Makefile
#
#
#CC= g++
LD= ld
LIBS = 

CFLAGS=-I/usr/local/mysql/include/mysql/ -I./
LDFLAGS= -shared -fPIC -mcmodel=medium
SOURCE= $(wildcard *.c)
OBJS= $(patsubst %.c,%.o,$(SOURCE))
TARGET_LIB= lib_mysqludf_json.so

all:$(OBJS)
	@echo $(OBJS)
	$(CC) $(LDFLAGS)  $(CFLAGS)  $(LIBS) -o $(TARGET_LIB)  $(SOURCE) 

#%.o:%.c%.cpp%.cc
#	@echo Compiling $< ...
#	#	$(CC) -c $(CFLAGS) $(LIBS)  $< -o $*.o
#
#	.PHONY: clean
#
clean:
	rm *.so *.o -rf

