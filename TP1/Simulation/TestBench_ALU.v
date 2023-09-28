`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2023 12:55:35 PM
// Design Name: 
// Module Name: TestBench_ALU
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

module TestBench_ALU();

    parameter dataLength=`dataLength;
    parameter opLength=`opLength;
    
    //todos los input wire pasan a reg
    reg [dataLength-1:0] _i_A;
    reg [dataLength-1:0] _i_B;
    reg [opLength-1:0] _i_ALUBitsControl;
    
    //todos los output pasan a wire
    wire [dataLength-1:0] _o_ALUResult;
    //wire  _o_Zero;

    //instancio el m?dulo de la ALU
    //uut= unit under test 
    ALU #(
        .p_operatorsInputSize(4)
    ) 
    uut_ALU (
        .i_A(_i_A),
        .i_B(_i_B),
        .i_ALUBitsControl(_i_ALUBitsControl),
        .o_ALUResult(_o_ALUResult)//,
        //.o_Zero(_o_Zero)
    );

    /*localparam ADD = 6'b100000;
    localparam SUB = 6'b100010;
    localparam AND = 6'b100100;
    localparam OR  = 6'b100101;
    localparam XOR = 6'b100110;
    localparam SRA = 6'b000011;
    localparam SRL = 6'b000010;
    localparam NOR = 6'b100111;*/
    
    localparam ADD = 4'b0001;
    localparam SUB = 4'b0010;
    localparam AND = 4'b0011;
    localparam OR  = 4'b0101;
    localparam XOR = 4'b0111;
    localparam SRA = 4'b1000;
    localparam SRL = 4'b1100;
    localparam NOR = 4'b1110;

  
initial
begin
    #0
    _i_A = {dataLength{1'b0}};
    _i_B = {dataLength{1'b0}};
    #50
    _i_ALUBitsControl = ADD;
    #50
    _i_ALUBitsControl = SUB;
    #50
    _i_ALUBitsControl = AND;
    #50
    _i_ALUBitsControl = OR;
    #50
    _i_ALUBitsControl = XOR;
    #50
    _i_ALUBitsControl = SRA;
    #50
    _i_ALUBitsControl = SRL;
    #50
    _i_ALUBitsControl = NOR;
       
end

// Genera numeros aleatorios cada 60 steps del simulador
always begin
  #60
    _i_A = $random;
    _i_B = $random;
  end

endmodule
