#---------------------------------------------------------------------------------------------
# INFO
#---------------------------------------------------------------------------------------------
# MIPS Assignment 2
# Naomi
# 12/07/22
#
#---------------------------------------------------------------------------------------------
# PROGRAM DESCRIPTION
#---------------------------------------------------------------------------------------------
# This programs takes in a row number and a column number for user input, and allows the user
# to input the value 1 or 0 into the 2D array A based on which column/row number they picked. 
# This program will keep repeating until the user enters -1 for both the row and column number.
# Afterwards, the loop terminates and prints a 2D board representation of the values entered
# into each element of the array A by the user. If the user input a 1 into the array, an X will 
# be printed to the board. If the user input 0, an O will be printed. If the user did not input
# anything into an array element, the only spaces will be printed.
#
#---------------------------------------------------------------------------------------------
# REGISTER USAGE: MAIN
#---------------------------------------------------------------------------------------------
# $a0 - temporarily stores values to be printed, moved, or calculated
# $v0 - temporarily stores user input
#
# $t0 - stores the address of the first element of array A
# $t3 - stores the address of various elements in array A at different points within a loop

# $t1 - temporarily stores the counter for loops through the array; stores the first input integer
# $t2 - temporarily stores the exit number for the counter for the array loops; stores the second input integer

# $t4 - temporarily stores user input of 1 or 0; 
# $t5 - used to store the number of columns for the calculations for the address of element A[$t1][$t2]
# $t6 -used to store word size for the calculations for the address of element A[$t1][$t2]
# $t7 - used to store overall calculations for the address of element A[$t1][$t2]
# $t8 - stores the contents of the address stored in $t3

# $t9 - stores the integer -1 for initialization and comparison purposes
#
#---------------------------------------------------------------------------------------------
# VARIABLES
#---------------------------------------------------------------------------------------------
	.data
	
prompt1: .asciiz "\nType -1 for the row number and -1 for the column number to terminate the loop.\nOtherwise type 0, 1, or 2 for the row number and 0, 1, or 2 for the column number.\nEnter a row number: "
prompt2: .asciiz "Enter a column number: "
prompt3: .asciiz "Enter either 0 or 1: "
output:	.asciiz	"\nContents of array A[3][3]:\n\n"

A:	.space 36 #each -1

line:	.asciiz "\n-----------\n"
space:	.asciiz "   "
divider:	.asciiz "|"
X:		.asciiz " X "
O:		.asciiz " O "

	.text
#---------------------------------------------------------------------------------------------
# MAIN
#---------------------------------------------------------------------------------------------

main:
	#for comparison purposes to exit loop
	li $t9, -1 
	
	#setup counter for loop
	la $t0, A
	li $t1, 1
	li $t2, 9
	move $t3, $t0
	#initialize array A's elements to -1
loop0:	bgt $t1, $t2, exit0
	sb $t9, 0($t3)
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	j loop0
exit0:

#loops until the first and second input equals -1
loop1:	

	#Asks the user to input an integer
	la $a0, prompt1
	jal printStr
	
	#stores first input into $t1
	jal getInput
	move $t1, $v0
	
	#Asks the user to input another integer
	la $a0, prompt2
	jal printStr
	
	#stores second input stores input into $t2
	jal getInput
	move $t2, $v0
	
	#check if either input equals -1 to terminate loop
	beq $t9, $t1, checkIfExit
	beq $t9, $t2, checkIfExit
	
	#check if either input is NOT equal to 0, 1 or 2 
	bgt $t1, 2, loop1
	bgt $t2, 2, loop1
	blt $t1, $zero, loop1
	blt $t2, $zero, loop1
	
	
	#Asks the user to input a 1 or 0 into array
	la $a0, prompt3
	jal printStr
	
	#stores input into $t4
	jal getInput
	move $t4, $v0
	
	#check if either input is NOT equal to 0 or 1
	bgt $t4, 1, loop1
	blt $t4, $zero, loop1
	
	#calculate the address of element A[$t1][$t2] into $t3
	move $t3, $t0
	li $t5, 3
	li $t6, 4
	mult $t1, $t5
	mflo $t7
	add $t7, $t7, $t2
	mult $t7, $t6
	mflo $t7
	add $t3, $t3, $t7
	
	#store contents of user input into A[$t1][$t2]
	sb $t4, 0($t3)
	
	j loop1

checkIfExit:
	#check if user inputs are both -1
	beq $t1, $t2, exit1
	
	#if only one input is -1, return to start of loop1
	j loop1
exit1:

#Prints output--------------------------------------------------
	la $a0, output
	jal printStr
	
	#setup counter for loop
	li $t1, 1
	li $t2, 9
	move $t3, $t0
print:	bgt $t1, $t2, exit2

	#print a x,o or space depending on if value of array elements
	lb $t8, 0($t3)
	beq $t8, -1, printSpace
	beq $t8, 1, printX
	beq $t8, 0, printO

continuePrint:	

	#update current address and counters
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	
	#if row ends, print long horizontal line
	beq $t1, 4, printLine
	beq $t1, 7, printLine
	beq $t1, 10, exit2
	
	#if line doesn't end, print out vertical divider
	la $a0, divider
	jal printStr
	
	j print
	
exit2:	
	# EL FIN
	li $v0, 10
	syscall
	
#---------------------------------------------------------------------------------------------
# REGISTER USAGE: SUBROUTINES
#---------------------------------------------------------------------------------------------
# $a0 - temporarily stores values to be printed
# $v0 - temporarily stores user input
#	
#---------------------------------------------------------------------------------------------
# SUBROUTINES
#---------------------------------------------------------------------------------------------

#----------------PRINT-----------------

#---Name: printStr
#---Desc: prints the string loaded into $a0 to the console
#---Param: $a0
#---Return: none
#---Registers used: $v0
printStr:
	li $v0, 4
	syscall
	jr $ra

#---Name: printLine
#---Desc: prints a long horizontal line loaded into $a0 to the console and then returns to the top of the print loop
#---Param: $a0
#---Return: none
#---Registers used: $v0
printLine: 
	la $a0, line
	jal printStr
	j print

#---Name: printSpace
#---Desc: prints three spaces loaded into $a0 to the console and then returns to the middle of the print loop
#---Param: none
#---Return: none
#---Registers used: $a0
printSpace:
	la $a0, space
	jal printStr
	j continuePrint

#---Name: printX
#---Desc: prints " X " loaded into $a0 to the console and then returns to the middle of the print loop
#---Param: none
#---Return: none
#---Registers used: $a0
printX:
	la $a0, X
	jal printStr
	j continuePrint

#---Name: printO
#---Desc: prints " O " loaded into $a0 to the console and then returns to the middle of the print loop
#---Param: none
#---Return: none
#---Registers used: $a0
printO:
	la $a0, O
	jal printStr
	j continuePrint
	
	
#----------------INPUT-----------------

#---Name: getInput
#---Desc: recieves user input and stores it into $v0
#---Param: $a0
#---Return: none
#---Registers used: $v0
getInput:
	li $v0, 5
	syscall
	jr $ra







