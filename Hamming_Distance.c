#include <stdio.h>
#include <string.h>

// assembly function we will write in hamming.s
int hamming_distance(char* string_1, char* string_2);

int main() {
    // Initialize an array of 256 character which is basically a string of a maximum of 255 characters because of the null terminator
    char string_1[256];
    char string_2[256];

    // Prompt the user for the first string with a maximum of 255 characters
    printf("Enter first string: ");
    fgets(string_1, 256, stdin);

    // Prompt the user for the first string with a maximum of 255 characters
    printf("Enter second string: ");
    fgets(string_2, 256, stdin);

    // Remove the newline created by pressing enter to finish writing the strings
    string_1[strcspn(string_1, "\n")] = '\0';
    string_2[strcspn(string_2, "\n")] = '\0';

    // Call the assembly code which will compute and return the hamming distance
    int distance = hamming_distance(string_1, string_2);

    // Print the hamming distance
    printf("The hamming distance is %d\n", distance);
    return 0;
}