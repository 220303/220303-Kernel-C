; bootloader.asm - 适用于 GRUB2 的引导程序，支持多重启动和栈指针设置

section .text
align 4
global _start
extern main

; 多重引导头 (Multiboot Header)
multiboot_header:
    dd 0x1BADB002          ; 魔法数字 (Multiboot 1)
    dd 0x00000003          ; 标志 (对齐、内存信息)
    dd -(0x1BADB002 + 0x00000003) ; 校验和

_start:
    ; 设置栈指针
    mov esp, stack_top      ; 设置栈指针为栈的顶部地址

    ; 调用内核的 main 函数
    call main

    ; 进入无限循环，防止执行后续代码
hang:
    jmp hang                ; 进入死循环，防止程序继续运行

section .bss
    ; 为栈分配 8KB 空间
    resb 10240              ; 分配 8KB 内存作为栈空间

; 栈顶位置 (栈的顶部指向这里)
stack_top:

; 添加以下声明以确保 .note.GNU-stack 的大小为 0
section .note.GNU-stack,"",@progbits

; 确保 .note.GNU-stack 段正确声明
section .note.GNU-stack noalloc
