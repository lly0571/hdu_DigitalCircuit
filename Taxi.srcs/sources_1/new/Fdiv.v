`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 16:45:57
// Design Name: 
// Module Name: Fdiv
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


module Fdiv(
      input clk_100M,
      output reg clk_1K,
      output reg clk_1s,
      output reg clk_001
    );
   reg [8:0] counter1;
   reg [30:0] counter2;
   reg [30:0] counter3;
   always@( posedge clk_100M)
   begin       
      if(counter2==30'd50000000)
            begin
              clk_1s<=~clk_1s;
              counter2<=30'd0;
            end
       else 
           counter2<=counter2+1'b1;
   end
   
    
   always@(posedge clk_100M)
   begin
       if(counter1==9'd2000)
            begin
              clk_1K<=~clk_1K;
              counter1<=9'd0;
            end
       else 
           counter1<=counter1+1'b1;
   end
  
  always@( posedge clk_100M)
   begin       
      if(counter3==30'd5000000)
            begin
              clk_001<=~clk_001;
              counter3<=30'd0;
            end
       else 
           counter3<=counter3+1'b1;
   end
endmodule
