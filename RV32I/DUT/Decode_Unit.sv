
module Decode_Unit import RISCV_PKG::*;(
input logic [31:0] inst_mem,

output logic [4:0] rs_1_o,
output logic [4:0] rs_2_o,
output logic [4:0] rd_o,

output logic [6:0] op_o,
output logic [2:0] funct3_o,
output logic [6:0] funct7_o,

output logic r_type_o,
output logic i_type_o,
output logic s_type_o,
output logic b_type_o,
output logic u_type_o,
output logic j_type_o,

output logic [31:0] immediate_o

    );

// Basic important operation    
    
logic [4:0] rs1;
logic [4:0] rs2;
logic [4:0] rd;
logic [6:0] op;

// Assigning the basic important operation

assign rs1 = inst_mem[19:15];
assign rs2 = inst_mem[24:20];
assign rd  = inst_mem[11:7];
assign op  = inst_mem[6:0];

//  FUNCT3 and FUNCT7

logic [6:0] funct7;
logic [2:0] funct3;

assign funct7 = inst_mem[31:25];
assign funct3 = inst_mem[14:12];

assign funct3_o = funct3;
assign funct7_o = funct7;

// Connecting with OP-code

logic [31:0] r_type_imm;
logic [31:0] i_type_imm;
logic [31:0] s_type_imm;
logic [31:0] b_type_imm;
logic [31:0] u_type_imm;
logic [31:0] j_type_imm;

assign i_type_imm = { {20{inst_mem[31]}}, inst_mem[30:20]}; // [sign_extend[11],[10:0]];
assign s_type_imm = { {21{inst_mem[31]}}, inst_mem[31:25], inst_mem[11:7]}; 
assign b_type_imm = { {20{inst_mem[31]}}, inst_mem[11], inst_mem[30:25], inst_mem[11:8], 1'b0};
assign u_type_imm = {  inst_mem[31:12] ,  12'h0};
assign j_type_imm = { {12{inst_mem[31]}}, inst_mem[19:12], inst_mem[20], inst_mem[30:21], 1'b0};

// logic type

logic r_type;
logic i_type;
logic s_type;
logic b_type;
logic u_type;
logic j_type;

 always_comb 
 begin
 r_type = 1'b0;
 i_type = 1'b0;
 s_type = 1'b0;
 b_type = 1'b0;
 u_type = 1'b0;
 j_type = 1'b0;
 case(op)
 R_Type :  r_type = 1'b1;
 I_Type :  i_type = 1'b1;
 S_Type :  s_type = 1'b1;
 B_Type :  b_type = 1'b1;
 U_Type :  u_type = 1'b1;
 J_Type :  j_type = 1'b1;
 default: begin r_type = 1'b0;
           i_type = 1'b0;
           s_type = 1'b0;
           b_type = 1'b0;
           u_type = 1'b0;
           j_type = 1'b0; end  
 endcase
 end
 
 assign  r_type_o = r_type;
 assign  i_type_o = i_type;
 assign  s_type_o = s_type;
 assign  b_type_o = b_type;
 assign  u_type_o = u_type;
 assign  j_type_o = j_type; 
 
 logic [31:0] imm;
 
 assign imm = r_type ? 32'h0 :
              i_type ? i_type_imm : 
              s_type ? s_type_imm :
              b_type ? b_type_imm :
              u_type ? u_type_imm :
                       j_type_imm ;             
              
 assign imm_o = imm;
 
endmodule