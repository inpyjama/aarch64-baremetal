/**
 * Copyright © 2023 inpyjama.com. All Rights Reserved.
 * Author: Mahmad Bharmal <mahmad@inpyjama.com>
 */

#include "printf.h"

#define w32(addr, value) *((volatile unsigned int *) addr) = value
#define r32(addr) *((volatile unsigned int *) addr)

static unsigned int second_core_tag = 0;
static unsigned int third_core_tag = 0;
static unsigned int fourth_core_tag = 0;

int (*__read_char__)(void);
void (*__write_char__)(char c);

void uart_putc (const char c);

void set_read_char(int (*func)(void)) { __read_char__ = func; }
void set_write_char(void (*func)(char)) { __write_char__ = func; }

void uart_init (void) {
    w32(0xFE215004, 1);
    w32(0xFE215044, 0);
    w32(0xFE215060, 0);
    w32(0xFE21504c, 3);
    w32(0xFE215050, 0);
    w32(0xFE215044, 0);
    w32(0xFE215048, 0xC6);
    w32(0xFE215068, ((200000000/(115200*8))-1));
    w32(0xFE200004, ((2 << 12) | (2 << 15)));
    w32(0xFE215060, 3);

    // Register UART Tx function
    set_write_char(uart_putc);

}

void uart_putc (const char c) {
    while (!(r32(0xFE215054) & 0x20));
    w32(0xFE215040, (unsigned int) c);
}

void main()
{
    uart_init();
    printf("\r\n");
    printf("   ______\r\n");
    printf("  /  ||  \\\r\n");
    printf(" /   /\\   \\\r\n");
    printf("/___/  \\___\\\r\n");
    printf("\r\n");
    printf(" Welcome to inpyjama.com!\r\n");
    printf(" YouTube: https://tinyurl.com/inpyjama-aarch64\r\n");

    second_core_tag = 1;
    while(1);
}

void second_core_main(void)
{
    while (!second_core_tag);
    printf("2nd core alive\r\n");
    third_core_tag = 1;
    while(1);
}

void third_core_main(void)
{
    while (!third_core_tag);
    printf("3rd core alive\r\n");
    fourth_core_tag = 1;
    while(1);
}

void fourth_core_main(void) {
    while (!fourth_core_tag);
    printf("4th core alive\r\n");
    while(1);
}
