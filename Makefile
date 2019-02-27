SMLSHARP = smlsharp
CC=gcc
CFLAGS=-Wall -Wextra `pkg-config --cflags gtk+-3.0`
LDFLAGS=`pkg-config --libs gtk+-3.0`
TARGET=gtk

.PHONY: all clean

all: $(TARGET) main.o

$(TARGET): $(TARGET).o macrowrapper.o
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

# main: main.o main.smi macrowrapper.o
# 	$(SMLSHARP) $(LDFLAGS) -o $@ main.smi $(LIBS)

main.o: main.sml main.smi
	$(SMLSHARP) $(SMLFLAGS) -o $@ -c main.sml

clean:
	rm -f $(TARGET) *.o
