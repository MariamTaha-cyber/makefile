#directives to make it search for files in define path
vpath %.c ./src
vpath %.h ./inc

#variable to make makefile more generic 
CC = gcc
LINK_TARGET = app.exe

SRC_PATH = ./src
INCLUDE_PATH = ./inc
DEP_PATH = ./Deps/

#include all files automaticlly 
SRC_FILES = $(wildcard src/*.c)
OBJ := $(SRC_FILES:.c=.o)
DEPS := $(SRC_FILES:.c=.d) 

#change path for dependencies
DEP = $(addprefix $(DEP_PATH)\,$(DEPS))


#variable for all files needed to be deleted
CLEAN_TARGET = $(LINK_TARGET) $(OBJ) $(DEP)

#include dependencies to check them before build 
-include $(DEP)

#start building the project
all:$(LINK_TARGET)
	echo Bulding done !
	
#delete files mentioned in variable
clean:
	-rm $(CLEAN_TARGET)
	echo Cleaning done !

#build to generate exe file
$(LINK_TARGET): $(OBJ) Mariam.o
	$(CC) $(OBJ) Mariam.o -o $@
	echo Linking done !

#generate dependencies automaticlly

%.d : %.c
	$(CC) -M -I$(INCLUDE_PATH) $^ -o $@
	
#generate object automaticlly	
%.o : %.c
	$(CC) -c -I$(INCLUDE_PATH) $< -o $@

