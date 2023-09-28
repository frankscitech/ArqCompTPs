`timescale 1ns / 1ps

`define dataLength 4
`define opLength 4

module topLevelAlu(
    //inputs
    input wire [`dataLength - 1 : 0] switch,
    input wire button1,//para A
    input wire button2,//para B
    input wire button3,//para OPCODE
    input wire clockCustom,
    input wire resetGral,
    
    output wire [`dataLength - 1 : 0]LED
    );
    
    parameter dataLength=`dataLength;
    parameter opLength=`opLength;
    
    reg signed [dataLength-1 : 0] reg_dataA;
	reg signed [dataLength-1 : 0] reg_dataB;
	reg [opLength-1 : 0] reg_OPCODE;
	
	wire signed [dataLength-1 : 0] wire_dataA;
	wire signed [dataLength-1 : 0] wire_dataB;
	wire [opLength-1 : 0] wire_OPCODE;
	
	
	
	wire o_clockWizzard;
	wire o_locked;
	ALU #(.p_dataLength(dataLength))
	u_alu(
		.i_A(wire_dataA),
		.i_B(wire_dataB),
		.i_ALUBitsControl(wire_OPCODE),
		.o_ALUResult(LED)//,
		//.o_Zero()
		);
    clk_wiz_0
	u_clk(
        // Clock out ports  
        .clk_out1(o_clockWizzard),
        // Status and control signals               
        .reset(resetGral), 
        .locked(o_locked),
        // Clock in ports
        .clk_in1(clockCustom)
	);
	
    always @(posedge o_clockWizzard)
	begin
	        if (resetGral==1 && button1 == 0 && button2==0 && button3==0) begin
                reg_dataA <= 0;
                reg_dataB <= 0;
                reg_OPCODE <= 0;
            end 
            else begin
                if (button1 == 1 && button2==0 && button3==0 && o_locked) begin//&& o_locked saco esto de todos los ifs else ifs
                    reg_dataA <= switch;
                    reg_dataB <= reg_dataB;
                    reg_OPCODE <= reg_OPCODE;					
                end
                else if (button1 == 0 && button2==1 && button3==0 && o_locked) begin
                    reg_dataA <= reg_dataA;
                    reg_dataB <= switch;
                    reg_OPCODE <= reg_OPCODE;		
                end
                else if (button1 == 0 && button2==0 && button3==1 && o_locked) begin
                    reg_dataA <= reg_dataA;
                    reg_dataB <= reg_dataB;
                    reg_OPCODE <= switch;
                end
                else begin
                    reg_dataA <= reg_dataA;
                    reg_dataB <= reg_dataB;
                    reg_OPCODE <= reg_OPCODE;
                end
            end  
	end
	
assign wire_dataA=reg_dataA;
assign wire_dataB=reg_dataB;
assign wire_OPCODE=reg_OPCODE;
 
endmodule
