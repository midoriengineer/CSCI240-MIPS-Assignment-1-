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
output:	.asciiz	"array A[3][3]:"

A:	.space 36 #each -1

newline:	.asciiz		"\n"
line:	.asciiz "-----------"
space:	.asciiz " "
divider:	.asciiz "|"
X:		.asciiz "X"
O:		.asciiz "O"

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

#	li $t1, 1
#	li $t2, 9
#	move $t3, $t0
#loop00:	bgt $t1, $t2, exit00
#	lb $a0, 0($t3)
#	li $v0, 1
#	syscall
#	addi $t1, $t1, 1
#	addi $t3, $t3, 4
#	j loop00
#	
#exit00:

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
	mult $t7, $t1, $t5
	add $t7, $t7, $t2
	mult $t7, $t7, $t6
	add $t3, $t3, $t7
	
	
	
	
	
	
	j loop1

checkIfExit:
	#check if user inputs are both -1
	beq $t1, $t2, exit1
	
	#if only one input is -1, return to start of loop1
	j loop1
	
	
exit1:
		
	# EL FIN
	li $v0, 10
	syscall
	
#---------------------------------------------------------------------------------------------
# REGISTER USAGE: SUBROUTINES
#---------------------------------------------------------------------------------------------
# $a0 - temporarily stores values to be printed, moved, or calculated
# $v0 - temporarily stores user input
# $zero - used as a point of comparison to see if integers are positive, negative, zero, or if a remaincer exists
#
# $t0 - stores the first input integer
# $t1 - stores the second input integer
# $t2 - stores the third input integer
#
# $t3 - stores the total number of negative integers
# $t4 - stores the total number of zeros
# $t5 - stores the total number of positive integers
#
# $t6 - stores the sum of all the integers input by the user
# $t7 - stores the number of integers in total (3)/ the divisor of the average
# $t8 - stores the quotient of the average
# $t9 - stores the remainder of the average
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

#---Name: printInt
#---Desc: prints the integer loaded into $a0 to the console
#---Param: $a0
#---Return: none
#---Registers used: $v0
printInt:
	li $v0, 1
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







