`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2020 16:54:04
// Design Name: 
// Module Name: tb_Multiplier
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


module tb_Multiplier();

reg[0:31]a1,b1;
reg[0:31]a2,b2;
reg[0:31]a3,b3;
reg[0:31]a4,b4;
reg[0:31]a5,b5;
wire [0:31] out1,out2,out3,out4,out5;

float_multiplier inst1(a1,b1,out1);
float_multiplier inst2(a2,b2,out2);
float_multiplier inst3(a3,b3,out3);
float_multiplier inst4(a4,b4,out4);
float_multiplier inst5(a5,b5,out5);

initial begin

a1=32'b00111111011000010000011000100101; //0.879
b1=32'b11000001001000001110100000111110; //-10.0567
#20 $display("%b",out1);


a2=32'b10111111110010100000011100111011;//-1.57834567
b2=32'b01010001101110100100001110110111;//1.0E+11
#20 $display("%b",out2);

a3=32'b00000000000000000000000000000000; // 0
b3=32'b01000000011011001100110011001101; //3.7
#20 $display("%b",out3);

a4=32'b11000001100111010110100000111001; //-19.67589
b4=32'b01000001101001100100101011010111; //20.786542077
#20 $display("%b",out4);

a5=32'b10111111010001000001000110011010;//-0.76589356
b5=32'b00111111000010111111100111111000;//0.5467830
#20 $display("%b",out5);



end




endmodule
