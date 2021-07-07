`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.10.2020 14:26:20
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
  
  reg [0:31]x;
  wire [0:31]a;
  
  relu Instance(x,a);
  
  initial begin
      
    ///file required for EPwave storage
    $dumpfile("dump.vcd");
    $dumpvars(1,testbench);
    
    x = 32'b0_10000010_00111000000000000000000;
    #300;
    $display("%b",x);
    $display("%b_%b_%b",a[0],a[1:8],a[9:31]);
  
    x = 32'b1_10000010_00111000000000000000000;
    #300;
    $display("%b",x);
    $display("%b_%b_%b",a[0],a[1:8],a[9:31]);
    
    x = 32'b0_00000000_00000000000000000000000;
    #300;
    $display("%b",x);
    $display("%b_%b_%b",a[0],a[1:8],a[9:31]);
  
  end
endmodule