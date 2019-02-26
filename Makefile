CC=gcc
CFLAGS=`pkg-config --cflags gtk+-3.0`
LDFLAGS=`pkg-config --libs gtk+-3.0`
TARGET=gtk

.PHONY: all gtk clean

all: $(TARGET)

$(TARGET): gtk.o
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

clean:
	rm -f $(TARGET) *.o
