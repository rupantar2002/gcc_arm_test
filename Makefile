# compiler name
CC=arm-none-eabi-gcc

# Processor type
CPU=cortex-m4

# C stadard
CSTAND=gnu11

# Optimization level
OPTIMIZATION_LVL=0


# Compiler flags
CFLAGS= -c -mcpu=$(CPU) -mthumb -mfloat-abi=soft -std=$(CSTAND) -O$(OPTIMIZATION_LVL) -Wall


# Linker flags 
LDFLAGS = -mcpu=$(CPU) -mthumb --specs=nano.specs  -T stm32_ls.ld -Wl,-Map=final.map

# Linker flags (Semihopsting)
LDFLAGS_SH = -mcpu=$(CPU) -mthumb --specs=rdimon.specs  -T stm32_ls.ld -Wl,-Map=final.map


# all 
all: main.o led.o stm32_startup.o syscalls.o final.elf

# semi 
semi: main.o led.o stm32_startup.o final_sh.elf

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

# Create syscalls.o (Relocatable file)
syscalls.o:syscalls.c
	$(CC) $(CFLAGS) -o $@ $^

# Create final.elf (executable binary)
final.elf: main.o led.o stm32_startup.o syscalls.o
	$(CC) $(LDFLAGS) -o $@ $^

# Create final.elf (executable binary)
final_sh.elf: main.o led.o stm32_startup.o 
	$(CC) $(LDFLAGS_SH) -o $@ $^

.PHONY: clean
clean:
	rm -rf *.o *.elf

.PHONY: objdump
objdump:
	arm-none-eabi-objdump.exe -h final.elf

.PHONY: load
load:
	openocd -f board/stm32f4discovery.cfg

