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
	
prompt: .asciiz "Enter a pair of integers"
prompt2:	.asciiz	"\nEnter a 1 or 0 "
output:	.asciiz	"array A[3][3]:"

A:	.space 36 #each -1

newline:	.asciiz		"\n"
line:	.asciiz "-----------"
space:	.asciiz " "
divider:	.asciiz "|"
X:		.asciiz "X"
O:		.asciiz "O"

#---------------------------------------------------------------------------------------------
# MAIN
#---------------------------------------------------------------------------------------------

main:

	#for comparison purposes to exit loop
	li $t9, -1 
	
	#Asks the user to input three integers
	la $a0, prompt
	jal printStr

#loops until the first and second input equals -1
loop1:	
	#stores first input into $t0
	jal getInput
	move $t0, $v0
	
	#stores second input stores input into $t1
	jal getInput
	move $t1, $v0
	
	#check if either input equals -1 to terminate loop
	beq $t9, $t0, checkIfExit
	beq $t9, $t1, checkIfExit
	
	
	
	
	j loop1

checkIfExit:
	#check if user inputs are both -1
	beq $t0, $t1, exit1
	
	#if only one input is -1, return to start of loop
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







