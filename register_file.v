`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2026 20:03:14
// Design Name: 
// Module Name: register_file
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


module register_file(
    input clk, reset,
    input [4:0] read_reg_rs1,
    input [4:0] read_reg_rs2,
    input [4:0] write_reg_rd,
    input [31:0] write_data_rd,
    input reg_write,
    output [31:0] read_data1,
    output [31:0] read_data2
);
    
    integer i;
    reg [31:0] reg_file [31:0];
    
    always @(posedge clk) begin
        if(reset) begin 
            for(i=0; i<32; i = i + 1) begin
                reg_file[i] <= 32'b0;
            end
        end
        else begin
            if(reg_write && (write_reg_rd != 5'b0)) begin
                reg_file[write_reg_rd] <= write_data_rd;
            end
        end
    end
               
    assign read_data1 = (read_reg_rs1 == 5'b0) ? 32'b0 : reg_file[read_reg_rs1];
    assign read_data2 = (read_reg_rs2 == 5'b0) ? 32'b0 : reg_file[read_reg_rs2];

endmodule
