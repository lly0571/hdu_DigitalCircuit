`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 15:37:14
// Design Name: 
// Module Name: Taxi
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


module Taxi( 
       input start,
       input wating,
       input pause,
       input clk_100M,
       input [1:0]speedup,
       output [7:0]AN,
       output [7:0] seg);
 
       wire clk_1s,clk_1k,clk_001;
       
       Fdiv f(clk_100M,clk_1k,clk_1s,clk_001);
       
       wire [1:0]speedup_p;
       wire start_p;wire wating_p;wire pause_p;
       JoggleRemove j3(clk_001,pause,pause_p);
       JoggleRemove j2(clk_001,wating,wating_p);
       JoggleRemove j1(clk_001,start,start_p);
       
       
       JoggleRemove j4(clk_001,speedup[1],speedup_p[1]);
       JoggleRemove j5(clk_001,speedup[0],speedup_p[0]);
       
       work w(start_p,wating_p,pause_p,clk_1s,clk_1k,speedup_p,AN,seg);
       
       
endmodule
