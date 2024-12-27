/*
Name    : Osaid Hasan Nur
ID      : 1210733
Dr      : Dr. Abdallatif Abuissa
Section : 2
*/

//*********************************************************************************************************
// TestBench module
//*********************************************************************************************************
module Design_tb ;
	reg clk ;
	reg [31:0]instruction ;
	wire [31:0]result ;
	reg signed [31:0]mem [31:0] ;
	reg [31:0]inst[0:22] = '{
	32'b00000000000111110001101010000100 , //1 add R31,R10,R3 	= 13070
	32'b00000000000111110001101010000101 , //2 xor R31,R10,R3	= 3310
	32'b00000000000111110000001010000110 , //3 neg R31,R10		= -6000
	32'b00000000000000000001101010000111 , //4 avg R0,R10,R3 	= 6535
	32'b00000000000000000000011111001000 , //5 abs R0,R31		= 6000
	32'b00000000000111110001101010001001 , //6 not R31,R10		= -6001
	32'b00000000000111110001101010001010 , //7 and R31,R10,R3	= 4880
	32'b00000000000111110001101010001011 , //8 sub R31,R10,R3	= -1070
	32'b00000000000111110001101010001100 , //9 or  R31,R10,R3	= 8190
	32'b00000000000111110001101010001101 , //10 max R31,R10,R3	= 7070
	32'b00000000000111110001101010001110 , //11 min R31,R10,R3	= 6000
	32'b00000000000111111001011111001011 , //12 sub R31,R31,R18	= -7200 = 6000-13200
	32'b00000000000001010000000101001000 , //13 abs R5,R5		= 3322
	32'b00000000000001010111101011001111 , //14 Invalid opcode (15) "we will check if reg file changed or not"
	32'b00000000000001010000000101001000 , //15 abs R5,R5		= 3322
	32'b00000000000111110000011111000110 , //16 neg R31,R31		= 7200
	32'b00000000000000000000000000000110 , //17 neg R0,R0		= -6000
	32'b00000000000111110000011111001101 , //18 max R31,R31,R0	= 7200
	32'b00000000000000000000000000001011 , //19 sub R0,R0,R0	= 0
	32'b00000000000000001100000000000101 , //20 xor R0,R0,R24	= 5338
	32'b00000000000111110000011000000110 , //21 neg R31,R24 	= -5338
	32'b00000000000000001100000000001101 , //22 max R0,R0,R24	= 5338
	32'b00000000000111111111111111001110   //23 min R31,R31,R31	= -5338
	} ;
	
	// This is task to calculate the expected result for any instruction , and we use it for verification
	task expected_result;
	input [31:0]cur_instruction ;
	output [31:0]res ;
	output ok ;
	reg [5:0]opcode ;
	reg [4:0]src1 , src2 , dest ;
	opcode=0 ; src1=0 ; src2=0 ; dest=0;ok=1 ;
		opcode = cur_instruction[5:0]; 
		src1 = cur_instruction[10:6] ;
		src2 = cur_instruction[15:11];
		dest= cur_instruction[20:16];
		
		case (opcode)
		
		//a+b
		6'd4:begin 
		assign res = mem[src1]+mem[src2] ; 
		mem[dest]= res ;
		end
		
		//a xor b
		6'd5 :begin
		assign res = mem[src1] ^ mem[src2] ;
		mem[dest]= res ;
		end
		
		//-a
		6'd6 :begin
		assign res = -mem[src1] ; 
		mem[dest]= res ;
		end
		
		//avg
		6'd7 :begin
		assign res = (mem[src1]+mem[src2])/2 ;
		mem[dest]= res ;
		end
		
		//abs(a)
		6'd8 :begin
		assign res = (mem[src1] > 0) ? mem[src1] : -mem[src1];
		mem[dest]= res ;
		end
		
		//not a 
		6'd9 : begin
		assign res = ~mem[src1] ; 
		mem[dest]= res ;
		end
		
		// a and b
		6'd10 :	begin
		assign res = mem[src1] & mem[src2] ;
		mem[dest]= res ;
		end
		
		//a-b
		6'd11:begin
		assign res = mem[src1]-mem[src2] ;
		mem[dest]= res ;
		end
		
		// a or b 
		6'd12 :begin	
		assign res = mem[src1] | mem[src2] ;
		mem[dest]= res ;
		end
		
		//max(a,b)
		6'd13 :	begin
		assign res = (mem[src1] > mem[src2]) ? mem[src1] : mem[src2];
		mem[dest]= res ;
		end
		
		//min(a,b)
		6'd14 :	begin
		assign res = (mem[src1] < mem[src2]) ? mem[src1] : mem[src2];
		mem[dest]= res ;
		end
		
		default:begin
			   ok=0 ;
			end
	   endcase

	endtask
	
	// integer i is to read the instructions from the array of instructions , and j to iterate over the array of instructions 
	integer i,j ;
	reg [31:0] expected_res ;
	
	// this array will contain all expected values from all instructions
	reg [31:0]expected[0:22] ;
	
	// this array contains a single bit for each instruction that decides the validity of the instruction
	reg valid_instruction[31:0] ;
	
	// this register will hold every expected result that will be compared to the actual result
	reg [31:0] final_expected ;
	
	// This instance will be called every time the instruction changed
	mp_top tt(clk,instruction,result) ;
	
	// the clock 
	always #10ns clk = ~clk;
	
	// a flag to determine if the result is same as expected result 			  
		reg accepted ;	
		
	// All the work is here 	
	initial begin
		clk=1 ;
		i=0 ;
		
	  // fill the memory with the values given in the specification of project 
	  mem[0] = 32'd0;
      mem[1] = 32'd12996;
      mem[2] = 32'd11490;
      mem[3] = 32'd7070;
      mem[4] = 32'd6026;	 	
      mem[5] = 32'd3322;
      mem[6] = 32'd10344;
      mem[7] = 32'd6734;
      mem[8] = 32'd15834;
      mem[9] = 32'd15314;
      mem[10] = 32'd6000;
      mem[11] = 32'd12196;
      mem[12] = 32'd11290;
      mem[13] = 32'd13350;
      mem[14] = 32'd2086;
      mem[15] = 32'd6734;
      mem[16] = 32'd7430;
      mem[17] = 32'd14102;
      mem[18] = 32'd13200;
      mem[19] = 32'd3264;
      mem[20] = 32'd2368;
      mem[21] = 32'd15846;
      mem[22] = 32'd11710;
      mem[23] = 32'd14736;
      mem[24] = 32'd5338;
      mem[25] = 32'd5544;
      mem[26] = 32'd1852;
      mem[27] = 32'd3898;
      mem[28] = 32'd16252;
      mem[29] = 32'd1048;
      mem[30] = 32'd5642;
      mem[31] = 32'd0;
	  
	  // this loop to calulate the expected values for all instructions and store them in the array "expected"
	  for(j=0;j<23;j++)begin
		  reg okk ;
		  expected_result(inst[j],expected_res,okk) ;
		  expected[j]=expected_res ;
		  valid_instruction[j]= okk ;
		end
	  
	  // start our program with the first instruction 	
	  instruction = inst[0] ;
	  final_expected = expected[0] ;
	  
	  // loop over 22 instructions in my array of instructions
		repeat(23)
		 #20ns begin 
			 // check if the value of result matches the value of expected result ,
			 accepted = (result == final_expected)? 1 : 0 ;
			 
			 if(~ valid_instruction[i])begin 
				$display("Time : %2d  || Instruction : %h  || Result : Invalid opcode! || Expected Result : Invalid opcode! || Status : %s" , $time,inst[i],(accepted==1)?"PASS":"FAIL");
				 // move to the next instruction 
				 instruction = inst[i+1] ; 
				 final_expected = expected[i+1] ;
				  
				 // increase the value of i to move to the next instrucion
			 	 i++ ;	
				 continue;
				
			 end
			 
			 
			 // print all information that we need to the terminal
			 // Add an extra space after the time if it is less than 100000 to align the output properly 
			 if($time <100000)
			 $display("Time : %2d   || Instruction : %h  || Result : %d     || Expected Result : %d     || Status : %s" , $time,inst[i],$signed(result),$signed(final_expected),(accepted==1)?"PASS":"FAIL");
			 else
			 $display("Time : %2d  || Instruction : %h  || Result : %d     || Expected Result : %d     || Status : %s" , $time,inst[i],$signed(result),$signed(final_expected),(accepted==1)?"PASS":"FAIL");
			 
			 // move to the next instruction 
			 instruction = inst[i+1] ; 
			 final_expected = expected[i+1] ;
				  
			 // increase the value of i to move to the next instrucion
		 	 i++ ;	
	   end
	
	end
	endmodule