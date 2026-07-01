`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.05.2026 04:29:09
// Design Name: 
// Module Name: datapath_unit
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


module datapath_unit(
    input clk,
    input rst,
    input [4:0] read_reg_num1,
    input [4:0] read_reg_num2,
    input [4:0] write_reg_rd,
    input [5:0] alu_control,
    input reg_write,
    input mem_to_reg,
    input lb_control,
    input lh_control,
    input lw_control,
    input lbu_control,
    input lhu_control,
    input sb_control,
    input sh_control,
    input sw_control,
    input beq_control,
    input bne_control,
    input bge_control,
    input blt_control,
    input bltu_control,
    input bgeu_control,
    input [31:0] imm_val,
    input [4:0] shamt,
    input [31:0] pc,
    output beq,
    output bneq,
    output bge,
    output blt,
    output bltu,
    output bgeu
);

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] alu_result;
wire [31:0] mem_read_data;
wire [31:0] write_back_data;

assign write_back_data = mem_to_reg ? mem_read_data : alu_result;

register_file rf(
    .clk(clk),
    .reset(rst),
    .read_reg_rs1(read_reg_num1),
    .read_reg_rs2(read_reg_num2),
    .write_reg_rd(write_reg_rd),
    .write_data_rd(write_back_data),
    .reg_write(reg_write),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

alu_unit au(
    .rs1(read_data1),
    .rs2(read_data2),
    .alu_control(alu_control),
    .pc(pc),
    .imm_value(imm_val),
    .shamt(shamt),
    .result(alu_result)
);

data_memory dm(
    .clk(clk),
    .reset(rst),
    .address(alu_result),
    .write_data(read_data2),
    .sb_control(sb_control),
    .sh_control(sh_control),
    .sw_control(sw_control),
    .lb_control(lb_control),
    .lh_control(lh_control),
    .lw_control(lw_control),
    .lbu_control(lbu_control),
    .lhu_control(lhu_control),
    .read_data(mem_read_data)
);

assign beq  = (alu_result == 1 && beq_control  == 1);
assign bneq = (alu_result == 1 && bne_control  == 1);
assign bge  = (alu_result == 1 && bge_control  == 1);
assign blt  = (alu_result == 1 && blt_control  == 1);
assign bltu = (alu_result == 1 && bltu_control == 1);
assign bgeu = (alu_result == 1 && bgeu_control == 1);

endmodule
