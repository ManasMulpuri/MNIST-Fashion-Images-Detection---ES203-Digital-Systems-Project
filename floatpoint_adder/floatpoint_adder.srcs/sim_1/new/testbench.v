`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2020 14:13:35
// Design Name: 
// Module Name: testbench
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

module testbench;
  
  reg [0:31]a,b;
  wire [0:31] c;
  
  float32_point_adder Instance(a,b,c);
  
  initial begin
      
    ///file required for EPwave storage
    $dumpfile("dump.vcd");
    $dumpvars(1,testbench);
    
    a = 32'b0_10000010_00111000000000000000000;//9.75
    b = 32'b0_01111110_00100000000000000000000;//0.5625
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);//excpected 01000001001001010000000000000000
  
    a = 32'b0_10000010_00111000000000000000000;//9.75
    b = 32'b1_01111110_00100000000000000000000;//-0.5625
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);// expected 01000001000100110000000000000000
    
    a = 32'b1_10000000_00100000000000000000000;//-2.25
    b = 32'b1_10000110_00001100001000000000000;//-134.0625
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);// expected 11000011000010000101000000000000
    
    a = 32'b0_10000000_11100000000000000000000;//3.75
    b = 32'b1_10000001_01001000000000000000000;//-5.125
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);// expected 10111111101100000000000000000000
    
    a = 32'b0_00000000_00000000000000000000000;//0
    b = 32'b1_10000001_01001000000000000000000;//-5.125
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);// 1_10000001_01001000000000000000000
    
    a = 32'b0_00000000_00000000000000000000000;//0
    b = 32'b0_00000000_00000000000000000000000;//0
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);// 0_00000000_00000000000000000000000
    
    a = 32'b1_10000001_01001000000000000000000;//-5.125
    b = 32'b0_10000001_01001000000000000000000;//5.125
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);// 0_00000000_00000000000000000000000
    
    a = 32'b0_10000001_01001000000000000000000;//-5.125
    b = 32'b1_10000001_01001000000000000000000;//5.125
    #100;
    $display("a %b",a);
    $display("b %b",b);
    $display("c %b_%b_%b",c[0],c[1:8],c[9:31]);// 0_00000000_00000000000000000000000
    
    
  end
endmodule
