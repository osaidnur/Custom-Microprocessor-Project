/*
Name    : Osaid Hasan Nur
ID      : 1210733
Dr      : Dr. Abdallatif Abuissa
Section : 2
*/

//*********************************************************************************************************
// mp_top module
//*********************************************************************************************************

module mp_top(clk, instruction , result ); 
	input clk;
	input [31:0] instruction;
	output reg signed [31:0] result ;
	reg [5:0]opcode;
	reg [4:0]src1 , src2 , dest ;
	reg signed [31:0] out1,out2 ;
	
	// this register works as enable regiester mentioned in the project description 
	reg valid ;
	
	//extract all information and operands from the instruction 
	always@(posedge clk)begin
		opcode=0 ; src1=0 ; src2=0 ; dest=0 ;
		opcode = instruction[5:0]; 
		src1 = instruction[10:6] ;
		src2 = instruction[15:11];
		dest= instruction[20:16];
		
		if(opcode <4 || opcode>14)begin 
		valid=0; 	
		end
		else valid=1 ; 
		end
		
		// pass the parameters to the register file , from this instance we will obtain the 
		// values of out1 and out2 immediatly which are the output from the read operation , and 
		// the value of result will be written on the register file 
		reg_file my_reg(clk, valid, src1, src2, dest, result, out1, out2); 

		
		// here , we pass the opcode to the alu with the outputs of register file
		//,and we are sure that the final result will be ready after this step  
		alu my_alu(opcode ,out1 , out2, result );
	
endmodule	  