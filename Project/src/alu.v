/*
Name    : Osaid Hasan Nur
ID      : 1210733
Dr      : Dr. Abdallatif Abuissa
Section : 2
*/

//*********************************************************************************************************
// ALU module
//*********************************************************************************************************

module alu (opcode, a, b, result ); 
	input [5:0] opcode; 
	input signed [31:0] a, b; 
	output reg signed [31:0] result;
	
	// select the operation depending on the value of opcode 
	always@(*)begin
	case (opcode)
		//a+b
		6'd4: 
		assign result = a+b ; 
		
		//a xor b
		6'd5 :
		assign result = a ^ b ;
		
		//-a
		6'd6 :
		assign result = -a ; 
		
		//avg
		6'd7 :
		assign result = (a+b)/2 ;
		
		//abs(a)
		6'd8 :
		assign result = (a > 0) ? a : -a;
		
		//not a 
		6'd9 :
		assign result = ~a ; 
		
		// a and b
		6'd10 :	
		assign result = a & b ;
		
		//a-b
		6'd11:
		assign result = a-b ;
		
		// a or b 
		6'd12 :	
		assign result = a | b ;
		
		//max(a,b)
		6'd13 :
		assign result = (a > b) ? a : b;
		
		//min(a,b)
		6'd14 :	
		assign result = (a < b) ? a : b;
		
		default : result = result ;
	endcase
	end

endmodule