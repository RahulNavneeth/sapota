CC = clang
CFLAGS = -Wall -O3
CFLAGS := -Iinclude
# CLIBS = -L
# CLIB = -l

BIN = bin
SRC = $(shell find . | grep "\.c")
OBJ = $(patsubst %.c, $(BIN)/%.o, $(SRC))
UTILS_HEADER = "./utils/headers.sh"

.PHONY: all dirs util clean build

all: clean util dirs build

clean:
	rm -rf $(BIN)

dirs:
	mkdir $(BIN)

util:
	chmod +x $(UTILS_HEADER)
	$(UTILS_HEADER) $(path)

build: $(OBJ)
	$(CC) -o $(BIN)/main $^ $(CLIBS)

$(BIN)/%.o: %.c 
	mkdir -p $(dir $@)
	$(CC) -o $@ -c $< $(CFLAGS)

run: all
	$(BIN)/main $(path)
