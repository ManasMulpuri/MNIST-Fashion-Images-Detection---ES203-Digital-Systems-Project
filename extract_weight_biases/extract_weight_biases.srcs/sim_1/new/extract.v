`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.11.2020 11:22:23
// Design Name: 
// Module Name: extract
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


module extract;
  reg [0:31]biases_h[0:15];
  reg [0:31]biases_o[0:9];
  reg [0:31]weights_h[0:12543];
  reg [0:31]weights_o[0:159];
  reg [0:31]inp_five[0:783];
  initial begin
    $readmemb("E:\\Study\\Python\\ES203Project\\HLayerBiasesfp1.txt",biases_h);
    $readmemb("E:\\Study\\Python\\ES203Project\\OLayerBiasesfp1.txt",biases_o);
    $readmemb("E:\\Study\\Python\\ES203Project\\HLayer_Weightsfp1.txt",weights_h);
    $readmemb("E:\\Study\\Python\\ES203Project\\OLayer_Weightsfp1.txt",weights_o);
    $readmemb("E:\\Study\\Python\\ES203Project\\testing\\7_fp.txt",inp_five);
    
  end
endmodule
