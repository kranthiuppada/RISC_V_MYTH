# RISC_V_MYTH
About Summary of the RISC-V based MYTH workshop organized by VSD and Redwood EDA, including daily coding tasks from C to TL-Verilog and final CPU design.

## 📅 Workshop Day-wise Index

- [Day 1: Introduction to RISC-V ISA and GNU toolchain](https://github.com/kranthiuppada/RISC_V_MYTH/tree/main/LAB_WORK/Day_1)
- [Day 2: ABI and Basic Verification Flow](https://github.com/kranthiuppada/RISC_V_MYTH/tree/main/LAB_WORK/DAY_2)
- [Day 3: Combinational Logic using TL-Verilog and Makerchip](https://github.com/kranthiuppada/RISC_V_MYTH/tree/main/LAB_WORK/DAY_3)
- [Day 4: Basic RISC-V CPU Micro-architecture](https://github.com/kranthiuppada/RISC_V_MYTH/tree/main/LAB_WORK/DAY_4)
- [Day 5: Pipelined RISC-V CPU Implementation](https://github.com/kranthiuppada/RISC_V_MYTH/tree/main/LAB_WORK/DAY_5)


# Introduction to RISC-V ISA

RISC-V is an open standard instruction set architecture based on established reduced instruction set computer(RISC) principles. It was first started by Prof. Krste Asanović and graduate students Yunsup Lee and Andrew Waterman in May 2010 as part of the Parallel Computing Laboratory, at UC Berkeley. Unlike most other ISA designs, the RISC-V ISA is provided under open source licenses that do not require fees to use, which provides it a huge edge over other commercially available ISAs. It is a simple, stable, small standard base ISA with extensible ISA support, that has been redefining the flexibility, scalability, extensibility, and modularity of chip designs. This has made it easier and flexible for anyone to build a processor on his own at almost zero cost. 

## What’s Different About RISC-V?

   Comparing to ARM and X86, RISC-V has below advantages:

   - **Free:** RISC-V is open-source, there is no need to pay for the IP.
   - **Simple:** RISC-V is far smaller than other commercial ISAs.
   - **Modular:** RISC-V has a small standard base ISA, with multiple standard extensions.
   - **Stable:** Base and first standard extensions are already frozen. There is no need to worry about major updates.
   - **Extensibility:** Specific functions can be added based on extensions. There are many more extensions are under development, such as Vector.

# Summary of this workshop

******************************************************************************************************************************************************

<details>
  <summary>Day 1: Introduction to RISC-V ISA and GNU compiler toolchain</summary>

## Labs for Day 1  
**1. Simple c program for adding numbers between 1 to n**

    #include <stdio.h>

    int main() {
    int i, sum = 0, n = 5;
    for (i=1; i <= n; ++i) {
    sum += i; }
    printf("Sum of numbers from 1 to %d is %d\n", n, sum);
    return 0;

    }

This is the c code for adding numbers, make a file named sm1ton.c and paste this  in that file.

**Steps to run this**

1. Open the linux terminal and type
   
        gcc 1ton.c

3. And then type
  
        ./a.out
   
Then you will see the following output results

![image](https://github.com/user-attachments/assets/31b4a2ff-7d0a-46f8-b8c0-e601cfa2a2a8)

**2. Simulation of the same 1ton program but with Spike**

Run the following steps in terminal:

1. Open the terminal and type

        riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o 1ton.o 1ton.c        


2. Then type

        spike pk 1ton.o
        

Then you should see the same result as:

![image](https://github.com/user-attachments/assets/8e469627-92ab-4e73-9670-6e5e4ab942c8)

</details>

******************************************************************************************************************************************************

<details>
  <summary>Day 2: Introduction to ABI and basic verification flow</summary>

## Labs for Day 2
**1. simulating the 1 to n adder but using ABI**

Run the following steps in the terminal:
1. Open the terminal and make a file names 1to9_custom.c
2. and type this in it
   
        #include <stdio.h>

        extern int load(int x, int y); 

        int main() {
	        int result = 0;
       	        int count = 2;
    	        result = load(0x0, count+1);
    	        printf("Sum of number from 1 to %d is %d\n", count, result); 
        }


3. Also make another file named load.S. And type this in it

        .section .text
        .global load
        .type load, @function

        load:
	        add 	a4, a0, zero //Initialize sum register a4 with 0x0
	        add 	a2, a0, a1   // store count of 10 in register a2. Register a1 is loaded with 0xa (decimal 10) from main program
	        add	a3, a0, zero // initialize intermediate sum register a3 by 0
        loop:	add 	a4, a3, a4   // Incremental addition
	        addi 	a3, a3, 1    // Increment intermediate register by 1	
	        blt 	a3, a2, loop // If a3 is less than a2, branch to label named <loop>
	        add	a0, a4, zero // Store final result to register a0 so that it can be read by main program
	        ret

4. Then open the terminal and type this after going to the folder in which you have made the two files.

        riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o 1to9_custom.o 1to9_custom.c load.S

5. Then type

        spike pk 1to9_custom.o

Then you will see the following results after this:

![image](https://github.com/user-attachments/assets/43e37975-ee6d-4f8e-8bd2-844452451f75)

</details>

******************************************************************************************************************************************************

<details>
  <summary>Day 3: Digital Logic with TL-Verilog and Makerchip</summary>

# Day 3 – Digital Logic with TL-Verilog

## Topics Covered

### ➤ Logic Gates using TL-Verilog
Learned how to implement basic logic gates like AND, OR, NOT, and XOR using TL-Verilog. These gates form the foundation of digital circuit design.

### ➤ Makerchip IDE Introduction
Got familiar with the Makerchip platform, a web-based IDE for TL-Verilog. Explored live simulation, waveform viewing, and real-time logic visualization.

### ➤ Combinational Logic (Adders, Muxes)
Built combinational circuits such as adders and multiplexers that compute outputs purely based on the current inputs without memory or clock.

### ➤ Sequential Logic (Counters, Registers)
Designed logic that depends on clock cycles and stores state across time using registers. Created a basic counter to reinforce clocked logic.

### ➤ Pipelined Logic
Implemented pipelining using TL-Verilog’s timing abstraction. This helps in breaking large operations into stages to increase throughput.

### ➤ State Variables
Explored the use of `$`-prefixed signals to create and maintain state in TL-Verilog, like program counters and accumulators.


## Labs Completed
- Inverter
  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

		   $out = !$in;
  3. Then click on 'compile'.
- 2-input logic gates(eg:and gate)
  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

		   $out = $in1 && $in2 ;
  3. Then click on 'compile'.
- Vector addition
  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

		   $out[4:0] = $in1[3:0] + $in2[3:0];
  3. Then click on 'compile'.
- Multiplexers
  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

		   $out = $sel? $in1 : $in2;
  3. Then click on 'compile'.
- Combinational Calculator
  
  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

				$sum[31:0] = $val1[31:0] + $val2[31:0];
		   		$diff[31:0] = $val1[31:0] - $val2[31:0];
		   		$prod[31:0] = $val1[31:0] * $val2[31:0];
		   		$quot[31:0] = $val1[31:0] / $val2[31:0];
		​		$out[31:0] = $op[0] ? $sum : $op[1] ? $diff : $op[2] ? $prod : $qout ;

  3. Then click on 'compile'.

   space for screenshot
- Sequential Calculator:
 
  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

				$sum[31:0] = $val1[31:0] + $val2[31:0];
		   		$diff[31:0] = $val1[31:0] - $val2[31:0];
		   		$prod[31:0] = $val1[31:0] * $val2[31:0];
		   		$quot[31:0] = $val1[31:0] / $val2[31:0];
		​		$out[31:0] = $op[0] ? $sum : $op[1] ? $diff : $op[2] ? $prod : $qout ;
				$out[31:0] = $val1[31:0]

  3. Then click on 'compile'.
   screenshot
- Fibonacci Series:

  The Fibonacci Sequence is a sequence of whole numbers starting with two 1s, where each subsequent value in the sequence is the sum of the previous two values.

  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

			$val[15:0] = $reset ? 1 : >>1$val + >>2$val;

  3. Then click on 'compile'.
  
- Pipelining using TL-Verilog:
  
   **Pythagorean Theorem Pipeline**

  1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
  2. Go to editor and place the below TL-Verilog in place of //...

			 |calc
     			 @0
      			   $valid = & $rand_valid[1:0];  // Valid with 1/4 probability
                                      			 // (& over two random bits).
   
  			 // DUT (Design Under Test)
   			|calc
      			?$valid
        			 // Pythagoras's Theorem
        			 @1
            			$aa_sq[7:0] = $aa[3:0] ** 2;
           			 $bb_sq[7:0] = $bb[3:0] ** 2;
        			 @2
            			$cc_sq[8:0] = $aa_sq + $bb_sq;
        			 @3
            			$cc[4:0] = sqrt($cc_sq);
	    
   3. Then click on 'compile'.
 -Final calculator with validity and memory:
 
   1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
   2. Go to editor and place the below TL-Verilog in place of //...

		|calc
    		  @0
      		   $reset = *reset;
     		 @1
         		$valid[0:0] = $reset ? '0 : >>1$valid + 1;
         		$valid_or_reset = $valid || $reset;
         		$val2[31:0] = $rand2;
        		 $val1[31:0] = >>2$out;
         
     		 ?$valid_or_reset
         		@1
            		$sum[31:0] = $val2[31:0] + $val1[31:0];
            		$diff[31:0] = $val2[31:0] - $val1[31:0];
   			 $prod[31:0] = $val2[31:0] * $val1[31:0];
            		$div[31:0] = $val2[31:0] / $val1[31:0];

      		@2
      		?$valid_or_reset
         		@2
           		 $out[31:0] = $reset ? '0:
                  		    $op[2:0] == 0 ? $sum :
                   		   $op[2:0] == 1 ? $diff :
                      		$op[2:0] == 2 ? $prod :
                      		$op[2:0] == 3 ? $div :
                      		$op[2:0] == 4 ? >>2$mem : >>2$out;
            		$mem[31:0] = $reset ? '0:
                      		$op[2:0] == 5 ? $val1:
                      		>>2$mem;
	    
    3. Then click on 'compile'.

## References
- [Workshop Slides (Day 3)](https://github.com/stevehoover/RISC-V_MYTH_Workshop)

  
   </details>

******************************************************************************************************************************************************

<details>
  <summary>Day 4: Basic RISC-V CPU microarchitecture</summary>
  ## Basic structure of RISC-V CPU microarchitecture
  

#### PC MUX
In RISC-V, the PC MUX (Program Counter Multiplexer) is a circuit that selects the next instruction to be executed based on various factors, including the type of instruction.

#### Rd Imem
In RISC-V architecture, IMEM Rd refers to the Read operation from the Instruction Memory (IMEM). This operation fetches the instruction from memory, given an address provided by the Program Counter (PC), and sends it to the processor.

#### Decoder
In RISC-V, the decoder is a crucial component that translates binary instruction codes into the control signals needed for the processor to execute the instruction.

#### Read/Write register
These are the register in RISC-V for read and write memory. Their are 32 registers like this in a RISC-V microachitecture.

#### ALU 
ALU stands for Arithmetic Logic Unit, a fundamental component of a computer's central processing unit (CPU). It's responsible for performing arithmetic operations (like addition, subtraction, multiplication, division) and logical operations (like AND, OR, NOT, XOR) on binary data.

## Labs for day 4

**1. Fetch and Decode**
1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
2. Go to editor and place the below TL-Verilog in place of //...

 		  |cpu
     		 @0
       		  $reset = *reset;
       		  $pc[31:0] = >>1$reset ? '0 :  (>>1$pc + 32'd4);
         
     		 @1
     		    $imem_rd_en = ! $reset;
    		     $imem_rd_addr[M4_IMEM_INDEX_CNT - 1:0] = $pc[M4_IMEM_INDEX_CNT + 1:2];
         
         
         $instr[31:0] = $imem_rd_data[31:0];
         
         $is_i_instr = $instr[6:2] ==? 5'b0000x ||
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b00100;
         
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         $imm[31:0] = $is_i_instr ? { {21{$instr[31]}}, $instr[30:20] } :
                      $is_s_instr ? { {21{$instr[31]}}, $instr[30:25], $instr[11:7] } :
                      $is_b_instr ? { {20{$instr[31]}}, $instr[7], $instr[31:25], $instr[11:8], 1'b0 } :
                      $is_u_instr ? { $instr[31:12] , 12'b0 } : 
                      $is_j_instr ? { {12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0 } :
                      32'b0 ;
         
         
         $rs1[4:0] = $instr[19:15];
         $rs2[4:0] = $instr[24:20];
         $rd[4:0] = $instr[11:7];
         $funct7[6:0] = $instr[31:25];
         $funct3[2:0] = $instr[14:12];
         $opcode[6:0] = $instr[6:0];
         
         
         
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr  ;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr ;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
         
         
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
         
         $funct7_valid = $is_r_instr ;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
         
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
         
         $opcode_valid = $is_i_instr ||  $is_r_instr || $is_s_instr || $is_b_instr || $is_j_instr || $is_u_instr;
         ?$opcode_valid
            $opcode[6:0] = $instr[6:0];
         
         
         $dec_bits[10:0] = { $funct7[5], $funct3, $opcode };
         
         
         $is_add = $dec_bits ==? 11'b0_000_0110011;
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         $is_beq = $dec_bits ==? 11'bx_000_1100011;
         $is_bne = $dec_bits ==? 11'bx_001_1100011;
         $is_blt = $dec_bits ==? 11'bx_100_1100011;
         $is_bge = $dec_bits ==? 11'bx_101_1100011;
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;


	    
4. Then click on 'compile'.


**This TL-Verilog is used for making a basic RISC-V CPU architecture but only from the PC to the decoder.**

**2. Basic RISC-V based CPU which performs addition of number 1 to 9**

1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
2. Go to editor and place the below TL-Verilog in place of //...

			


		|cpu
     		 @0
        		 $reset = *reset;
         
        		 $pc[31:0] = (>>1$reset) ? 32'd0 : (>>1$pc + 32'd4);
         
        
     			 @1
   		
         		$imem_rd_addr[M4_IMEM_INDEX_CNT - 1:0] = $pc[M4_IMEM_INDEX_CNT + 1:2];
         
         		$imem_rd_en = !$reset;
         
        		 $instr[31:0] = $imem_rd_data[31:0];
         
         
         
         		$is_i_instr = $instr[6:2] ==? 5'b0000x ||
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b00100;
         
   		  $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
        		 $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
        		 $is_b_instr = $instr[6:2] ==? 5'b11000;
         
        		 $is_j_instr = $instr[6:2] ==? 5'b11011;
         
      		   $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         
         		$imm[31:0] = $is_i_instr ? { {21{$instr[31]}}, $instr[30:20] } :
                      $is_s_instr ? { {21{$instr[31]}}, $instr[30:25], $instr[11:7] } :
                      $is_b_instr ? { {20{$instr[31]}}, $instr[7], $instr[31:25], $instr[11:8], 1'b0 } :
                      $is_u_instr ? { $instr[31:12] , 12'b0 } : 
                      $is_j_instr ? { {12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0 } :
                      32'b0 ;
         
         
   
        $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr  ;
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
         
         
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr ;
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
         
         
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
         
         $funct7_valid = $is_r_instr ;
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
         
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
         
         $opcode_valid = $is_i_instr ||  $is_r_instr || $is_s_instr || $is_b_instr || $is_j_instr || $is_u_instr;
         ?$opcode_valid
            $opcode[6:0] = $instr[6:0];

         
        
         
         
         
         $dec_bits[10:0] = { $funct7[5], $funct3, $opcode };
         
         
         $is_add = $dec_bits == 11'b0_000_0110011;
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         
         
         $is_beq = $dec_bits ==? 11'bx_000_1100011;
         $is_bne = $dec_bits ==? 11'bx_001_1100011;
         $is_blt = $dec_bits ==? 11'bx_100_1100011;
         $is_bge = $dec_bits ==? 11'bx_101_1100011;
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;
         
         //read register file 
         
         
         
         $rf_wr_en = $rd_valid;
         $rf_wr_index[4:0] = $rd;
         
         
         $rf_rd_en1 = $rs1_valid;
         $rf_rd_index1[4:0] = $rs1;
         $rf_rd_en2 = $rs2_valid;
         $rf_rd_index2[4:0] = $rs2;
         
         
         $src1_value[31:0] = $rf_rd_data1;
         $src2_value[31:0] = $rf_rd_data2;
         
         //ALU 
         
         $result[31:0] = $is_addi ? ($src1_value + $imm) :
                         $is_add ? ($src1_value + $src2_value) :
                         32'bx;
         
         
         
         $taken_br = (! $is_b_instr) ? 1'b0 :
                      $is_beq ? ($src1_value == $src2_value) :
                      $is_bne ? ($src1_value != $src2_value) :
                      $is_blt ? ( ($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31]) ) :
                      $is_bge ? ( ($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31]) ) :
                      $is_bltu ? ($src1_value < $src2_value) :
                      $is_bgeu ? ($src1_value >= $src2_value) :
                      1'b0;
         
         
         $br_tgt_pc[31:0] = $pc + $imm;

3. Then click on 'compile'

**This TL-Verilog code is the final code for a basic 1 to 9 summer with the write and read register, ALU, Branch etc.**


</details>

******************************************************************************************************************************************************

<details>
  <summary>Day 5: Complete Pipelined RISC-V CPU micro-architecture</summary>

# Lab: The complete pipelined CPU

This is the link to my work [CPU](https://myth.makerchip.com/sandbox/02kfkhXA6/0k5hOVx#)

1. Go to [Makerchip](makerchip.com) and click on launch makerchip IDE.
2. Go to editor and place the below TL-Verilog in place of //...

   		|cpu
     		 @0
         $reset = *reset;
         $pc[31:0] = >>1$reset ? '0:
                     >>3$valid_taken_br || >>3$is_jal && >>3$valid_jump ? >>3$br_tgt_pc :
                     >>3$is_jalr && >>3$valid_jump ? >>3$jalr_tgt_pc :
                     >>3$valid_load?  >>3$inc_pc:
                     >>1$inc_pc;
                     
         $imem_rd_addr[M4_IMEM_INDEX_CNT - 1:0] = $pc[M4_IMEM_INDEX_CNT + 1:2];
         $imem_rd_en = !$reset;
      		@1
         		*passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
         		$instr[31:0] = $imem_rd_data;
        		 $inc_pc[31:0] = $pc + 4;
         
       		  $is_i_instr = $instr[6:2] ==? 5'b0000x ||
                       $instr[6:2] ==? 5'b001x0 ||
                       $instr[6:2] ==? 5'b11001 ||
                       $instr[6:2] ==? 5'b00100;
         
         $is_r_instr = $instr[6:2] ==? 5'b01011 ||
                       $instr[6:2] ==? 5'b011x0 ||
                       $instr[6:2] ==? 5'b10100;
         
         $is_s_instr = $instr[6:2] ==? 5'b0100x;
         
         $is_b_instr = $instr[6:2] ==? 5'b11000;
         
         $is_j_instr = $instr[6:2] ==? 5'b11011;
         
         $is_u_instr = $instr[6:2] ==? 5'b0x101;
         
         $imm[31:0] = $is_i_instr ? { {21{$instr[31]}}, $instr[30:20] } :
                      $is_s_instr ? { {21{$instr[31]}}, $instr[30:25], $instr[11:7] } :
                      $is_b_instr ? { {20{$instr[31]}}, $instr[7], $instr[30:25], $instr[11:8], 1'b0 } :
                      $is_u_instr ? { $instr[31:12] , 12'b0 } : 
                      $is_j_instr ? { {12{$instr[31]}}, $instr[19:12], $instr[20], $instr[30:21], 1'b0 } :
                      32'b0 ;

         
         $opcode_valid = $is_i_instr ||  $is_r_instr || $is_s_instr || $is_b_instr || $is_j_instr || $is_u_instr;
         ?$opcode_valid
            $opcode[6:0] = $instr[6:0];

         
         
         
         
         $rs1_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr; 
         ?$rs1_valid
            $rs1[4:0] = $instr[19:15];
            
         $rs2_valid = $is_r_instr || $is_s_instr || $is_b_instr; 
         ?$rs2_valid
            $rs2[4:0] = $instr[24:20];
         
         $funct7_valid = $is_r_instr; 
         ?$funct7_valid
            $funct7[6:0] = $instr[31:25];
            
         $rd_valid = $is_r_instr || $is_i_instr || $is_u_instr || $is_j_instr;
         ?$rd_valid
            $rd[4:0] = $instr[11:7];
            
         $funct3_valid = $is_r_instr || $is_i_instr || $is_s_instr || $is_b_instr;
         ?$funct3_valid
            $funct3[2:0] = $instr[14:12];
            
         $dec_bits[11:0] = {$funct7[5],$funct3,$opcode};
         
         $is_beq = $dec_bits ==?  11'bx_000_1100011;
         $is_bne = $dec_bits ==?  11'bx_001_1100011;
         $is_blt = $dec_bits ==?  11'bx_100_1100011;
         $is_bge = $dec_bits ==?  11'bx_101_1100011;
         $is_bltu = $dec_bits ==? 11'bx_110_1100011;
         $is_bgeu = $dec_bits ==? 11'bx_111_1100011;
         $is_addi = $dec_bits ==? 11'bx_000_0010011;
         $is_add = $dec_bits ==   11'b0_000_0110011;
         $is_load = $dec_bits ==?   11'bx_xxx_0000011;
         $is_lui = $dec_bits ==?   11'bx_xxx_0110111;
         $is_auipc = $dec_bits ==?   11'bx_xxx_0010111;
         $is_jal = $dec_bits ==?   11'bx_xxx_1101111;
         $is_jalr = $dec_bits ==?  11'bx_000_1100111;
         $is_sb = $dec_bits ==?  11'bx_000_0100011;
         $is_sh = $dec_bits ==?  11'bx_001_0100011;
         $is_sw = $dec_bits ==?  11'bx_010_0100011;
         $is_slti = $dec_bits ==?  11'bx_010_0010011;
         $is_sltiu = $dec_bits ==?  11'bx_011_0010011;
         $is_xori = $dec_bits ==?  11'bx_100_0010011;
         $is_ori = $dec_bits ==?  11'bx_110_0010011;
         $is_andi = $dec_bits ==?  11'bx_111_0010011;
         $is_slli = $dec_bits ==?  11'b0_001_0010011;
         $is_srli = $dec_bits ==?  11'b0_101_0010011;
         $is_srai = $dec_bits ==?  11'b1_101_0010011;
         $is_sub = $dec_bits ==?  11'b1_000_0110011;
         $is_sll = $dec_bits ==?  11'b0_001_0110011;
         $is_slt = $dec_bits ==?  11'b0_010_0110011;
         $is_sltu = $dec_bits ==?  11'b0_011_0110011;
         $is_xor = $dec_bits ==?  11'b0_100_0110011;
         $is_srl = $dec_bits ==?  11'b0_101_0110011;
         $is_sra = $dec_bits ==?  11'b1_101_0110011;
         $is_or = $dec_bits ==?  11'b0_110_0110011;
         $is_and = $dec_bits ==?  11'b0_111_0110011;
         
      		@2
        		 $br_tgt_pc[31:0] = $pc + $imm;
         
         $rf_rd_en1 = $rs1_valid;
         $rf_rd_index1[4:0] = $rs1;
         
         $rf_rd_en2 = $rs2_valid;
         $rf_rd_index2[4:0] = $rs2;
         $src1_value[31:0] = (>>1$rf_wr_index == $rf_rd_index1) && >>1$rf_wr_en  ?
                              >>1$rf_wr_data : $rf_rd_data1;
         $src2_value[31:0] = (>>1$rf_wr_index == $rf_rd_index2) && >>1$rf_wr_en  ?
                              >>1$rf_wr_data : $rf_rd_data2;
         
     		 @3
        		 $sltu_rslt = $src1_value < $src2_value;
        		 $sltiu_rslt = $src1_value < $imm;
         
         		$result[31:0] = $is_addi || $is_load || $is_s_instr? $src1_value + $imm :
                         $is_add ? $src1_value + $src2_value:
                         $is_andi ? $src1_value & $imm:
                         $is_ori ? $src1_value | $imm:
                         $is_xori ? $src1_value ^ $imm:
                         $is_slli ? $src1_value << $imm[5:0]:
                         $is_srli ? $src1_value >> $imm[5:0]:
                         $is_and ? $src1_value & $src2_value:
                         $is_or ? $src1_value | $src2_value:
                         $is_xor ? $src1_value ^ $src2_value:
                         $is_sub ? $src1_value - $src2_value:
                         $is_sll ? $src1_value << $src2_value[4:0]:
                         $is_srl ? $src1_value >> $src2_value[4:0]:
                         $is_sltu ? $src1_value < $src2_value:
                         $is_sltiu ? $src1_value < $imm:
                         $is_lui ? {$imm[31:12],'0}:
                         $is_auipc ? $pc + $imm :
                         $is_jal ? $pc + 4 :
                         $is_jalr ? $pc + 4 :
                         $is_srai ? { {32{$src1_value[31]}}, $src1_value} >> $imm[4:0]:
                         $is_slt ? ($src1_value[31] == $src2_value[31]) ? $sltu_rslt : {31'b0, $src1_value[31]}:
                         $is_slti ? ($src1_value[31] == $imm[31]) ? $sltiu_rslt : {31'b0, $src1_value[31]}:
                         $is_sra ? { {32{$src1_value[31]}}, $src1_value} >> $src2_value[4:0]:
                         32'bx;
                         
         $taken_br = $is_beq ? ($src1_value == $src2_value) :
                     $is_bne ? ($src1_value != $src2_value) :
                     $is_blt ? ($src1_value < $src2_value) ^ ($src1_value[31] != $src2_value[31]) :
                     $is_bge ? ($src1_value >= $src2_value) ^ ($src1_value[31] != $src2_value[31]) :
                     $is_bltu ? ($src1_value < $src2_value) :
                     $is_bgeu ? ($src1_value >= $src2_value) : 1'b0;
         
         $valid_taken_br = $valid && $taken_br;
         $valid_load = $valid && $is_load;
         
         $is_jump = $is_jal || $is_jalr;
         $valid_jump = $is_jump && $valid;
         
         $valid = !(>>1$valid_taken_br || >>2$valid_taken_br
                     || >>1$valid_load || >>2$valid_load
                     || >>1$valid_jump || >>2$valid_jump) ;
         
         $jalr_tgt_pc[31:0] = $src1_value + $imm; 
         
         $rf_wr_en = $rd!='0 && $rd_valid && $valid ; 
         $rf_wr_index[4:0] = >>2$valid_load ? >>2$rd : $rd;
         $rf_wr_data[31:0] = >>2$valid_load ? >>2$ld_data: $result ; 
     		 @4
       		  $dmem_wr_en = $is_s_instr && $valid;
         
       		  $dmem_addr[3:0] = $result[5:2];
         
       		  $dmem_wr_data[31:0] = $src2_value;
         
        		 $dmem_rd_en = $is_load;
         
     		 @5
		         $ld_data[31:0] = $dmem_rd_data;
	    
3. Then click on 'compile'.



</details>


******************************************************************************************************************************************************



 
