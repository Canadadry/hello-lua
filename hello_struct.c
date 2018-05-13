#include "lua.h"
#include "lauxlib.h"
#include <stdlib.h>


typedef struct 
{
	int value;
} NewType;


int generic_constructor(lua_State * l)
{
    printf("generic_constructor\n");
    NewType ** udata = (NewType **)lua_newuserdata(l, sizeof(NewType *));
    *udata = malloc(sizeof(NewType));
    (*udata)->value = 7869876;
    luaL_getmetatable(l, "MyTypeMetatableName" );
    lua_setmetatable(l, -2);
    return 1;
}

NewType* check_type(lua_State * l, int n)
{
    return *(NewType **)luaL_checkudata(l, n, "MyTypeMetatableName");
}

int destructor(lua_State * l)
{
    printf("destructor\n");
    NewType* object = check_type(l, 1);
    free(object);
    return 0;
}

int print_type(lua_State * l)
{
    char ret[255] ;
    NewType* object = check_type(l, 1);
    sprintf(ret,"%d", object->value);
    lua_pushstring(l, ret);
    return 1;
}


static const struct luaL_Reg functions [] = {
    { "new"         , generic_constructor },
    { "__gc"        , destructor      },
    { "__tostring"  , print_type  },
    {NULL, NULL}
};


int luaopen_hello_struct(lua_State *l) {
	printf("luaopen_hello_struct\n");

    luaL_newmetatable(l, "MyTypeMetatableName" );
    luaL_setfuncs(l, functions,0);           
    lua_pushvalue(l, -1);                      
    lua_setfield(l, -1, "__index");          
    lua_setglobal(l, "MyType");          

    return 1;
}


