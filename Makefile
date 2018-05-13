LUA_DIR=/usr/local
LUA_LIBDIR=$(LUA_DIR)/lib/lua/5.1
LIBFLAG= -fpic -dynamiclib -Wl,-undefined,dynamic_lookup
CFLAGS= -std=c99

all: hello.so hello_struct.so

hello.so:	hello.c
	$(CC) -o hello.so $(LIBFLAG) $(CFLAGS) hello.c 

hello_struct.so:	hello_struct.c
	$(CC) -o hello_struct.so $(LIBFLAG) $(CFLAGS) hello_struct.c 

clean:
	$(RM) hello.so hello_struct.so

test: hello.so hello_struct.so
	shake test.lua

rock:
	luarocks make hello-scm-1.rockspec
