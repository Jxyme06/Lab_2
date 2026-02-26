# C code reference and how they work together:
#
# C code that calls this file is:
#   int hamming_distance(char* string_1, char* string_2)
#
# By the standard rules for integer/pointer arguments passed, the order for registers is:
#   1st -> RDI, 2nd -> RSI, 3rd -> RDX, 4th -> RCX, 5th -> R8, 6th -> R9
#   Return value in return register which is rax
# So,
#   char* string_1 = %rdi
#   char* string_2 = %rsi
#   return value in rax register

.section .text
.globl hamming_distance

hamming_distance:
    xorq %rax, %rax      # Clear the rax register

loop_chars:
    movb  (%rdi), %cl       # Move the ASCII value of the current character of the first string stored at the address the %rdi register is pointing to (Give the cl register the essentially dereferenced byte at rdi which is basically the ASCII value of the character)
    movb  (%rsi), %dl       # Move the ASCII value of the current character of the second string to the dl register

    # If the current character has a value of 0, terminate the program (null character terminator has a value of 0b00000000)
    cmpb $0, %cl
    je done
    cmpb $0, %dl           
    je done

    xorb %dl, %cl        # Check by how many bits the characters differ and store the result in the cl register
    movb $8, %r8b        # Initialize loop counter = 8

# Count all bits in cl using 8 shifts and comparing the lowest each time
check_bits:
    testb $1, %cl            # Check if the lowest bit differed or not (1 means they were different so increase hamming distance and 0 means they were the same) 
    jz bit_was_zero          # If the bit was 0 they were the same so jump to not increase the hamming distance
    incq %rax                # Increase the total hamming distance by 1

bit_was_zero:
    shrb $1, %cl             # Shift right by 1 so the next bit becomes lowest
    decb %r8b                # Decrement the counter by 1
    jne check_bits           # If the counter hits 0 go to repeat this process for the next byte(character)

    incq %rdi                # Increment the rdi by 1 which sets it to the next character in the string
    incq %rsi                # Increment the rsi by 1 which sets it to the next character in the string
    jmp loop_chars           # Restart the loop for the next character

done:
    ret                      # Return the hamming distance (returns the rax register)

.section .note.GNU-stack,"",@progbits           # Avoid executable stack warning
