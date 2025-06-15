.section .text
.global load
.type load, @function

load:
	add a4, a0, zero // Intialize sum register a4 with 0x0.
	add a2 ,a0 ,a1   // store count of 10 in register a2 and register a1 is load with 0xa(decimal 10) from main program.
	add a3, a0, zero // intialize intermediate sum register a3 by 0.
loop: 	add a4, a3, a4  // incremental addition
	addi a3, a3, 1       //  increment intermediate register by 1
	blt a3, a2, loop     // if a3 less than a2, branch to label named <loop>
	add a0, a4, zero     // store final result to register a0 so that it can be read main program
	ret
