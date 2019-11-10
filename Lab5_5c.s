@Standard binary coded decimal code is commonly known as a weighted 8421 BCD code, with 8, 4, 2 and 1 representing the weights of the different bits @starting from the most significant bit (MSB) and proceeding towards the least significant bit (LSB). The weights of the individual positions of the @bits of a BCD code are: 23 = 8, 22 = 4, 21 = 2, 20 = 1.

@ BSS section
.bss
z: .word
@ DATA SECTION
.data

STRING: .asciz "10010010010100101001011001111001" 
NUMBER:  .word 0
ERROR:  .word 0
	   
@ TEXT section
    .text

.global _main


_main:
	LDR R1,=STRING 		; @get the address of String
	EOR R3,R3,R3	
	EOR R4,R4,R4
	EOR R7,R7,R7
	MOV R6,#8 		; @NIBBLE Counter
	MOV R8,#10		;@to increase by one digit
	
StringLOOP: 				; @FOR EACH CAHARACTER IN THE STRING
		LDRB R5,[R1],#1 	; @Load each character of the string
		CMP R5, #0		; @compare whether it is End of String
		BEQ Exit		; @Branch to Done , if the String ends
		SUB R5,R5,#0X30		;@get the value of 0 or 1 			
		MUL R4,R6,R5		; @Multiply Nibble Counter with the binary value
		ADD R7,R7,R4		; @Add to get the Digit
		CMP R6, #1		; @compare whether it 3
		BEQ NIBBLEDone		; @Branch to Done , if the String ends	
		MOV R6,R6,LSR#1		; @Decrement Nibble Variable
		B StringLOOP
NIBBLEDone:
		MUL R3,R3,R8 		;@Mulitply 10 to increase by 1 digit
		ADD R3,R3,R7		; @Add  
		EOR R7,R7,R7
		MOV R6,#8 		; @reset NIBBLE Counter
		B StringLOOP
		 		
Exit:
	LDR R6, =NUMBER		; @Load the address of NUMBER
	STR R3, [R6]		; @Store the result in NUMBER
	SWI 0x11
	.end
