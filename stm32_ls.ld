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
        *(.rodata)
        _etext = .; /* Store the value of '.' i.e Location Counter in symbol _etext */
    }>FLASH

    .data :
    {
        _sdata = .; /* Start of .data section */
        *(.data)
        _edata = .; /* End of .data section */
    }> SRAM AT > FLASH

    .bss :
    {
        _sbss = .; /* Start of .bss section */
        *(.bss)
        _ebss = .; /* End of .bss   section */
    }> SRAM 

}