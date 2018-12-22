.text
.globl _echo

_echo:
	#General starting format 
	pushl %ebp
	movl %esp, %ebp
	subl 8(%ebp), %esp
	movl 8(%ebp), %edx

LOOP1:
	addl $5, %edx			#get to the line status 

LOOP2:
	inb (%dx), %al 			#get data ready
	andb  $0x01, %al 		#read character
	jz    LOOP2			#if zero, do the loop again

	subl $5, %edx			#send edx to original position
	inb  %dx, %al 			#read character
	cmpb 12(%ebp), %al 		#compares ebp and al 
	jz DONE				#if zero, go to done

	outb %al, %dx			#gives the result			
	jmp LOOP1			#start the process all over

DONE:	
	#General ending format
	movl %ebp, %esp 		#Give EBP the value of ESP which contains EAX
	popb %ebp 				#Return the counter 
	ret
.end
