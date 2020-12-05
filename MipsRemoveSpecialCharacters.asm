.data 	
	msg: .asciiz "Enter string: \n"
	msg2:.asciiz "\n Do you want to exit(y/n):\n"
	msg3:.asciiz "New string:  "
	errormsg:.asciiz "\n Invalid operation or answer.\n"
	exitmsg:.asciiz "\n Exiting...\n"
	nextLine: .asciiz "\n"
	.align 2
	uinput: .space 100
	output: .space 100
.text	
	
	main:		
		li $v0,4
        	la $a0,nextLine
        	syscall
		
		
		jal Get_Input						#call Get_Input
		
		jal Process						#call Process
		
		jal Get_Output						#call Get_Output
		
		j userAnswer						#ask user to exit or not
		
#_________________________________Procedures________________________________________________________________	
	Get_Input:
		li $v0,4						#print msg
		la $a0,msg
		syscall	
		
									#read user input		
		li $v0,8
		la $a0,uinput	
		li $a1,100
		syscall
	
	jr $ra
		
#	$t0: counter for loop2	+8, to get access to each value of word  
#	$t1: store andress of uinput
#	$t2: temporary load word
#	$t3: used for word and character processing
#	$t4: store output
#	$t5: check for special characters !,$,% etc

	Process:
		la $t1,uinput							#load address of uinput in $t1
		la $t4,output							#load address of output in $t4
		
		addi $t5,$zero,0						#initialize $t5
		addi $t6,$zero,0						#initialize $t6
		
		loop:
								
			addi $t0,$zero,0					#initialize $t0 each time we renew word
			
			lw $t2,($t1)						#Load a word from uinput
			j loop2
		
		loop2:
			beq $t0,32,continue					#Continue to read new word
			
			srlv $t3,$t2,$t0					#Shift $t2 by $t0 to $t3
			andi $t3,$t3,0x000000FF					#Mask $t3 to get only one character
			
			beq $t3,10,endOfText					#if($t3=10)end loops
			
			#if $t3=0 1 2 3 4 5 6 7 8 9 then don't change
			beq $t3,48,dontChange					
			beq $t3,49,dontChange					
			beq $t3,50,dontChange					
			beq $t3,51,dontChange					
			beq $t3,52,dontChange					
			beq $t3,53,dontChange					
			beq $t3,54,dontChange					
			beq $t3,55,dontChange					
			beq $t3,56,dontChange					
			beq $t3,57,dontChange					

			# if $t3=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z then add 32
			beq $t3,65,add_32					
			beq $t3,66,add_32					
			beq $t3,67,add_32					
			beq $t3,68,add_32					
			beq $t3,69,add_32					
			beq $t3,70,add_32					
			beq $t3,71,add_32					
			beq $t3,72,add_32					
			beq $t3,73,add_32					
			beq $t3,74,add_32					
			beq $t3,75,add_32					
			beq $t3,76,add_32					
			beq $t3,77,add_32					
			beq $t3,78,add_32					
			beq $t3,79,add_32					
			beq $t3,80,add_32					
			beq $t3,81,add_32					
			beq $t3,82,add_32					
			beq $t3,83,add_32					
			beq $t3,84,add_32					
			beq $t3,85,add_32					
			beq $t3,86,add_32					
			beq $t3,87,add_32					
			beq $t3,88,add_32					
			beq $t3,89,add_32					
			beq $t3,90,add_32					

			# if $t3=a b c d e f g h i j k l m n o p q r s t u v w x y z then add 32
			beq $t3,97,dontChange					
			beq $t3,98,dontChange					
			beq $t3,99,dontChange					
			beq $t3,100,dontChange					
			beq $t3,101,dontChange					
			beq $t3,102,dontChange					
			beq $t3,103,dontChange					
			beq $t3,104,dontChange					
			beq $t3,105,dontChange					
			beq $t3,106,dontChange					
			beq $t3,107,dontChange					
			beq $t3,108,dontChange					
			beq $t3,109,dontChange					
			beq $t3,110,dontChange					
			beq $t3,111,dontChange					
			beq $t3,112,dontChange					
			beq $t3,113,dontChange					
			beq $t3,114,dontChange					
			beq $t3,115,dontChange					
			beq $t3,116,dontChange					
			beq $t3,117,dontChange					
			beq $t3,118,dontChange					
			beq $t3,119,dontChange					
			beq $t3,120,dontChange					
			beq $t3,121,dontChange					
			beq $t3,122,dontChange				
	
		j specialChar
	
		
		specialChar:
			beq $t5,1,ignore					#if($t5=1) ignore all other special characters 
			beq $t5,32,spacechar					#if($t5=space) go to spacechar

			addi $t5,$t5,1						#Flag for special character
				
			
			andi $t3,$t3,0						#make $t3=0
			addi $t3,$t3,32						#then add 32 for space character
			
			sb $t3,($t4)						#save character to output
			
			addi $t0,$t0,8						# $t0=$t0+8
			addi $t4,$t4,1						# $t4=$t4+8								
							
			j loop2
		spacechar:
			beq $t5,1,ignore					#if we have more than one spacebar ignore other spacebars
			
			sb $t3,($t4)						#save character to output
			
			addi $t0,$t0,8						
			addi $t4,$t4,1						
					
			addi $t5,$t5,1						#Flag for special character
			j loop2
			
		ignore:								#continue reading without saving the character
			addi $t0,$t0,8						
			j loop2
		
		add_32:								#add 32 to $t3 to make small
			andi $t5,$t5,0						#set flag for special character 0
			addi $t3,$t3,32											
			
			sb $t3,($t4)						#save character to output
				
			addi $t0,$t0,8
			addi $t4,$t4,1
			j loop2
		
		dontChange:
			andi $t5,$t5,0						#set flag for special character 0
			
			sb $t3,($t4)						#save character to output
			
			addi $t0,$t0,8
			addi $t4,$t4,1
			j loop2
		
		
		continue:
			addi $t1,$t1,4						
			j loop
		
		
		endOfText:
			sb $t3,($t4)						#save last character
			jr $ra																						
															
	Get_Output:
		li $v0,4							#print next line
        	la $a0,nextLine
        	syscall
        	
		li $v0,4							#Print msg3
        	la $a0,msg3
        	syscall
		
		li $v0,4							#print output
		la $a0,output			
		syscall
	jr $ra


#_____________________________________________________________Last_Lab___________________________________________________________________________
	userAnswer:
		li $v0,4						#Print: Do you want to exit(y/n):
		la $a0,msg2
		syscall
		
		li $v0,8						#Get answer
		la $a0,uinput
		li $a1,2
		syscall		
		
		lb $t2,uinput
			
		beq $t2,'n',jumpMain					#if uinput==n: go back to main
		beq $t2,'y',endProgram					#if uinput==y: end the program
		
	
		j err							#else just to err
	
	
	err:
		li $v0,4						#Print errmsg
		la $a0,errormsg
		syscall
	
	j userAnswer							#Ask user for answer
	
			
	jumpMain:
		j main							#Jump to main


	endProgram:
		li $v0,4						#Print: Do you want to exit(y/n):
		la $a0,exitmsg
		syscall
	
		li $v0,10						#End program
		syscall

