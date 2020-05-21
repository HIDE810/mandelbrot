#!/usr/bin/perl

print <<END;
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

int comma(void) __attribute__((noinline));
int comma(void)
{
    int c = getchar();
    if (c == EOF) {
         exit(0);
    }
    return c;
}

void period(int c) __attribute__((noinline));
void period(int c)
{
    putchar(c);
    fflush(stdout);
}

int main(void)
{
    uint8_t mem[30000] = {0};
    uint8_t* ptr = mem;
END

while (<>) {
    s/[^\+,-.<>\[\]]//g;
    s/\+/(*ptr)++;/g;
    s/-/(*ptr)--;/g;
    s/,/*ptr = comma();/g;
    s/\./period(*ptr);/g;
    s/</ptr--;/g;
    s/>/ptr++;/g;
    s/\[/while (*ptr) {/g;
    s/\]/}/g;
    print "    " . $_ . "\n";
}

print <<END;
}
END