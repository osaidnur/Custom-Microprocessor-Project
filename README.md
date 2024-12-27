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
| 8      | `\|a\|`         | Absolute Value           |
| 9      | `~a`            | Bitwise NOT              |
| 10     | `a & b`         | AND                      |
| 11     | `a - b`         | Subtraction              |
| 12     | `a \| b`        | OR                       |
| 13     | `max(a, b)`     | Maximum of two numbers   |
| 14     | `min(a, b)`     | Minimum of two numbers   |

### Register Initial Values
The register file contains 32 signed 32-bit values initialized as follows:

| Index | Value   |     | Index | Value   |
|-------|---------|-----|-------|---------|
| 0     | 0       |     | 16    | 7430    |
| 1     | 12996   |     | 17    | 14102   |
| 2     | 11490   |     | 18    | 13200   |
| 3     | 7070    |     | 19    | 3264    |
| 4     | 6026    |     | 20    | 2368    |
| 5     | 3322    |     | 21    | 15846   |
| 6     | 10344   |     | 22    | 11710   |
| 7     | 6734    |     | 23    | 14736   |
| 8     | 15834   |     | 24    | 5338    |
| 9     | 15314   |     | 25    | 5544    |
| 10    | 6000    |     | 26    | 1852    |
| 11    | 12196   |     | 27    | 3898    |
| 12    | 11290   |     | 28    | 16252   |
| 13    | 13350   |     | 29    | 1048    |
| 14    | 2086    |     | 30    | 5642    |
| 15    | 6734    |     | 31    | 0       |



### Instructions in the Testbench
The testbench executes the following 23 instructions. For each instruction, the expected result is calculated based on the opcode and register values:


1. **Add**: `R31 = R10 + R3`  
   - **Instruction**:  
     - Binary: `00000000000 11111 00011 01010 000100`  
     - Hexadecimal: `0x001F1A84`
   - **Expected**: R31 = 6000 + 7070 = **13070**

2. **XOR**: `R31 = R10 ^ R3`  
   - **Instruction**:  
     - Binary: `00000000000 11111 00011 01010 000101`  
     - Hexadecimal: `0x001F1A85`
   - **Expected**: R31 = 6000 ^ 7070 = **3310**

3. **Neg**: `R31 = -R10`  
   - **Instruction**:  
     - Binary: `00000000000 11111 00000 01010 000110`  
     - Hexadecimal: `0x001F0286`
   - **Expected**: R31 = **-6000**

4. **Avg**: `R0 = (R10 + R3) / 2`  
   - **Instruction**:  
     - Binary: `00000000000 00000 00011 01010 000111`  
     - Hexadecimal: `0x00001A87`
   - **Expected**: R0 = (6000 + 7070) / 2 = **6535**

5. **Abs**: `R0 = |R31|`  
   - **Instruction**:  
     - Binary: `00000000000 00000 00000 11111 001000`  
     - Hexadecimal: `0x000007C8`
   - **Expected**: R0 = |-6000| = **6000**

6. **Not**: `R31 = ~R10`  
   - **Instruction**:  
     - Binary: `00000000000 11111 00011 01010 001001`  
     - Hexadecimal: `0x001F1A89`
   - **Expected**: R31 = ~6000 = **-6001**

7. **And**: `R31 = R10 & R3`  
   - **Instruction**:  
     - Binary: `00000000000 11111 00011 01010 001010`  
     - Hexadecimal: `0x001F1A8A`
   - **Expected**: R31 = 6000 & 7070 = **4880**

8. **Sub**: `R31 = R10 - R3`  
   - **Instruction**:  
     - Binary: `00000000000 11111 00011 01010 001011`  
     - Hexadecimal: `0x001F1A8B`
   - **Expected**: R31 = 6000 - 7070 = **-1070**

9. **Or**: `R31 = R10 | R3`  
   - **Instruction**:  
     - Binary: `00000000000 11111 00011 01010 001100`  
     - Hexadecimal: `0x001F1A8C`
   - **Expected**: R31 = 6000 | 7070 = **8190**

10. **Max**: `R31 = max(R10, R3)`  
    - **Instruction**:  
      - Binary: `00000000000 11111 00011 01010 001101`  
      - Hexadecimal: `0x001F1A8D`
    - **Expected**: R31 = max(6000, 7070) = **7070**

11. **Min**: `R31 = min(R10, R3)`  
    - **Instruction**:  
      - Binary: `00000000000 11111 00011 01010 001110`  
      - Hexadecimal: `0x001F1A8E`
    - **Expected**: R31 = min(6000, 7070) = **6000**

12. **Sub**: `R31 = R31 - R18`  
    - **Instruction**:  
      - Binary: `00000000000 11111 10010 11111 001011`  
      - Hexadecimal: `0x001F97CB`
    - **Expected**: R31 = 6000 - 13200 = **-7200**
      **(Note: The value of `R31` was updated in the previous instruction)**

13. **Abs**: `R5 = |R5|`  
    - **Instruction**:  
      - Binary: `00000000000 00101 00000 00101 001000`  
      - Hexadecimal: `0x00050148`
    - **Expected**: R5 = |3322| = **3322**

14. **Invalid**: Invalid opcode test  
    - **Instruction**:  
      - Binary: `00000000000 00101 01111 01011 001111`  
      - Hexadecimal: `0x00057ACF`
    - **Expected**: Error - Invalid opcode, register file remains unchanged

15. **Abs**: `R5 = |R5|`  
    - **Instruction**:  
      - Binary: `00000000000 00101 00000 00101 001000`  
      - Hexadecimal: `0x00050148`
    - **Expected**: R5 = |3322| = **3322**

16. **Neg**: `R31 = -R31`  
    - **Instruction**:  
      - Binary: `00000000000 11111 00000 11111 000110`  
      - Hexadecimal: `0x001F07C6`
    - **Expected**: R31 = -(-7200) = **7200**

17. **Neg**: `R0 = -R0`  
    - **Instruction**:  
      - Binary: `00000000000 00000 00000 00000 000110`  
      - Hexadecimal: `0x00000006`
    - **Expected**: R0 = -(6000) = **-6000**
      **(Note: The value of `R0` was updated in the 5th instruction)**
      

18. **Max**: `R31 = max(R31, R0)`  
    - **Instruction**:  
      - Binary: `00000000000 11111 00000 11111 001101`  
      - Hexadecimal: `0x001F07CD`
    - **Expected**: R31 = max(7200, 6000) = **7200**
      **(Note: `R0` and `R31` were updated in instructions 16 and 17)**

19. **Sub**: `R0 = R0 - R0`  
    - **Instruction**:  
      - Binary: `00000000000 00000 00000 00000 001011`  
      - Hexadecimal: `0x0000000B`
    - **Expected**: R0 = -6000 - (-6000) =**0**

20. **XOR**: `R0 = R0 ^ R24`  
    - **Instruction**:  
      - Binary: `00000000000 00000 11000 00000 000101`  
      - Hexadecimal: `0x0000C005`
    - **Expected**: R0 = 0 ^ 5338 = **5338**

21. **Neg**: `R31 = -R24`  
    - **Instruction**:  
      - Binary: `00000000000 11111 00000 11000 000110`  
      - Hexadecimal: `0x001F0606`
    - **Expected**: R31 = -(5338) = **-5338**

22. **Max**: `R0 = max(R0, R24)` 
    - **Instruction**:  
      - Binary: `00000000000 00000 11000 00000 001101`  
      - Hexadecimal: `0x0000C00D`
    - **Expected**: R0 = max(5338, 5338) = **5338**
      **(Note: The value of `R0` was updated in the instruction 20)**
      

23. **Min**: `R31 = min(R31, R31)` 
    - **Instruction**:  
      - Binary: `00000000000 11111 11111 11111 001110`  
      - Hexadecimal: `0x001FFFCE`
    - **Expected**: R31 = min(-5338, -5338) = **-5338**
      **(Note: The value of `R31` was updated in the instruction 21)**



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

