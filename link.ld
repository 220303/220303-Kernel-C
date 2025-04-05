/*                            link.ld                                  */
OUTPUT_FORMAT("elf32-i386")  /* 修复文件格式为 ELF */
ENTRY(_start)
phys = 0x00100000;
SECTIONS
{
  .text phys : AT(phys) {
    *(.multiboot_header)      /* 确保 Multiboot Header 包含在 .text 段中 */
    *(.text)
    *(.rodata)
    . = ALIGN(0x1000);        /* 对齐到 4KB */
  }
  .eh_frame : AT(phys + 0x1000) { /* 为 .eh_frame 分配单独空间 */
    *(.eh_frame)
    . = ALIGN(0x1000);        /* 对齐到 4KB */
  }
  .data : AT(phys + 0x2000) { /* 调整 .data 的起始地址 */
    *(.data)
    . = ALIGN(0x1000);        /* 对齐到 4KB */
  }
  .bss : AT(phys + 0x3000) {  /* 调整 .bss 的起始地址 */
    *(.bss)
    . = ALIGN(0x1000);        /* 对齐到 4KB */
  }
  end = .;                    /* 定义 end 符号，标识内核结束地址 */
}