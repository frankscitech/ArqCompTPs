`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2023 10:02:07 PM
// Design Name: 
// Module Name: TestBech_top
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


`define dataLength 4
`define opLength 4
`define opNum 8
`define simNum 2 

module TestBech_top;
  parameter dataLength=`dataLength;
  parameter opLength=`opLength;
//todos los input wire pasan a reg
  reg signed [dataLength-1:0] i_topTb_switch=0;
  reg i_topTb_button1=0;
  reg i_topTb_button2=0;
  reg i_topTb_button3=0;
  reg i_topTb_clock=0;
  reg i_topTb_reset=0;
  reg [opLength:0] ops [7:0];
  
  wire signed [dataLength-1:0] o_topTb_LED;
  integer i,j;

//instancio el módulo de la ALU
//uut= unit under test 
topLevelAlu #(
  ) 
  u_topLevelAlu (
    .switch(i_topTb_switch),
    .button1(i_topTb_button1),
    .button2(i_topTb_button2),
    .button3(i_topTb_button3),
    .clockCustom(i_topTb_clock),
    .resetGral(i_topTb_reset),
    .LED(o_topTb_LED)
  );

localparam ADD = 4'b0001;
localparam SUB = 4'b0010;
localparam AND = 4'b0011;
localparam OR  = 4'b0101;
localparam XOR = 4'b0111;
localparam SRA = 4'b1000;
localparam SRL = 4'b1100;
localparam NOR = 4'b1110;   

  task task_set_ops;
    begin
        ops[0]=ADD;
        ops[1]=SUB;
        ops[2]=AND;
        ops[3]=OR;
        ops[4]=XOR;
        ops[5]=SRA;
        ops[6]=SRL;
        ops[7]=NOR;
    end
  endtask


initial begin
    task_set_ops();
    // Initial Reset
    #2500 
    i_topTb_reset = 1'b1;
    #100
    i_topTb_reset = 1'b0;

    
    for (i=0;i<`simNum;i=i+1) begin
    
        #100
        i_topTb_switch = $random;
        //i_topTb_switch = -1;
        #100
        i_topTb_button1 =  1'b1;
        #100
        i_topTb_button1 =  1'b0;
        $display("Operand:%d",i_topTb_switch);
        
        #100
        i_topTb_switch = $random;
        //i_topTb_switch = -1;
        #100
        i_topTb_button2 =  1'b1;
        #100
        i_topTb_button2 =  1'b0;
        $display("Operand:%d",i_topTb_switch);
        
        for (j=0;j<8;j=j+1) begin
            #100
            i_topTb_switch = ops[j];
            #100
            i_topTb_button3 =  1'b1;
            #100
            i_topTb_button3 =  1'b0; 
            $display("Operation:%d",i_topTb_switch);
            $display("Result:%d",o_topTb_LED);
        end
        
        #100
        i_topTb_reset = 1'b1;
        #100
        i_topTb_reset = 1'b0;
    end 
end

// To simulate the clock 1ns or 100Mhz
always 
	#1 i_topTb_clock = ~i_topTb_clock;
endmodule
