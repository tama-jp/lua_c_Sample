// for_lua.c
// 標準Cライブラリ
#include <stdio.h>

// luaライブラリ
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main(int argc, char *argv[]){
  int ret ;

  // Luaスクリプト
  const char *fn = "hello.lua";
  // Lua の言語エンジンを初期化
  lua_State *lua = luaL_newstate();

  // Lua のライブラリを使えるようにする
  luaL_openlibs(lua);

  // Lua のスクリプトを読み込み実行
  ret = luaL_dofile(lua, fn);

  // 戻り値を確認
  printf("\n----------------\nlua return [%d]\n", ret);

  return 0;
}
