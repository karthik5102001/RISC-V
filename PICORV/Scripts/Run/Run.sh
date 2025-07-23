riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o ../../Cfiles/TEST_1/Test_1.o ../../Cfiles/TEST_1/Test_1.c 
riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o ../../Cfiles/TEST_1/load.o ../../Cfiles/TEST_1/load.S

riscv64-unknown-elf-gcc -c -mabi=ilp32 -march=rv32im -o ../../Cfiles/TEST_1/syscalls.o ../../Cfiles/TEST_1/syscalls.c
riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -Wl,--gc-sections -o firmware.elf load.o Test_1.o syscalls.o -T riscv.ld -lstdc++
chmod -x firmware.elf
riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32im -nostdlib -o start.elf start.S -T start.ld -lstdc++
chmod -x start.elf
riscv64-unknown-elf-objcopy -O verilog start.elf start.tmp
riscv64-unknown-elf-objcopy -O verilog firmware.elf firmware.tmp
cat start.tmp firmware.tmp > firmware.hex
python3 hex8tohex32.py firmware.hex > firmware32.hex
rm -f start.tmp firmware.tmp
iverilog -o ../../Cfiles/TEST_1/SIM/testbench.vvp ../../Cfiles/TEST_1/Testbench/Testbench_picorv32.v ../../Cfiles/TEST_1/RTL/picorv32.v
chmod -x ../../Cfiles/TEST_1/SIM/testbench.vvp
vvp -N ../../Cfiles/TEST_1/SIM/testbench.vvp