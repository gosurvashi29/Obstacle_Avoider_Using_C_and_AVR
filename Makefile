###############################################################################
# Makefile for the project OBSTACLE_AVOIDER_1
###############################################################################

## General Flags
PROJECT = OBSTACLE_AVOIDER_1
MCU = atmega16
TARGET = OBSTACLE_AVOIDER_1.elf
CC = avr-gcc.exe

## Options common to compile, link and assembly rules
COMMON = -mmcu=$(MCU)

## Compile options common for all C compilation units.
CFLAGS = $(COMMON)
CFLAGS += -Wall -gdwarf-2 -Os -std=gnu99 -funsigned-char -funsigned-bitfields -fpack-struct -fshort-enums
CFLAGS += -MD -MP -MT $(*F).o -MF dep/$(@F).d 

## Assembly specific flags
ASMFLAGS = $(COMMON)
ASMFLAGS += $(CFLAGS)
ASMFLAGS += -x assembler-with-cpp -Wa,-gdwarf2

## Linker flags
LDFLAGS = $(COMMON)
LDFLAGS +=  -Wl,-Map=OBSTACLE_AVOIDER_1.map


## Intel Hex file production flags
HEX_FLASH_FLAGS = -R .eeprom

HEX_EEPROM_FLAGS = -j .eeprom
HEX_EEPROM_FLAGS += --set-section-flags=.eeprom="alloc,load"
HEX_EEPROM_FLAGS += --change-section-lma .eeprom=0 --no-change-warnings


## Objects that must be built in order to link
OBJECTS = OBSTACLE_AVOIDER_1.o 

## Objects explicitly added by the user
LINKONLYOBJECTS = 

## Build
all: $(TARGET) OBSTACLE_AVOIDER_1.hex OBSTACLE_AVOIDER_1.eep OBSTACLE_AVOIDER_1.lss size

## Compile
OBSTACLE_AVOIDER_1.o: ../OBSTACLE_AVOIDER_1.c
	$(CC) $(INCLUDES) $(CFLAGS) -c  $<

##Link
$(TARGET): $(OBJECTS)
	 $(CC) $(LDFLAGS) $(OBJECTS) $(LINKONLYOBJECTS) $(LIBDIRS) $(LIBS) -o $(TARGET)

%.hex: $(TARGET)
	avr-objcopy -O ihex $(HEX_FLASH_FLAGS)  $< $@

%.eep: $(TARGET)
	-avr-objcopy $(HEX_EEPROM_FLAGS) -O ihex $< $@ || exit 0

%.lss: $(TARGET)
	avr-objdump -h -S $< > $@

size: ${TARGET}
	@echo
	@avr-size -C --mcu=${MCU} ${TARGET}

## Clean target
.PHONY: clean
clean:
	-rm -rf $(OBJECTS) OBSTACLE_AVOIDER_1.elf dep/* OBSTACLE_AVOIDER_1.hex OBSTACLE_AVOIDER_1.eep OBSTACLE_AVOIDER_1.lss OBSTACLE_AVOIDER_1.map


## Other dependencies
-include $(shell mkdir dep 2>/dev/null) $(wildcard dep/*)

