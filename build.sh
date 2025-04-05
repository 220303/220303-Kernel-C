#!/bin/bash
echo ""
echo "Clean up old files"
rm kernel.elf kernel.iso start.o main.o scrn.o iso/boot/kernel/kernel.elf
if [ $? -ne 0 ]; then
    echo "Error: Cleanup failed!"
    exit 1
fi
echo ""
echo "Now assembling, compiling, and linking My kernel:"
echo ""
echo "Use the nasm to assemble start.asm into start.o"
nasm -f elf32 -o start.o start.asm
echo ""
echo "Compile C sources"
i686-linux-gnu-gcc -m32 -ffreestanding -nostdlib -fno-pic -fno-pie -c -o main.o main.c
i686-linux-gnu-gcc -m32 -ffreestanding -nostdlib -fno-pic -fno-pie -c -o scrn.o scrn.c
echo ""
echo "Links all files into kernel.elf"
i686-linux-gnu-ld -m elf_i386 -T link.ld -o kernel.elf start.o main.o scrn.o
if [ $? -ne 0 ]; then
    echo "Error: Linking failed!"
    exit 1
fi
echo ""
echo "Done!"
echo "Copy the kernel.elf to a right position"
cp kernel.elf iso/boot/kernel/
if [ $? -ne 0 ]; then
    echo "Error: Copying kernel.elf failed!"
    exit 1
fi
echo "Grub the iso"
grub-mkrescue -o kernel.iso iso
if [ $? -ne 0 ]; then
    echo "Error: GRUB ISO creation failed!"
    exit 1
fi
