`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.06.2026 03:05:29
// Design Name: 
// Module Name: risc_v_tb
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


module risc_v_tb;

reg clk;
reg reset;

wire [31:0] pc_out;
wire [31:0] instruction_out;
wire [31:0] imm_out;
wire beq_out;

risc_v_top_module dut(
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out),
    .instruction_out(instruction_out),
    .imm_out(imm_out),
    .beq_out(beq_out)
);

always #5 clk = ~clk;

initial
begin
    clk = 0;
    reset = 1;

    #20;
    reset = 0;

    #335;
    $finish;
end

endmodule
