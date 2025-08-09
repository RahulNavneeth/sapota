CC = clang
CFLAGS = -Wall -O3
CFLAGS += -Iinclude
# LDFLAGS = 

BIN = bin
SRC = $(shell find src -name "*.c")
OBJ = $(patsubst %.c, $(BIN)/%.o, $(SRC))

.PHONY: all dirs clean build

all: clean dirs build

clean:
	rm -rf $(BIN)

dirs:
	mkdir $(BIN)

build: $(OBJ)
	$(CC) -o $(BIN)/main $^

$(BIN)/%.o: %.c 
	mkdir -p $(dir $@)
	$(CC) -o $@ -c $< $(CFLAGS)

run: all
	$(BIN)/main
