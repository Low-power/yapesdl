objects =		\
1541mem.o \
archdep.o		\
Cia.o		\
cpu.o	\
dis.o	\
diskfs.o \
dos.o \
drive.o \
FdcGcr.o \
iec.o \
interface.o		\
keyboard.o \
keys64.o \
main.o \
monitor.o 	\
prg.o \
SaveState.o	\
serial.o	\
Sid.o \
sound.o	\
tape.o \
tcbm.o \
tedmem.o \
tedsound.o \
vic2mem.o \
video.o

EXENAME = yapesdl
SRCPACKAGENAME = $(EXENAME)_0.70.2-1
#BINPACKAGENAME = $(SRCPACKAGENAME)_amd64
ifdef USE_SDL2
SDL_CFLAGS += -D USE_SDL2=2
SDL_LIBS := -l SDL2
else
SDL_LIBS := -l SDL
endif

headers = $(objects:.o=.h)
sources = $(objects:.o=.cpp)
allfiles = $(headers) $(sources)
hasnoheader = main.h dos.h dis.h tedsound.h
sourcefiles = $(filter-out $(hasnoheader),$(allfiles)) icon.h device.h mem.h mnemonic.h \
				roms.h types.h Clockable.h 1541rom.h YapeSDL.cbp YapeSDL.Linux.cbp

CXX = g++
CXXFLAGS += -Os -Wall $(SDL_CFLAGS)
libs = $(SDL_LIBS)

$(EXENAME): $(objects)
	$(CXX) $(LDFLAGS) $(objects) -o $@ $(libs)

#yapedebug : $(objects)
#	$(CXX) $(CXXFLAGS) $(libs) -g -Og -o $(EXENAME)d $^

1541mem.o : 1541mem.cpp
	$(CXX) $(CXXFLAGS) -c $<

archdep.o : archdep.cpp
	$(CXX) $(CXXFLAGS) -c $<

Cia.o : Cia.cpp
	$(CXX) $(CXXFLAGS) -c $<

cpu.o : cpu.cpp tedmem.h
	$(CXX) $(CXXFLAGS) -c $<

diskfs.o : diskfs.cpp diskfs.h device.h iec.h
	$(CXX) $(CXXFLAGS) -c $<

dis.o : dis.cpp
	$(CXX) $(CXXFLAGS) -c $<

dos.o : dos.cpp
	$(CXX) $(CXXFLAGS) -c $<

drive.o : drive.cpp iec.cpp drive.h device.h diskfs.h iec.h tcbm.h
	$(CXX) $(CXXFLAGS) -c $<

FdcGcr.o : FdcGcr.cpp
	$(CXX) $(CXXFLAGS) -c $<

iec.o : iec.cpp iec.h
	$(CXX) $(CXXFLAGS) -c $<

interface.o : interface.cpp
	$(CXX) $(CXXFLAGS) -c $<

keyboard.o : keyboard.cpp keyboard.h
	$(CXX) $(CXXFLAGS) -c $<

keys64.o : keys64.cpp keys64.h
	$(CXX) $(CXXFLAGS) -c $<

main.o : main.cpp
	$(CXX) $(CXXFLAGS) -c $<

monitor.o : monitor.cpp
	$(CXX) $(CXXFLAGS) -c $<

prg.o : prg.cpp prg.h
	$(CXX) $(CXXFLAGS) -c $<

SaveState.o : SaveState.cpp SaveState.h
	$(CXX) $(CXXFLAGS) -c $<

serial.o : serial.cpp
	$(CXX) $(CXXFLAGS) -c $<

sound.o : sound.cpp sound.h
	$(CXX) $(CXXFLAGS) -c $<

Sid.o : Sid.cpp
	$(CXX) $(CXXFLAGS) -c $<

tape.o : tape.cpp tape.h
	$(CXX) $(CXXFLAGS) -c $<

tcbm.o : tcbm.cpp tcbm.h
	$(CXX) $(CXXFLAGS) -c $<

tedmem.o : tedmem.cpp
	$(CXX) $(CXXFLAGS) -c $<

tedsound.o : tedsound.cpp
	$(CXX) $(CXXFLAGS) -c $<

vic2mem.o : vic2mem.cpp vic2mem.h
	$(CXX) $(CXXFLAGS) -c $<

video.o : video.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean :
	rm -f *.o
	rm -f $(EXENAME)

tgz :
	tar -czf $(SRCPACKAGENAME).tar.gz $(sourcefiles) Makefile COPYING README.SDL Changes

e :
	#emacs -fn 9x13 Makefile *.h *.cpp &
	emacs -fn 10x20 Makefile *.h *.cpp &

deb:
	cp $(EXENAME) $(SRCPACKAGENAME)/usr/local/bin
	dpkg-deb --build $(SRCPACKAGENAME)
	mv $(SRCPACKAGENAME).deb $(BINPACKAGENAME).deb

install :
#	@if [ ! -e $(HOME)/yape ]; then mkdir $(HOME)/.yape ; fi
#	@cp yape.conf $(HOME)/.yape $^
	@cp $(EXENAME) $(BINDIR)


