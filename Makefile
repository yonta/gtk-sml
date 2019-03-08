SMLSHARP = smlsharp
CC=gcc
CFLAGS=-Wall -Wextra `pkg-config --cflags gtk+-3.0`
LDFLAGS=`pkg-config --libs gtk+-3.0`
TARGET=cmain
TARGET2=smlmain

.PHONY: all clean

all: $(TARGET) $(TARGET2)

$(TARGET): $(TARGET).o macrowrapper.o
	$(CC) $(CFLAGS) $^ -o $@ $(LDFLAGS)

$(TARGET2): $(TARGET2).o $(TARGET2).smi macrowrapper.o
	$(SMLSHARP) $(LDFLAGS) -o $@ $(TARGET2).smi macrowrapper.o $(LIBS)

$(TARGET2).o: $(TARGET2).sml $(TARGET2).smi
	$(SMLSHARP) $(SMLFLAGS) -o $@ -c $(TARGET2).sml

clean:
	rm -f $(TARGET) $(TARGET2) *.o
