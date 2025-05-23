/*                                   main                                    */
#include "system.h"

/* You will need to code these up yourself!  */
unsigned char *memcpy(unsigned char *dest, const unsigned char *src, int count)
{
    for (int i = 0; i < count; i++)
    {
        *(dest + i) = *(src + i); // 修复：从 src 复制到 dest
    }
    return dest;
}

unsigned char *memset(unsigned char *dest, unsigned char val, int count)
{
    /* Add code here to set 'count' bytes in 'dest' to 'val'.
     *  Again, return 'dest' */
    for (int i = 0; i < count; i++)
    {
        *(dest + i) = val;
    }
    return dest;
}

unsigned short *memsetw(unsigned short *dest, unsigned short val, int count)
{
    /* Same as above, but this time, we're working with a 16-bit
     *  'val' and dest pointer. Your code can be an exact copy of
     *  the above, provided that your local variables if any, are
     *  unsigned short */
    for (int i = 0; i < count; i++)
    {
        *(dest + i) = val;
    }
    return dest;
}

int strlen(const char *str)
{
    /* This loops through character array 'str', returning how
     *  many characters it needs to check before it finds a 0.
     *  In simple words, it returns the length in bytes of a string */

    /*while循环版本
    int i = 0;
    while (1)
    {
        if (*(str + i) == 0)
            return i;
        else
            i++;
    }
    */

    ///* for循环版本
    int i;
    for (i = 0; *(str + i) != 0; i++)
    {
    }
    return i;
    //*/
}

/* We will use this later on for reading from the I/O ports to get data
 *  from devices such as the keyboard. We are using what is called
 *  'inline assembly' in these routines to actually do the work */
unsigned char inportb(unsigned short _port)
{
    unsigned char rv;
    __asm__ __volatile__("inb %1, %0" : "=a"(rv) : "dN"(_port));
    return rv;
}

/* We will use this to write to I/O ports to send bytes to devices. This
 *  will be used in the next tutorial for changing the textmode cursor
 *  position. Again, we use some inline assembly for the stuff that simply
 *  cannot be done in C */
void outportb(unsigned short _port, unsigned char _data)
{
    __asm__ __volatile__("outb %1, %0" : : "dN"(_port), "a"(_data));
}

/* This is a very simple main() function. All it does is sit in an
 *  infinite loop. This will be like our 'idle' loop */
void main()
{
    /* You would add commands after here */
    /* This is where you would add your code to initialize the
     *  hardware, and then load the kernel. You would also add
     *  your code to set up the GDT and IDT here. */
    /* This is where you would add your code to set up the GDT and IDT here. */

    init_video();             /* Initialize the video system */
    cls();                    /* Clear the screen */
    settextcolor(0x0F, 0x00); /* Set the text color to white on black */
    puts("\nHello World!\n"); /* Print a message to the screen */
    settextcolor(0x03, 0x0C);
    puts("Wish you a nice day!"); /* Print another message to the screen */

    /* ...and leave this loop in. There is an endless loop in
     *  'start.asm' also, if you accidentally delete this next line */
    for (;;)
        ;
}
