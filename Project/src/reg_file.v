/*
Name    : Osaid Hasan Nur
ID      : 1210733
Dr      : Dr. Abdallatif Abuissa
Section : 2
*/

//*********************************************************************************************************
// Register File
//*********************************************************************************************************

module reg_file (clk,valid_opcode, addr1, addr2, addr3, in , out1, out2); 
	input clk , valid_opcode;
	input [4:0] addr1, addr2, addr3;  
	input signed [31:0] in ;			
	output reg signed [31:0] out1, out2; 
   	reg  signed [31:0]mem [31:0] ;
	
	// fill the memory with the values given in the specification of project 
	initial begin 
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
	end
	
	// the read operation don't need clock to work , and this reduces the number of clocks to finish the instruction
	always@(*)begin
	if(valid_opcode)begin 	
		 out1 <= mem[addr1] ;
	     out2 <= mem[addr2] ;
		end
	end
	
	// at the positive edge of the clock , it only writes the value
	// of register "in" to the memory , all previous actions will happen only
	// if the passed opcode is valid , if it isn't , we will have no change of the memory
	always@(posedge clk)begin 
		if(valid_opcode)begin 	
			 mem[addr3] = in ;
		 end
		end
endmodule	