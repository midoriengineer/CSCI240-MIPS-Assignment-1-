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
# $t7 - the number of integers in total (3)/ the divisor of the average
# $t8 - the quotient of the average
# $t9 - the remainder of the average
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
slash:	.asciiz "/"

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
	
	#counts the number of positive, negative & zero integers from the user input 
	# FIRST Integer
	la $a0, ($t0)
	jal countIntegerType
	# SECOND Integer
	la $a0, ($t1)
	jal countIntegerType
	# THIRD Integer
	la $a0, ($t2)
	jal countIntegerType
	
	#prints the number of integer types (pos, neg, zero) to the console
	# NEGATIVE INTEGERS
	la $a0, negStr
	jal printStr
	la $a0, ($t3)
	jal printInt
	# ZERO INTEGERS
	la $a0, zerStr
	jal printStr
	la $a0, ($t4)
	jal printInt
	# POSITIVE INTEGERS
	la $a0, posStr
	jal printStr
	la $a0, ($t5)
	jal printInt
	
	#find the average and then print the quotient ($t8)
	jal getAverage
	la $a0, avgStr
	jal printStr
	la $a0, ($t8)
	jal printInt
	#checks if the remainder needs to be printed and prints it if so
	jal checkRemainder

	
	# EL FIN
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

#----------------AVERAGE-----------------

#Stores the sum of the input integers ($t0,$t1,$t2) into $t6
#and then divides the sum by 3 ($t7) because there are three inputs to get the average.
#Next, it stores the quotient into $t8 and remainder into $t9.
getAverage:
	#find the average
	add $t6, $t0, $t1
	add $t6, $t6, $t2
	li $t7, 3
	div $t6, $t7
	
	#store the quotient and the remainder of the average
	mflo $t8
	mfhi $t9
	
	jr $ra

#Checks if the remainder ($t9) needs to be printed by seeing if it is greater than $zero
#If it is, then it calls the print subroutine
checkRemainder:
	bgt $t9, $zero, printRemainder
	jr $ra

#Prints the remainder of the average stored in $t9 as a fraction with $t7 as the divisor
printRemainder:
	#print space between remainder and quotient
	la $a0, space
	li $v0, 4
	syscall
	
	#print remainder
	la $a0, ($t9)
	li $v0, 1
	syscall
	
	#prints the slash of the fraction
	la $a0, slash
	li $v0, 4
	syscall
	
	#prints the divisor of the fraction
	la $a0, ($t7)
	li $v0, 1
	syscall
	
	jr $ra
