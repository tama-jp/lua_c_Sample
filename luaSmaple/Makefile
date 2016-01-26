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

