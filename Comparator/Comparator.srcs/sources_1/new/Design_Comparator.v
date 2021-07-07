`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2020 14:12:25
// Design Name: 
// Module Name: float32_point_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shift_for_subtract(significand,Exponent_a,Significand,Exponent_out);
input [0:24] significand;
input [0:7] Exponent_a;
output reg [0:24] Significand;
output [0:7] Exponent_out;
reg [0:4] shifter;

always @(significand)
begin
	casex (significand)
		25'b1_1xxx_xxxx_xxxx_xxxx_xxxx_xxxx :	begin
													Significand = significand;
									 				shifter = 5'd0;
								 			  	end
		25'b1_01xx_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin						
										 			Significand = significand << 1;
									 				shifter = 5'd1;
								 			  	end

		25'b1_001x_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin						
										 			Significand = significand << 2;
									 				shifter = 5'd2;
								 				end

		25'b1_0001_xxxx_xxxx_xxxx_xxxx_xxxx : 	begin 							
													Significand = significand << 3;
								 	 				shifter = 5'd3;
								 				end

		25'b1_0000_1xxx_xxxx_xxxx_xxxx_xxxx : 	begin						
									 				Significand = significand << 4;
								 	 				shifter = 5'd4;
								 				end

		25'b1_0000_01xx_xxxx_xxxx_xxxx_xxxx : 	begin						
									 				Significand = significand << 5;
								 	 				shifter = 5'd5;
								 				end

		25'b1_0000_001x_xxxx_xxxx_xxxx_xxxx : 	begin						// 24'h020000
									 				Significand = significand << 6;
								 	 				shifter = 5'd6;
								 				end

		25'b1_0000_0001_xxxx_xxxx_xxxx_xxxx : 	begin						// 24'h010000
									 				Significand = significand << 7;
								 	 				shifter = 5'd7;
								 				end

		25'b1_0000_0000_1xxx_xxxx_xxxx_xxxx : 	begin						// 24'h008000
									 				Significand = significand << 8;
								 	 				shifter = 5'd8;
								 				end

		25'b1_0000_0000_01xx_xxxx_xxxx_xxxx : 	begin						// 24'h004000
									 				Significand = significand << 9;
								 	 				shifter = 5'd9;
								 				end

		25'b1_0000_0000_001x_xxxx_xxxx_xxxx : 	begin						// 24'h002000
									 				Significand = significand << 10;
								 	 				shifter = 5'd10;
								 				end

		25'b1_0000_0000_0001_xxxx_xxxx_xxxx : 	begin						// 24'h001000
									 				Significand = significand << 11;
								 	 				shifter = 5'd11;
								 				end

		25'b1_0000_0000_0000_1xxx_xxxx_xxxx : 	begin						// 24'h000800
									 				Significand = significand << 12;
								 	 				shifter = 5'd12;
								 				end

		25'b1_0000_0000_0000_01xx_xxxx_xxxx : 	begin						// 24'h000400
									 				Significand = significand << 13;
								 	 				shifter = 5'd13;
								 				end

		25'b1_0000_0000_0000_001x_xxxx_xxxx : 	begin						// 24'h000200
									 				Significand = significand << 14;
								 	 				shifter = 5'd14;
								 				end

		25'b1_0000_0000_0000_0001_xxxx_xxxx  : 	begin						// 24'h000100
									 				Significand = significand << 15;
								 	 				shifter = 5'd15;
								 				end

		25'b1_0000_0000_0000_0000_1xxx_xxxx : 	begin						// 24'h000080
									 				Significand = significand << 16;
								 	 				shifter = 5'd16;
								 				end

		25'b1_0000_0000_0000_0000_01xx_xxxx : 	begin						// 24'h000040
											 		Significand = significand << 17;
										 	 		shifter = 5'd17;
												end

		25'b1_0000_0000_0000_0000_001x_xxxx : 	begin						// 24'h000020
									 				Significand = significand << 18;
								 	 				shifter = 5'd18;
								 				end

		25'b1_0000_0000_0000_0000_0001_xxxx : 	begin						// 24'h000010
									 				Significand = significand << 19;
								 	 				shifter = 5'd19;
												end

		25'b1_0000_0000_0000_0000_0000_1xxx :	begin						// 24'h000008
									 				Significand = significand << 20;
								 					shifter = 5'd20;
								 				end

		25'b1_0000_0000_0000_0000_0000_01xx : 	begin						// 24'h000004
									 				Significand = significand << 21;
								 	 				shifter = 5'd21;
								 				end

		25'b1_0000_0000_0000_0000_0000_001x : 	begin						// 24'h000002
									 				Significand = significand << 22;
								 	 				shifter = 5'd22;
								 				end

		25'b1_0000_0000_0000_0000_0000_0001 : 	begin						// 24'h000001
									 				Significand = significand << 23;
								 	 				shifter = 5'd23;
								 				end

		25'b1_0000_0000_0000_0000_0000_0000 : 	begin						// 24'h000000
								 					Significand = significand << 24;
							 	 					shifter = 5'd24;
								 				end
		default : 	begin
						Significand = (~significand) + 1'b1;
						shifter = 8'd0;
					end

	endcase
end
assign Exponent_out = Exponent_a - shifter;

endmodule

module float32_point_adder(A,B,C);
input [0:31] A,B;
output [0:31] C;

wire exc;
wire op_sub_add;
wire c_enable;
wire output_sign;

wire [0:31] op_a,op_b,temp_c;
wire [0:23] significand_a,significand_b;
wire [0:7] exponent_diff;


wire [0:23] significand_b_add_sub;
wire [0:7] exponent_b_add_sub;
wire perform;
wire[0:7] exp_a,exp_b;
wire [0:24] significand_add;
wire [0:30] add_sum;

wire [0:23] significand_sub_complement;
wire [0:24] significand_sub;
wire [0:30] sub_diff;
wire [0:24] subtraction_diff; 
wire [0:7] exponent_sub;

//for operations always operand_a must not be less than operand_b
assign {c_enable,op_a,op_b} = (A[1:31] < B[1:31]) ? {1'b1,B,A} : {1'b0,A,B};

assign exp_a = op_a[1:8];
assign exp_b = op_b[1:8];

//exc flag sets 1 if either one of the exponent is 255.
assign exc = (&op_a[1:8]) | (&op_b[1:8]);

assign output_sign = op_a[0] ;

assign op_sub_add = ~(op_a[0] ^ op_b[0]);

//Assigining significand values according to Hidden Bit.
//If exponent is equal to zero then hidden bit will be 0 for that respective significand else it will be 1
assign significand_a = (|op_a[1:8]) ? {1'b1,op_a[9:31]} : {1'b0,op_a[9:31]};
assign significand_b = (|op_b[1:8]) ? {1'b1,op_b[9:31]} : {1'b0,op_b[9:31]};

//Evaluating Exponent Difference
assign exponent_diff = op_a[1:8] - op_b[1:8];

//Shifting significand_b according to exponent_diff
assign significand_b_add_sub = significand_b >> exponent_diff;

assign exponent_b_add_sub = op_b[1:8] + exponent_diff; 

//Checking exponents are same or not
assign perform = (op_a[1:8] == exponent_b_add_sub);

///////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------ADD BLOCK------------------------------------------//

assign significand_add = (perform & op_sub_add) ? (significand_a + significand_b_add_sub) : 25'd0; 

//Result will be equal to Most 23 bits if carry generates else it will be Least 22 bits.
assign add_sum[8:30] = significand_add[0] ? significand_add[1:23] : significand_add[2:24];

//If carry generates in sum value then exponent must be added with 1 else feed as it is.
assign add_sum[0:7] = significand_add[0] ? (1'b1 + op_a[1:8]) : op_a[1:8];

///////////////////////////////////////////////////////////////////////////////////////////////////////
//------------------------------------------------SUB BLOCK------------------------------------------//

assign significand_sub_complement = (perform & !op_sub_add) ? ~(significand_b_add_sub) + 24'd1 : 24'd0 ; 

assign significand_sub = perform ? (significand_a + significand_sub_complement) : 25'd0;

shift_for_subtract minus(significand_sub,op_a[1:8],subtraction_diff,exponent_sub);

assign sub_diff[0:7] = exponent_sub;

assign sub_diff[8:30] = subtraction_diff[2:24];

///////////////////////////////////////////////////////////////////////////////////////////////////////
//-------------------------------------------------OUTPUT--------------------------------------------//

//If there is no exc and operation will evaluate


assign temp_c = exc ? 32'b0 : ((!op_sub_add) ? {output_sign,sub_diff} : {output_sign,add_sum});
assign C = (A[0]==B[0])? temp_c : (A[1:31]!=B[1:31])? temp_c : 32'b0;
endmodule


module float_multiplier(
		input [0:31] a_operand,
		input [0:31] b_operand,
		output [0:31] result
		);

wire sign,product_round,normalised,zero;
wire [0:8] exponent,sum_exponent;
wire [0:22] product_mantissa;
wire [0:23] operand_a,operand_b;
wire [0:47] product,product_normalised; //48 Bits
wire Exception,Overflow,Underflow;

assign sign = a_operand[0] ^ b_operand[0];

//Exception flag sets 1 if either one of the exponent is 255.
assign Exception = (&a_operand[1:8]) | (&b_operand[1:8]);

//Assigining significand values according to Hidden Bit.
//If exponent is equal to zero then hidden bit will be 0 for that respective significand else it will be 1

assign operand_a = (|a_operand[1:8]) ? {1'b1,a_operand[9:31]} : {1'b0,a_operand[9:31]};

assign operand_b = (|b_operand[1:8]) ? {1'b1,b_operand[9:31]} : {1'b0,b_operand[9:31]};

assign product = operand_a * operand_b;			//Calculating Product

assign product_round = |product_normalised[9:31];  //Ending 22 bits are OR'ed for rounding operation.

assign normalised = product[0] ? 1'b1 : 1'b0;	

assign product_normalised = normalised ? product : product << 1;	//Assigning Normalised value based on 48th bit

//Final Manitssa.
assign product_mantissa = product_normalised[1:23] + (product_normalised[24] & product_round); 

assign zero = Exception ? 1'b0 : (a_operand==32'd0)? 1'b1: (b_operand==32'd0)? 1'b1:(product_mantissa == 23'd0 && exponent[0:8]==9'd0) ? 1'b1 : 1'b0;


assign sum_exponent = a_operand[1:8] + b_operand[1:8];

assign exponent = sum_exponent - 8'd127 + normalised;

assign Overflow = ((exponent[0] & !exponent[1]) & !zero) ; //If overall exponent is greater than 255 then Overflow condition.
//Exception Case when exponent reaches its maximu value that is 384.

//If sum of both exponents is less than 127 then Underflow condition.
assign Underflow = ((exponent[0] & exponent[1]) & !zero) ? 1'b1 : 1'b0; 

assign result = Exception ? 32'd0 : zero ? {sign,31'd0} : Overflow ? {sign,8'hFF,23'd0} : Underflow ? {sign,31'd0} : {sign,exponent[1:8],product_mantissa};


endmodule



module comp(a,b,gr);// comparing two values
  input [0:31] a,b;
  output [0:31] gr;
  wire[0:31] negb, diff;
  
  assign negb[0]= b[0]? 1'b0 : 1'b1;
  assign negb[1:31]=b[1:31];// negative of b is taken in order to subtract a and b using adder module
  
  float32_point_adder a1 (a,negb,diff);
  
  assign gr= diff[0]? b : (|diff[1:31])? a : b;// greater number is the output
  //if both are equal b is taken as output
endmodule

module comp_last_layer(in1,in2,in3,in4,in5,in6,in7, in8,in9,in10,o);// comparing 10 values of output layer
  input [0:31] in1,in2,in3,in4,in5,in6,in7,in8,in9,in10;
  output [0:3] o;
  wire[0:31] c1,c2,c3,c4,c5,c6,c7,c8,c9;
         
  comp a(in1,in2,c1);
  comp b(c1,in3, c2);
  comp c(c2,in4, c3);
  comp d(c3,in5, c4);
  comp e(c4,in6, c5);
  comp f(c5,in7, c6);
  comp g(c6,in8, c7);
  comp h(c7,in9, c8);
  comp i(c8,in10,c9);// Greatest value is taken as output
  assign o={c9==in10}? 'd9 : {c9==in9}? 'd8 :{c9==in8}? 'd7 :{c9==in7}? 'd6 :{c9==in6}? 'd5 :{c9==in5}? 'd4 :{c9==in4}? 'd3 :{c9==in3}? 'd2 :{c9==in2}? 'd1 : 'd0;
  
   
  
endmodule
