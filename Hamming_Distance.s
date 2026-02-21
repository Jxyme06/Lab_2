.section .data
.global hamming_distance

msg_1:  .ascii "This is a test\n"
len_1 = . - msg_1
msg_2:  .ascii "of the emergency broadcast\n"
len_2 = . - msg_2
format_str: .ascii "Hamming Distance: %ld\n"

.section .text
.global _start
hamming_distance:

    # Move address values of the text into r8 and r9
    mov %rdi, %r8 # r8 = string_1
    mov %rsi, %r9 # r9 = string_2
    # Move the lengths of the 2 texts into r10 and r11
    mov %rdx, %r10 # r10 = len_1
    mov %rcx, %r11 # r11 = len_2


    mov %r10, %r12
    cmp %r11, %r10
    cmovg %r11, %r12


    # Initialize the counter for the actual character index of the strings
    mov $0, %rcx
    # Initialize the counter to count down to loop the total characters in the string later
    mov $0, %r13
    

    loop_start:

        # Move the first character into the al register and bl register
        movb (%r8, %rcx, 1), %al
        movb (%r9, %rcx, 1), %bl

        # If the bits differ increment the hamming
        xorb %al, %bl
        movzbq %bl, %rax

        popcnt %rax, %rax
        add %rax, %r13

        # Increase the index counter by 1 and decrease the character track by 1 to loop the correct number of times
        inc %rcx
        dec %r12
        jnz loop_start

    mov %r13, %rax
    ret