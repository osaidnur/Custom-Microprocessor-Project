# Advanced Digital Course Project - Verilog ALU and Register File System

This repository contains the Verilog implementation of an ALU (Arithmetic Logic Unit) and Register File system designed as part of an advanced digital systems course project. The design is tested using a comprehensive testbench with detailed instruction verification.

## Project Overview
The project simulates an ALU and a Register File system capable of executing various arithmetic and logical operations based on a 6-bit opcode. The testbench verifies the correctness of each operation by comparing the computed results with expected values.

### Features
- **ALU Module**: Supports operations like addition, subtraction, logical operations, negation, and more.
- **Register File Module**: Stores and retrieves values from 32 registers for computation.
- **Testbench**: Includes a set of 23 instructions to validate the system and displays results on the terminal and waveform.

### Supported Operations
The following table lists the operations supported by the ALU and their respective opcodes:

| Opcode | Operation       | Description               |
|--------|-----------------|---------------------------|
| 4      | `a + b`         | Addition                 |
| 5      | `a ^ b`         | XOR                      |
| 6      | `-a`            | Negation                 |
| 7      | `(a + b) / 2`   | Average                  |
| 8      | `|a|`           | Absolute Value           |
| 9      | `~a`            | Bitwise NOT              |
| 10     | `a & b`         | AND                      |
| 11     | `a - b`         | Subtraction              |
| 12     | `a | b`         | OR                       |
| 13     | `max(a, b)`     | Maximum of two numbers   |
| 14     | `min(a, b)`     | Minimum of two numbers   |

### Register Initial Values
The register file contains 32 signed 32-bit values initialized as follows:

mem[0] = 0, mem[1] = 12996, mem[2] = 11490, mem[3] = 7070, mem[4] = 6026, mem[5] = 3322, mem[6] = 10344, mem[7] = 6734, mem[8] = 15834, mem[9] = 15314, mem[10] = 6000, mem[11] = 12196, mem[12] = 11290, mem[13] = 13350, mem[14] = 2086, mem[15] = 6734, mem[16] = 7430, mem[17] = 14102, mem[18] = 13200, mem[19] = 3264, mem[20] = 2368, mem[21] = 15846, mem[22] = 11710, mem[23] = 14736, mem[24] = 5338, mem[25] = 5544, mem[26] = 1852, mem[27] = 3898, mem[28] = 16252, mem[29] = 1048, mem[30] = 5642, mem[31] = 0.



### Instructions in the Testbench
The testbench executes the following 23 instructions. For each instruction, the expected result is calculated based on the opcode and register values:

1. **Add**: `R31 = R10 + R3`
2. **XOR**: `R31 = R10 ^ R3`
3. **Neg**: `R31 = -R10`
4. **Avg**: `R0 = (R10 + R3) / 2`
5. **Abs**: `R0 = |R31|`
6. **Not**: `R31 = ~R10`
7. **And**: `R31 = R10 & R3`
8. **Sub**: `R31 = R10 - R3`
9. **Or**: `R31 = R10 | R3`
10. **Max**: `R31 = max(R10, R3)`
11. **Min**: `R31 = min(R10, R3)`
12. **Sub**: `R31 = R31 - R18`
13. **Abs**: `R5 = |R5|`
14. **Invalid**: Invalid opcode test
15. **Abs**: `R5 = |R5|`
16. **Neg**: `R31 = -R31`
17. **Neg**: `R0 = -R0`
18. **Max**: `R31 = max(R31, R0)`
19. **Sub**: `R0 = R0 - R0`
20. **XOR**: `R0 = R0 ^ R24`
21. **Neg**: `R31 = -R24`
22. **Max**: `R0 = max(R0, R24)`
23. **Min**: `R31 = min(R31, R31)`

### Example Results
Two photos are included in the repository:
1. **Terminal Output**: Displays the computed result, expected result, and status (PASS/FAIL) for each instruction.
2. **Waveform**: Illustrates the signal transitions and verifies the timing of operations.

### How to Run the Project
1. Open the workspace file in **Active-HDL**.
2. Navigate to the `src` folder containing the Verilog files.
3. Compile the design files and testbench.
4. Run the simulation and view results in the terminal or waveform viewer.

### File Structure
- **`src/`**: Contains all Verilog design and testbench files.
- **Workspace File**: Provided for easy project setup.

This project demonstrates the design and validation of a basic ALU and register file system with emphasis on correct operation and testing. Feel free to explore and verify the results using the provided instructions and initial register values!

