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
//find how much the exponent should change based on the most recent 1 in the significand
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

//here we put op_a > ob_b
assign {c_enable,op_a,op_b} = (A[1:31] < B[1:31]) ? {1'b1,B,A} : {1'b0,A,B};

assign exp_a = op_a[1:8];
assign exp_b = op_b[1:8];

//exc becomes 1 if any of the exponents is 255
assign exc = (&op_a[1:8]) | (&op_b[1:8]);
//sign of output will always take the sign of the bigger absolute balue
assign output_sign = op_a[0] ;
//based on the sign bits of both choosing what operation to perform
assign op_sub_add = ~(op_a[0] ^ op_b[0]);


assign significand_a = (|op_a[1:8]) ? {1'b1,op_a[9:31]} : {1'b0,op_a[9:31]};
assign significand_b = (|op_b[1:8]) ? {1'b1,op_b[9:31]} : {1'b0,op_b[9:31]};

//difference in both exponents
assign exponent_diff = op_a[1:8] - op_b[1:8];

//shift smaller significand so exponent matches that of the bigger one
assign significand_b_add_sub = significand_b >> exponent_diff;

assign exponent_b_add_sub = op_b[1:8] + exponent_diff; 

//Checking exponents are same or not
assign perform = (op_a[1:8] == exponent_b_add_sub);

//Addition

assign significand_add = (perform & op_sub_add) ? (significand_a + significand_b_add_sub) : 25'd0; 

//Result will be equal to Most 23 bits if carry generates else it will be Least 22 bits.
assign add_sum[8:30] = significand_add[0] ? significand_add[1:23] : significand_add[2:24];

//If carry generates in sum value then exponent must be added with 1 else feed as it is.
assign add_sum[0:7] = significand_add[0] ? (1'b1 + op_a[1:8]) : op_a[1:8];

//Subtraction

assign significand_sub_complement = (perform & !op_sub_add) ? ~(significand_b_add_sub) + 24'd1 : 24'd0 ; 

assign significand_sub = perform ? (significand_a + significand_sub_complement) : 25'd0;
//use function to change the exponent as there can be a drastic change in exponent while subtraction
shift_for_subtract minus(significand_sub,op_a[1:8],subtraction_diff,exponent_sub);

assign sub_diff[0:7] = exponent_sub;

assign sub_diff[8:30] = subtraction_diff[2:24];

//output


//if exc = 1 then output should be 0
assign temp_c = exc ? 32'b0 : ((!op_sub_add) ? {output_sign,sub_diff} : {output_sign,add_sum});
assign C = (A[0]==B[0])? temp_c : (A[1:31]!=B[1:31])? temp_c : 32'b0;
endmodule
