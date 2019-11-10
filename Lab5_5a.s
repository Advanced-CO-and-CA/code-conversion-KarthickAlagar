
@ bss section

    .bss



@ data section

    .data

    A_DIGIT:  .word 0x43
    H_DIGIT:  .word 0

@ TEXT section

      .text



.globl _main

	LDR R4, = A_DIGIT     @Load the address of A_DIGIT
	LDR R0, [R4]	      @Load the Value of A_DIGIT


	CMP R0, #0x30
	BCC error @lessthan‘0’ 
        CMP R0, #0x39 
	BLS digit   @ between ‘0’ and ‘9’ 

	CMP R0, #0x41 
	BCC error 
	CMP R0, #0x46 
	BLS letter  @ between ‘A’ and ‘F’ 

	CMP R0, #0x61
	BCC error 
	CMP R0, #0x66 @ between ‘a’ and ‘f'
	BHI error 

	SUB R4, R0, #0x57	@subtract 0x57 from R0 of the ascii numbers a-f 
	B exit
	

letter:                

	SUB R4, R0, #0x37   @subtract 0x37 from R0 of the ascii numbers A-F
	B exit

digit: 

	SUB R4, R0 , #0x30	@subtract 0x30 from R0 of the ascii numbers 0-9 
	B exit

error:
	MOV R4,#0xFFFFFFFF

exit:
	LDR R1, =H_DIGIT	@store the result in H_DIGIT
        STR R4, [R1]
 	.end