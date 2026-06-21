`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2026 07:47:33
// Design Name: 
// Module Name: control_unit
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

module control_unit(
    input reset,
    input [6:0] funct7,
    input [2:0] funct3,
    input [6:0] opcode,

    output reg [5:0] alu_control,
    output reg reg_write,
    output reg mem_to_reg,

    output reg lb_control,
    output reg lh_control,
    output reg lw_control,
    output reg lbu_control,
    output reg lhu_control,

    output reg sb_control,
    output reg sh_control,
    output reg sw_control,

    output reg beq_control,
    output reg bne_control,
    output reg blt_control,
    output reg bge_control,
    output reg bltu_control,
    output reg bgeu_control,

    output reg jal_control,
    output reg jalr_control,

    output reg lui_control,
    output reg auipc_control
);

always @(*)
begin
    alu_control   = 0;
    reg_write     = 0;
    mem_to_reg    = 0;
    lb_control    = 0;
    lh_control    = 0;
    lw_control    = 0;
    lbu_control   = 0;
    lhu_control   = 0;
    sb_control    = 0;
    sh_control    = 0;
    sw_control    = 0;
    beq_control   = 0;
    bne_control   = 0;
    blt_control   = 0;
    bge_control   = 0;
    bltu_control  = 0;
    bgeu_control  = 0;
    jal_control   = 0;
    jalr_control  = 0;
    lui_control   = 0;
    auipc_control = 0;

    if(!reset)
    begin
        case(opcode)

            7'b0110011:
            begin
                reg_write  = 1;
                mem_to_reg = 0;
                case(funct3)
                    3'b000:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b000001;
                        else if(funct7 == 7'b0100000)
                            alu_control = 6'b000010;
                    end
                    3'b001:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b000011;
                    end
                    3'b010:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b000100;
                    end
                    3'b011:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b000101;
                    end
                    3'b100:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b000110;
                    end
                    3'b101:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b000111;
                        else if(funct7 == 7'b0100000)
                            alu_control = 6'b001000;
                    end
                    3'b110:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b001001;
                    end
                    3'b111:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b001010;
                    end
                endcase
            end

            7'b0010011:
            begin
                reg_write  = 1;
                mem_to_reg = 0;
                case(funct3)
                    3'b000: alu_control = 6'b001011;
                    3'b010: alu_control = 6'b001100;
                    3'b011: alu_control = 6'b001101;
                    3'b100: alu_control = 6'b001110;
                    3'b110: alu_control = 6'b001111;
                    3'b111: alu_control = 6'b010000;
                    3'b001:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b010001;
                    end
                    3'b101:
                    begin
                        if(funct7 == 7'b0000000)
                            alu_control = 6'b010010;
                        else if(funct7 == 7'b0100000)
                            alu_control = 6'b010011;
                    end
                endcase
            end

            7'b0000011:
            begin
                reg_write  = 1;
                mem_to_reg = 1;
                case(funct3)
                    3'b000:
                    begin
                        lb_control  = 1;
                        alu_control = 6'b010100;
                    end
                    3'b001:
                    begin
                        lh_control  = 1;
                        alu_control = 6'b010101;
                    end
                    3'b010:
                    begin
                        lw_control  = 1;
                        alu_control = 6'b010110;
                    end
                    3'b100:
                    begin
                        lbu_control = 1;
                        alu_control = 6'b010111;
                    end
                    3'b101:
                    begin
                        lhu_control = 1;
                        alu_control = 6'b011000;
                    end
                endcase
            end

            7'b1100111:
            begin
                reg_write    = 1;
                mem_to_reg   = 0;
                jalr_control = 0;
                alu_control  = 6'b011001;
            end

            7'b0100011:
            begin
                reg_write  = 0;
                mem_to_reg = 0;
                case(funct3)
                    3'b000:
                    begin
                        sb_control  = 1;
                        alu_control = 6'b011010;
                    end
                    3'b001:
                    begin
                        sh_control  = 1;
                        alu_control = 6'b011011;
                    end
                    3'b010:
                    begin
                        sw_control  = 1;
                        alu_control = 6'b011100;
                    end
                endcase
            end

            7'b1100011:
            begin
                reg_write  = 0;
                mem_to_reg = 0;
                case(funct3)
                    3'b000:
                    begin
                        beq_control = 1;
                        alu_control = 6'b011101;
                    end
                    3'b001:
                    begin
                        bne_control = 1;
                        alu_control = 6'b011110;
                    end
                    3'b100:
                    begin
                        blt_control = 1;
                        alu_control = 6'b011111;
                    end
                    3'b101:
                    begin
                        bge_control = 1;
                        alu_control = 6'b100000;
                    end
                    3'b110:
                    begin
                        bltu_control = 1;
                        alu_control  = 6'b100001;
                    end
                    3'b111:
                    begin
                        bgeu_control = 1;
                        alu_control  = 6'b100010;
                    end
                endcase
            end

            7'b0110111:
            begin
                reg_write     = 1;
                mem_to_reg    = 0;
                lui_control   = 1;
                alu_control   = 6'b100011;
            end

            7'b0010111:
            begin
                reg_write     = 1;
                mem_to_reg    = 0;
                auipc_control = 1;
                alu_control   = 6'b100100;
            end

            7'b1101111:
            begin
                reg_write   = 1;
                mem_to_reg  = 0;
                jal_control = 1;
                alu_control = 6'b100101;
            end

        endcase
    end
end

endmodule
