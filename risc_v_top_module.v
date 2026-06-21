module risc_v_top_module(
input clk, reset,
output [31:0] pc_out,
output [31:0] instruction_out,
output [31:0] imm_out,
output beq_out
);

wire beq;
wire bneq;
wire bge;
wire blt;
wire bltu;
wire bgeu;

wire jal_control;
wire jalr_control;
wire jump ;

wire [31:0] pc;
wire [31:0] current_pc;
wire [31:0] instruction;
wire [31:0] imm_value;
wire [5:0]  alu_control;

wire reg_write;
wire mem_to_reg;

wire lb_control;
wire lh_control;
wire lw_control;
wire lbu_control;
wire lhu_control;

wire sb_control;
wire sh_control;
wire sw_control;

wire beq_control;
wire bne_control;
wire blt_control;
wire bge_control;
wire bltu_control;
wire bgeu_control;

wire lui_control;
wire auipc_control;

assign jump = jal_control | jalr_control;


instr_fetch ifu(.clk(clk), .reset(reset), .beq(beq),.bneq(bneq),.bge(bge),.blt(blt),.bltu(bltu),.bgeu(bgeu), .jump(jump),  .imm_branch_addr(imm_value), .imm_jump_addr(imm_value), .pc(pc), .current_pc(current_pc));

instr_memory imu(.pc(pc), .instruction_format(instruction));

imm_gen ig(.instruction(instruction), .imm_value(imm_value));

control_unit cu(.reset(reset),
                 .funct7(instruction[31:25]),
                 .funct3(instruction[14:12]),
                 .opcode(instruction[6:0]),
                 .alu_control(alu_control),
                 .reg_write(reg_write),
                 .mem_to_reg(mem_to_reg),
                 .lb_control(lb_control),
                 .lh_control(lh_control),
                 .lw_control(lw_control),
                 .lbu_control(lbu_control),
                 .lhu_control(lhu_control),
                 .sb_control(sb_control),
                 .sh_control(sh_control),
                 .sw_control(sw_control),
                 .beq_control(beq_control),
                 .bne_control(bne_control),
                 .blt_control(blt_control),
                 .bge_control(bge_control),
                 .bltu_control(bltu_control),
                 .bgeu_control(bgeu_control),
                 .jal_control(jal_control),
                 .jalr_control(jalr_control),
                 .lui_control(lui_control),
                 .auipc_control(auipc_control)
             );
             
             
      datapath_unit dpu(.clk(clk),
    .rst(reset),
    .read_reg_num1(instruction[19:15]),
    .read_reg_num2(instruction[24:20]),
    .write_reg_rd(instruction[11:7]),
    .alu_control(alu_control),
    .reg_write(reg_write),
    .mem_to_reg(mem_to_reg),
    .lb_control(lb_control),
    .lh_control(lh_control),
    .lw_control(lw_control),
    .lbu_control(lbu_control),
    .lhu_control(lhu_control),
    .sb_control(sb_control),
    .sh_control(sh_control),
    .sw_control(sw_control),
    .beq_control(beq_control),
    .bne_control(bne_control),
    .bge_control(bge_control),
    .blt_control(blt_control),
    .bltu_control(bltu_control),
    .bgeu_control(bgeu_control),
    .imm_val(imm_value),
    .shamt(instruction[24:20]),
    .pc(pc),
    .beq(beq),
    .bneq(bneq),
    .bge(bge),
    .blt(blt),
    .bltu(bltu),
    .bgeu(bgeu)
);       

assign pc_out = pc;
assign instruction_out = instruction;
assign imm_out = imm_value;
assign beq_out = beq;
             
             endmodule
