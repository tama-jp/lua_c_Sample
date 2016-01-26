#!/bin/sh

# ディレクトリ作成
mkdir luaSmaple
cd luaSmaple

# luaソース一式をダウンロード
curl -R -O http://www.lua.org/ftp/lua-5.3.2.tar.gz
# tar.gzの解凍
tar zxf lua-5.3.2.tar.gz

# MakeFileの作成
cat << 'EOF' > Makefile
LUASRCS = lapi.c lauxlib.c lbaselib.c lbitlib.c lcode.c lcorolib.c      \
          lctype.c ldblib.c ldebug.c ldo.c ldump.c lfunc.c lgc.c        \
          linit.c liolib.c llex.c lmathlib.c lmem.c loadlib.c           \
          lobject.c lopcodes.c loslib.c lparser.c lstate.c lstring.c    \
          lstrlib.c ltable.c ltablib.c ltm.c lundump.c lvm.c lzio.c lutf8lib.c
LUADIR = lua-5.3.2
LUAOBJS = $(patsubst %.c,$(LUADIR)/src/%.o,$(LUASRCS))
OBJS = $(LUAOBJS) for_lua.o

CFLAGS = -I$(LUADIR)/src
LFLAGS = -lm

TARGET = for_lua

run: $(TARGET)
	./$^

$(TARGET): $(OBJS)
	$(CXX) -o $@ $(LFLAGS) $^

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $^

%.o: %.cpp
	$(CXX) -c $(CFLAGS) -o $@ $^

clean:
	rm -f $(OBJS) $(TARGET) *~

EOF

# Luaスクリプト作成
cat << 'EOF' > hello.lua
-- hello.lua
print("Hello World")
EOF

# C側のソースを作成
cat << 'EOF' > for_lua.c
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
EOF

# 念のためクリーンする
make clean
# コンパイルおよび実行
make

cd ..
