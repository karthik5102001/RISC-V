package RISCV_PKG;

typedef enum logic [6:0] {
R_Type = 7'h33,
I_Type_0 = 7'h03,
I_Type_1 = 7'h13, 
I_Type_2 = 7'h67,
S_Type = 7'h23,
B_Type = 7'h63,
U_Type_0 = 7'h37,
U_Type_1 = 7'h17,
J_Type = 7'h6F } Riscv_opcode;


typedef enum logic [4:0] {
OP_ADD,
OP_SUB,
OP_SLL,
OP_SRL,
OP_SRA,
OP_OR, 
OP_AND,
OP_XOR,
OP_SLTU,
OP_SLT } Alu_operation;



endpackage