`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2026 04:33:17
// Design Name: 
// Module Name: alu_unit
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


module alu_unit(
    input [31:0] rs1,
    input [31:0] rs2,
    input [5:0] alu_control,
    input [31:0] pc,
    input [31:0] imm_value,
    input [4:0] shamt,
    output reg [31:0] result
);

always @(*)
begin
    case(alu_control)
        6'b000001: result = rs1 + rs2;
        6'b000010: result = rs1 - rs2;
        6'b000011: result = rs1 << rs2[4:0];
        6'b000100: result = ($signed(rs1) < $signed(rs2)) ? 1 : 0;
        6'b000101: result = (rs1 < rs2) ? 1 : 0;
        6'b000110: result = rs1 ^ rs2;
        6'b000111: result = rs1 >> rs2[4:0];
        6'b001000: result = $signed(rs1) >>> rs2[4:0];
        6'b001001: result = rs1 | rs2;
        6'b001010: result = rs1 & rs2;
        6'b001011: result = rs1 + imm_value;
        6'b001100: result = ($signed(rs1) < $signed(imm_value)) ? 1 : 0;
        6'b001101: result = (rs1 < imm_value) ? 1 : 0;
        6'b001110: result = rs1 ^ imm_value;
        6'b001111: result = rs1 | imm_value;
        6'b010000: result = rs1 & imm_value;
        6'b010001: result = rs1 << shamt;
        6'b010010: result = rs1 >> shamt;
        6'b010011: result = $signed(rs1) >>> shamt;
        6'b010100,
        6'b010101,
        6'b010110,
        6'b010111,
        6'b011000,
        6'b011001,
        6'b011010,
        6'b011011,
        6'b011100: result = rs1 + imm_value;
        6'b011101: result = (rs1 == rs2) ? 1 : 0;
        6'b011110: result = (rs1 != rs2) ? 1 : 0;
        6'b011111: result = ($signed(rs1) < $signed(rs2)) ? 1 : 0;
        6'b100000: result = ($signed(rs1) >= $signed(rs2)) ? 1 : 0;
        6'b100001: result = (rs1 < rs2) ? 1 : 0;
        6'b100010: result = (rs1 >= rs2) ? 1 : 0;
        6'b100011: result = imm_value;
        6'b100100: result = pc + imm_value;
        6'b100101: result = pc + 4;
        default:   result = 32'b0;
    endcase
end

endmodule
