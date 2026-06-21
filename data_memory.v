`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.05.2026 22:52:07
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input clk,
    input reset,

    input [31:0] address,
    input [31:0] write_data,

    input sb_control,
    input sh_control,
    input sw_control,

    input lb_control,
    input lh_control,
    input lw_control,
    input lbu_control,
    input lhu_control,

    output reg [31:0] read_data
);

integer i;

reg [7:0] data_mem [255:0];

always @(posedge clk)
begin
    if(reset)
    begin
        for(i = 0; i < 256; i = i + 1)
            data_mem[i] <= 0;
    end

    else
    begin
        if(sb_control)
        begin
            data_mem[address[7:0]] <= write_data[7:0];
        end

        else if(sh_control)
        begin
            data_mem[address[7:0]] <= write_data[7:0];
            data_mem[address[7:0] + 1] <= write_data[15:8];
        end

        else if(sw_control)
        begin
            data_mem[address[7:0]] <= write_data[7:0];
            data_mem[address[7:0] + 1] <= write_data[15:8];
            data_mem[address[7:0] + 2] <= write_data[23:16];
            data_mem[address[7:0] + 3] <= write_data[31:24];
        end
    end
end

always @(*)
begin
    if(lb_control)
    begin
        read_data = {
                     {24{data_mem[address[7:0]][7]}},
                     data_mem[address[7:0]]
                    };
    end

    else if(lh_control)
    begin
        read_data = {
                     {16{data_mem[address[7:0] + 1][7]}},
                     data_mem[address[7:0] + 1],
                     data_mem[address[7:0]]
                    };
    end

    else if(lw_control)
    begin
        read_data = {
                     data_mem[address[7:0] + 3],
                     data_mem[address[7:0] + 2],
                     data_mem[address[7:0] + 1],
                     data_mem[address[7:0]]
                    };
    end

    else if(lbu_control)
    begin
        read_data = {
                     24'b0,
                     data_mem[address[7:0]]
                    };
    end

    else if(lhu_control)
    begin
        read_data = {
                     16'b0,
                     data_mem[address[7:0] + 1],
                     data_mem[address[7:0]]
                    };
    end

    else
    begin
        read_data = 32'b0;
    end
end

endmodule
