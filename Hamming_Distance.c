#include <stdio.h>

extern unsigned char ram[]; // RAM declared in assembly
extern void fill_ram(void); // Assembly function

int main()
{
    char string_1[256], string_2[256];

    printf("Enter first string: ");
    fgets(string_1, 256, stdin);
    printf("Enter second string: ");
    fgets(string_2, 256, stdin);

    string_1[strcspn(string_1, "\n")] = 0;
    string_2[strcspn(string_2, "\n")] = 0;

    long len_1 = strlen(string_1);
    long len_2 = strlen(string_2);

    long result = hamming_dist(string_1, string_2, len_1, len_2);

    printf("The Hamming Distance is: %ld\n", result);

    return 0;
}