; bootloader.asm - ������ GRUB2 ����������֧�ֶ���������ջָ������

section .text
align 4
global _start
extern main

; ��������ͷ (Multiboot Header)
multiboot_header:
    dd 0x1BADB002          ; ħ������ (Multiboot 1)
    dd 0x00000003          ; ��־ (���롢�ڴ���Ϣ)
    dd -(0x1BADB002 + 0x00000003) ; У���

_start:
    ; ����ջָ��
    mov esp, stack_top      ; ����ջָ��Ϊջ�Ķ�����ַ

    ; �����ں˵� main ����
    call main

    ; ��������ѭ������ִֹ�к�������
hang:
    jmp hang                ; ������ѭ������ֹ�����������

section .bss
    ; Ϊջ���� 8KB �ռ�
    resb 10240              ; ���� 8KB �ڴ���Ϊջ�ռ�

; ջ��λ�� (ջ�Ķ���ָ������)
stack_top:

; �������������ȷ�� .note.GNU-stack �Ĵ�СΪ 0
section .note.GNU-stack,"",@progbits

; ȷ�� .note.GNU-stack ����ȷ����
section .note.GNU-stack noalloc
