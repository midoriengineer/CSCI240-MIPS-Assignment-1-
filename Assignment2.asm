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

#
#---------------------------------------------------------------------------------------------
# REGISTER USAGE: MAIN
#---------------------------------------------------------------------------------------------
# $a0 - temporarily stores values to be printed, moved, or calculated
# $v0 - temporarily stores user input
#
# $t0 - stores the first input integer
# $t1 - stores the second input integer
# $t2 - stores the third input integer
#
# $t3 - stores the total number of negative integers
# $t4 - stores the total number of zeros
# $t5 - stores the total number of positive integers
#
# $t7 - stores the number of integers in total (3)/ the divisor of the average
# $t8 - stores the quotient of the average
# $t9 - stores the remainder of the average
#
#---------------------------------------------------------------------------------------------
# VARIABLES
#---------------------------------------------------------------------------------------------
	.data
	
prompt1: .asciiz "Enter an integer: "
prompt2: .asciiz "Enter another integer: "
prompt3: .asciiz "Enter a 1 or 0: "
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
	
	#initialize array A's elements to -1
	la $t0, A
	li $t1, 1
	li $t2, 9
	move $t3, $t0
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

#Prints out output--------------------------------------------------
	la $a0, output
	jal printStr
	
	li $t1, 1
	li $t2, 9
	move $t3, $t0
print:	bgt $t1, $t2, exit2

	#print a x,o or space depending on if value of array elements
	beq 0($t3), -1, printSpace
	beq 0($t3), 1, printX
	beq 0($t3), 0, printO
	

printSpace:
	la $a0, space
	jal printStr
	j continuePrint

printX:
	la $a0, X
	jal printStr
	j continuePrint

printO:
	la $a0, O
	jal printStr


continuePrint:	
	addi $t1, $t1, 1
	addi $t3, $t3, 4
	
	beq $t1, 4, printLine
	beq $t1, 7, printLine
	beq $t1, 10, exit2
	
	la $a0, divider
	jal printStr
	
	j print
	
printLine: 
	la $a0, line
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







