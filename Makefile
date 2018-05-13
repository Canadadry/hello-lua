LUA_DIR=/usr/local
LUA_LIBDIR=$(LUA_DIR)/lib/lua/5.1
LIBFLAG= -fpic -dynamiclib -Wl,-undefined,dynamic_lookup
CFLAGS= -std=c99

hello.so:	hello.c
	$(CC) -o hello.so $(LIBFLAG) $(CFLAGS) hello.c 

clean:
	$(RM) hello.so

test: hello.so
	shake test.lua

rock:
	luarocks make hello-scm-1.rockspec
