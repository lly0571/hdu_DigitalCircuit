`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/06 15:39:23
// Design Name: 
// Module Name: work
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


module work(
       input start,
       input wating,
       input pause,
       input clk_1s,
       input clk_1K,
       input [1:0]speedup,
       output reg[7:0] AN,
       output reg[7:0] seg
   );
   reg[3:0] watingtime;
   reg[15:0] mileage;
   reg[15:0] fare;
   
   always@(posedge clk_1s or negedge start or posedge wating)
   begin
      if(~start)
      begin
           mileage<=0;
       end
      else if(wating) 
         begin
         mileage<=mileage;
         end
      else if(pause)
         mileage<=mileage;
      else
         begin          
           if(speedup==2'b00)
              mileage<=mileage+1;
           else if(speedup==2'b01)
              mileage<=mileage+2; 
           else if(speedup==2'b10)
              mileage<=mileage+4; 
           else if(speedup==2'b11)
              mileage<=mileage+6;
         end
                
   end
   
   
   always@(posedge clk_1s or negedge start or posedge wating)
      begin
       if(~start)
       begin
           fare<=0; 
           watingtime<=0;
           end     
       else if(wating) 
         begin
            if(watingtime>=10)           
                  begin
                   fare<=fare+5; 
                   watingtime<=0;
                  end             
             else begin fare<=fare;watingtime<=watingtime+1;end
         end
      else if(pause)
        fare<=fare;
      else 
      begin
      watingtime<=0;
      if(mileage<30)
         fare<=60;
      else if(fare<=200)
         begin
         fare<=60+(mileage-30)/10*12;   
         end 
      else if(fare>200)
         begin
         fare<=204+(mileage-150)/10*18;
         end
      
      else fare<=fare;
      end
      end
     
    reg [2:0] bit_sel;
    reg[3:0] num;
    
    
     always @(posedge clk_1K )
                 bit_sel<=bit_sel+1'b1;
     always @(bit_sel)
              case(bit_sel)
                   3'b000:AN<=8'b11111110;
                   3'b001:AN<=8'b11111101;
                   3'b010:AN<=8'b11111011;
                   3'b011:AN<=8'b11110111;
                   3'b100:AN<=8'b11101111;
                   3'b101:AN<=8'b11011111;
                   3'b110:AN<=8'b10111111;
                   3'b111:AN<=8'b01111111;
              endcase      
      always @(bit_sel)
               case(bit_sel)
                   3'b000:num<=mileage%10;
                   3'b001: num<=mileage/10%10;
                   3'b010: num<=mileage/100%10;
                   3'b011:num<=mileage/1000%10;             
                   3'b100:num<=fare%10;
                   3'b101: num<=fare/10%10;
                   3'b110: num<=fare/100%10;
                   3'b111: num<=fare/1000%10;   
               endcase  
          
                       
      always @(num)
      if(num<10)
         if(bit_sel==3'b001||bit_sel==3'b101)
               case(num) 
                  0:seg<=8'b00000010;
                  1:seg<=8'b10011110;
                  2:seg<=8'b00100100;
                  3:seg<=8'b00001100;
                  4:seg<=8'b10011000;
                  5:seg<=8'b01001000;
                  6:seg<=8'b01000000;
                  7:seg<=8'b00011110;
                  8:seg<=8'b00000000;
                  9:seg<=8'b00001000;                
               endcase  
        else   
            case(num) 
                    0:seg<=8'b00000011;
                  1:seg<=8'b10011111;
                  2:seg<=8'b00100101;
                  3:seg<=8'b00001101;
                  4:seg<=8'b10011001;
                  5:seg<=8'b01001001;
                  6:seg<=8'b01000001;
                  7:seg<=8'b00011111;
                  8:seg<=8'b00000001;
                  9:seg<=8'b00001001;                   
               endcase 
       else ;
endmodule
