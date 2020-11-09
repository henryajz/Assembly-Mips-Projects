#Mips calculator lab2 team: Enri Agiazi Emanouil Mpavelas

.data
	msg1:.asciiz "\n Please Enter the 1st Number:\n"
	msg2:.asciiz "\n Please Enter the operation:\n"
	uinput: .space 2
	msg3:.asciiz "\n Please Enter the 2nd Number:\n"
	msg4:.asciiz "\n The result is :\n"
	errormsg:.asciiz "\n Invalid operation or answer.\n"
	msg5:.asciiz "\n Do you want to exit(y/n):\n"
	exitmsg:.asciiz "\n Exiting...\n"
	
.text
   main:
		li $v0,4						#Print msg1
		la $a0,msg1
		syscall	
				
		li $v0,5     						#Get first number
		syscall
		
		move $t0,$v0						#Save number to t0
		
		li $v0,4						#Print msg2		
		la $a0,msg2
		syscall
		
		li $v0,8						#Get operation
		la $a0,uinput
		li $a1,2
		syscall
							
		li $v0,4						#Print msg3
		la $a0,msg3
		syscall
		
		li $v0,5						#Get number integer
		syscall

		move $t1,$v0						#Save number to t1

		lb $t2,uinput
	

		beq $t2,43,addnumbers					#if uinput==+ then add
		beq $t2,45,subnumbers					#if uinput==- then sub
		beq $t2,42,multnumbers					#if uinput==* then mult
		beq $t2,47,divnumbers					#if uinput==/ then div								 
		
		j err							#else output error		
		
		
	#Labels
	
	addnumbers:
		add $s0,$t0,$t1						#Adds the numbers
		
		li $v0,4						#Prints msg4
		la $a0,msg4						
		syscall
		
		li $v0,1						#Prints the result
		move $a0,$s0						#Save result to $a0
		syscall
		
	j userAnswer							#Ask user answer
	
	
	subnumbers:
		sub $s0,$t0,$t1						#Subtracts the numbers
		
		li $v0,4						#Prints msg4
		la $a0,msg4
		syscall
		
		li $v0,1						#Prints the result
		move $a0,$s0						#Save result to $a0
		syscall
		
	j userAnswer							#Ask user answer
	
	
	multnumbers:
		mult $t0,$t1						#Multiplies the numbers
		mflo $s0						#Move result to $s0
		
		
		li $v0,4						#Prints msg4
		la $a0,msg4
		syscall
		
		li $v0,1						#Prints the result
		move $a0,$s0						#Save result to $a0
		syscall	
		
	j userAnswer							#Ask user answer


	divnumbers:
		div $s0,$t0,$t1						#Divides the numbers
		mflo $s0						#Move result to $s0
		
		li $v0,4
		la $a0,msg4
		syscall
		
		li $v0,1						#Prints the result
		move $a0,$s0						#Save result to $a0
		syscall
		
	j userAnswer							#Ask user answer


	err:
		li $v0,4						#Print errmsg
		la $a0,errormsg
		syscall
	
	j userAnswer							#Ask user for answer


	userAnswer:
		li $v0,4						#Print: Do you want to exit(y/n):
		la $a0,msg5
		syscall
		
		li $t1,'n'   				
		li $t3,'y'
		
		li $v0,8						#Get answer
		la $a0,uinput
		li $a1,2
		syscall		
		
		lb $t2,uinput
			
		beq $t2,$t1,jumpMain					#if uinput==n: go back to main
		beq $t2,$t3,endProgram					#if uinput==y: end the program
		j err							#else just to err


	jumpMain:
		j main							#Jump to main


	endProgram:
		li $v0,4						#Print: Do you want to exit(y/n):
		la $a0,exitmsg
		syscall
	
		li $v0,10						#End program
		syscall
