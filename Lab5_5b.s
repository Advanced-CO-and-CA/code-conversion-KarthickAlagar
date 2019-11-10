@ BSS section
.bss
z: .word
@ DATA SECTION
.data

STRING: .asciz "11010070" 
NUMBER:  .word 0
ERROR:  .word 0
	   
@ TEXT section
    .text

.global _main


_main:
	LDR R1,=STRING 		; @get the address of String
	EOR R3,R3,R3	
	EOR R4,R4,R4
	
StringLOOP: 				; @FOR EACH CAHARACTER IN THE STRING
		LDRB R5,[R1],#1 	; @Load each character of the string
		CMP R5, #0		; @compare whether it is End of String
		BEQ Exit		; @Branch to Exit, if the String ends
		CMP R5, #0X30		; @compare whether it is 0
		BEQ AddtoNumber		; @Branch to AddtoNumber
		CMP R5, #0X31		; @compare whether it is 1
		BEQ AddtoNumber		; @Branch to AddtoNumber
		
		MOV R3, #0x00		; @Clear the output
		MOV R4, #0xFF		; @Set the error
		B Exit
AddtoNumber:
		SUB R5,R5, #0X30	;@get the value of 0 or 1
		MOV R3, R3, LSL#4	;@Left shift 
		ADD R3, R3, R5		; @Add  0 or 1 to R3
		B StringLOOP
		 		
Exit:
	LDR R6, =NUMBER		; @Load the address of NUMBER
	STR R3, [R6]		; @Store the result in NUMBER
	
	LDR R6, =ERROR		; @Load the address of ERROR
	STR R4, [R6]		; @Store the result in ERROR
 	SWI 0x11
	.end
