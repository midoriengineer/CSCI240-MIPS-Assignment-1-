#---------------------------------------------------------------------------------------------
# INFO
#---------------------------------------------------------------------------------------------
# MIPS Assignment 1 
# Naomi
# 10/12/22
#
#---------------------------------------------------------------------------------------------
# PROGRAM DESCRIPTION
#---------------------------------------------------------------------------------------------
#
#
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
#
#
#
#
#---------------------------------------------------------------------------------------------
# VARIABLES
#---------------------------------------------------------------------------------------------
	.data
	
prompt: .asciiz "Enter three integers"

numOne:	.asciiz	"\nNo. 1: "
numTwo:	.asciiz	"No. 2: "
numThr:	.asciiz	"No. 3: "

negStr:	.asciiz "\n# of neg. integers: "
zerStr:	.asciiz "\n# of zeros: "
posStr:	.asciiz "\n# of pos. integers: "

avgStr:	.asciiz "\n\nAverage: "
maxStr:	.asciiz "\nLargest integer: "
minStr:	.asciiz "\nSmallest integer: "

space:	.asciiz " "
slash:	.asciiz "/ "

	.text
#---------------------------------------------------------------------------------------------
# MAIN
#---------------------------------------------------------------------------------------------

main:

	#Asks the user to input three integers
	la $a0, prompt
	jal printStr
	
	#prints first number prompt to user and stores input into $t0
	la $a0, numOne
	jal printStr
	jal getInput
	move $t0, $v0
	
	#prints first number prompt to user and stores input into $t1
	la $a0, numTwo
	jal printStr
	jal getInput
	move $t1, $v0
	
	#prints first number prompt to user and stores input into $t2
	la $a0, numThr
	jal printStr
	jal getInput
	move $t2, $v0
	
	#counts the number of positive, negative & zero integers and then prints it to console
	

	li $v0, 10
	syscall
	
#---------------------------------------------------------------------------------------------
# SUBROUTINES
#---------------------------------------------------------------------------------------------

#----------------PRINT-----------------

#prints the string loaded into $a0 to console
printStr:
	li $v0, 4
	syscall
	jr $ra

#prints the integer loaded into $a0 to console
printInt:
	li $v0, 1
	syscall
	jr $ra
	
#----------------INPUT-----------------

#recieves user input and stores it into $v0
getInput:
	li $v0, 5
	syscall
	jr $ra

#--------------COUNTING---------------

#checks if the integer stored in $a0 is positive, negative or zero and 
#then calls a function to count the integer type based on if $a0 is 
#equal to $zero, less than $zero or greater than $zero
countIntegerType:

	beq $a0, $zero, countZero
	blt $a0, $zero, countNeg
	bgt $a0, $zero, countPos
	jr $ra

#Adds a +1 to the negative integer count and stores it in $t3	
countNeg:
	addi, $t3, $t3, 1
	jr $ra

#Adds a +1 to the zero integer count and stores it in $t4		
countZero:
	addi, $t4, $t4, 1
	jr $ra

#Adds a +1 to the positive integer count and stores it in $t5	
countPos:
	addi, $t5, $t5, 1
	jr $ra