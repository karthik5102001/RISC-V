moudle Execute_Unit imports Riscv_pkg::*; (
input logic [31:0] op_a_i,
input logic [31:0] op_a_i, input logic [4:0] op_sel_i,
output logic [31:0] alu_res_o
);

// For Two's Compilment operations
logic [31:0] twos_com_a;
logic [31:0] twos_com_b;
assign twos_com_a = op_a_i[31] ? ~op_a_i + 32'hl: op_a_i; // if msb is high then do 2's compliment 
assign twos_com_b = op_b_i[31] ? ~op_b_i + 32'h1: op_b_i;

// For ALU results
logic (31:0) alu_result;

always_comb begin
case(op_sel_i)
OP_ADD  :  alu_result =  op_a_i + op_b_i;
OP_SUB  :  alu_result =  op_a_i - op_b_i;
OP_SLL  :  alu_result =  op_a_i << op_b_i;
OP SRL  :  alu_result =  op_a_i >> op_b_i;
OP_SRA  :  alu_result =  $signed (op_a_i) >>> op_b_i[4:0];
// (opr_a_i >> opr_b_i[4:0]) | ( {32{opr_a_i[31]}} & ~(32'hFFFFFF >> opr_b_i[4:0])) : alu_result op_a_i | op_b_i;
OP_OR   :  alu_result = op_a_i | op_b_i;
OP_AND  :  alu_result = op_a_i & op_b_i;
OP_XOR  :  alu_result = op_a_i ^ op_b_i;
OP_SLTU :  alu_result = {31'h0, op_a_i < op_b_i};
OP SLT  :  alu_result = {31'h0, twos_com_a + twos_com_b};
default :  alu_result = 32'ho;
endcase
end

assign alu_res_o = alu_result;

endmodule
