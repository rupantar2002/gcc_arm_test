# compiler name
CC=arm-none-eabi-gcc

# Processor type
CPU=cortex-m4

# C stadard
CSTAND=gnu11

# Optimization level
OPTIMIZATION_LVL=0


# Compiler flags
CFLAGS= -c -mcpu=$(CPU) -mthumb -std=$(CSTAND) -O$(OPTIMIZATION_LVL) -Wall

# all 
all:clean main.o led.o stm32_startup.o

# Create main.o (Relocatable file)
main.o:main.c
	$(CC) $(CFLAGS) main.c -o main.o
	
# Alternative options
#	$^ -o $@ <DEPENDENCY> -o <TARGET>
#	-o $@ $^ -o <TARGET>  <DEPENDENCY> 

# Create led.o (Relocatable file)
led.o:led.c
	$(CC) $(CFLAGS) -o $@ $^

# Create stm32_startup.o (Relocatable file)
stm32_startup.o:stm32_startup.c
	$(CC) $(CFLAGS) -o $@ $^

.PHONY: clean
clean:
	rm -rf *.o *.elf
