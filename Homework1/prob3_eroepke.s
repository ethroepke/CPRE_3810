.data
str1: .asciiz "Enter first index:\n"
str2: .asciiz "Enter second index:\n"
str3: .asciiz "Enter third index (result storage):\n"
result_msg: .asciiz "The result has been stored.\n"
.align 2
vals: .word 25, 1, 4, 10, 381, 42, 100, 60, 0, 12

.text
.globl main

main:
    # Prompt for first index
    li $v0, 4                # system call for print_string
    la $a0, str1              # load address of prompt message
    syscall                   # print "Enter first index:"
    
    # Read first index
    li $v0, 5                # system call for read_int
    syscall                   # store user input in $v0
    sll $t0, $v0, 2           # multiply index by 4 (word size)
    
    # Load first value from array
    la $t1, vals              # load address of array vals
    addu $t1, $t1, $t0        # add offset (first index) to base address
    lw $t2, 0($t1)            # load value at index1 into $t2
    
    # Prompt for second index
    li $v0, 4                # system call for print_string
    la $a0, str2              # load address of second prompt message
    syscall                   # print "Enter second index:"
    
    # Read second index
    li $v0, 5                # system call for read_int
    syscall                   # store user input in $v0
    sll $t0, $v0, 2           # multiply index by 4 (word size)
    
    # Load second value from array
    la $t1, vals              # load address of array vals
    addu $t1, $t1, $t0        # add offset (second index) to base address
    lw $t3, 0($t1)            # load value at index2 into $t3
    
    # Calculate average of the two values
    addu $t4, $t2, $t3        # add values from index1 and index2
    sra $t4, $t4, 1           # divide sum by 2 (arithmetic right shift)
    
    # Prompt for third index (where the result will be stored)
    li $v0, 4                # system call for print_string
    la $a0, str3              # load address of third prompt message
    syscall                   # print "Enter third index:"
    
    # Read third index
    li $v0, 5                # system call for read_int
    syscall                   # store user input in $v0
    sll $t0, $v0, 2           # multiply index by 4 (word size)
    
    # Store the average value in the third index
    la $t1, vals              # load address of array vals
    addu $t1, $t1, $t0        # add offset (third index) to base address
    sw $t4, 0($t1)            # store average at index3
    
    # Print result message
    li $v0, 4                # system call for print_string
    la $a0, result_msg        # load address of result message
    syscall                   # print "The result has been stored."
    
    # Exit program
    li $v0, 10                # system call for exit
    syscall

