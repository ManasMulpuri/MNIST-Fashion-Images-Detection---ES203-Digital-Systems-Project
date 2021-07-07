`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2020 19:14:39
// Design Name: 
// Module Name: Tb_comparator
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


module Tb_comparator;
  reg [31:0] in0,in1,in2,in3,in4,in5,in6,in7,in8,in9;
  wire[0:3] highest;
  
  comp_last_layer inst  (in0,in1,in2,in3,in4,in5,in6,in7,in8,in9,highest);
  initial begin

    in0=32'b01000011011011011111110010101100;//237.987
    in1=32'b01000000111100000000000000000000; //7.5
    in2=32'b11000100010010000000000000000000; //-800
    in3=32'b11000011011011011111110010101100;//-237.987
    in4=32'b01001010010001010100100100010000;//3232323.9999
    in5=32'b00000000000000000000000000000000;//0
    in6=32'b11000011011011011111110010101100;//-237.987
    in7=32'b01000010010110111001100110011010;//54.9
    in8=32'b00110001110000111101100110111011;//0.0000000057
    in9=32'b10100010010111010101110001100110;//-0.000000000000000003
    
    #5 $display("%b",highest);
    
  end
endmodule
