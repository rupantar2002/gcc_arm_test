ENTRY(Reset_Handler)

MEMORY
{
    FLASH(rx):ORIGIN = 0x08000000,LENGTH = 1024K
    SRAM(rwx):ORIGIN = 0x20000000,LENGTH = 128K
}

SECTIONS
{
    .text :
    {
        *(.isr_vector)
        *(.text)
        *(.text.*)
        *(.rodata)
        *(.rodata.*)
        *(.init)
        *(.fini)
        . = ALIGN(4);
        _etext = .; /* Store the value of '.' i.e Location Counter in symbol _etext */
    }>FLASH

    .data :
    {
        _sdata = .; /* Start of .data section */
        *(.data)
        *(.data.*)
        _edata = .; /* End of .data section */
    }> SRAM AT > FLASH

    .bss :
    {
        _sbss = .; /* Start of .bss section */
        __bss_start__ = _sbss; /* Required for stdlib */
        *(.bss)
        *(.bss.*)
        _ebss = .; /* End of .bss   section */
        __bss_end__ = _ebss; /* Required for stdlib */
        . = ALIGN(4);
        end = .;/* Required for stdlib heap start */
    }> SRAM 

}