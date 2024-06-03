CC=gcc
CCFLAGS=-Ofast -Wall -march=native
RM=rm -f
INSTALL=install


MAGICK_VERSION=$(shell pkg-config --modversion ImageMagick | grep -E -o '^[0-9]+')

all: clean sturmflut

sturmflut: image.c network.c main.c progress.c image.h network.h main.h progress.h
	$(CC) $(CCFLAGS) -pthread -DIMAGICK=$(MAGICK_VERSION) image.c network.c main.c progress.c -lpthread `pkg-config --cflags --libs MagickWand` -o sturmflut

clean:
	$(RM) sturmflut

install: sturmflut
	$(INSTALL) -Dm755 sturmflut $(DESTDIR)/bin/sturmflut