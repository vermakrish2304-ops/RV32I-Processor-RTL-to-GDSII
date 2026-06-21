`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2026 07:42:05
// Design Name: 
// Module Name: instr_fetch
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


module instr_fetch(
    input clk,
    input reset,
    input beq, bneq, blt, bge, bltu, bgeu,
    input jump,

    input [31:0] imm_branch_addr,
    input [31:0] imm_jump_addr,

    output reg [31:0] pc,
    output reg [31:0] current_pc
);

always @(posedge clk)
begin
    if(reset)
        pc <= 0;

    else if(jump)
        pc <= pc + imm_jump_addr;

    else if(beq || bneq || blt || bge || bltu || bgeu)
        pc <= pc + imm_branch_addr;

    else
        pc <= pc + 4;
end


always @(posedge clk)
begin
    if(reset)
        current_pc <= 0;

    else if(!jump)
        current_pc <= pc + 4;
end

endmodule
