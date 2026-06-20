# 🔲 32-bit RISC-V Microprocessor (RV32I)

> A complete RTL-to-GDSII implementation of a 32-bit single-cycle 
> RISC-V processor, built from architectural design through 
> physical silicon layout.

---

## 📌 Overview

This project presents the complete design, verification, and 
physical implementation of a **32-bit RISC-V (RV32I) single-cycle 
microprocessor**, built entirely from scratch in Verilog HDL — 
capable of executing all **37 instructions** defined in the RV32I 
base integer instruction set.

Most academic RISC-V implementations support only a narrow subset 
of instructions. This project directly addresses that gap — every 
module was critically analyzed, design flaws were identified, and 
a complete, corrected implementation was built from first 
principles, covering arithmetic, logical, shift, load, store, 
branch, jump, and upper-immediate instruction formats.

The processor was functionally verified in **AMD Vivado**, 
synthesized using **Cadence Genus**, and physically implemented 
— floorplanning, placement, clock tree synthesis, and routing — 
using **Cadence Innovus**, demonstrating the complete industry-
standard RTL-to-GDSII VLSI design flow.

---

## 🧠 Processor Architecture

The single-cycle RV32I processor comprises **eight functional 
units**: Program Counter, Instruction Memory, Control Unit, 
Register File, ALU, Immediate Generator, Data Memory, and 
Write-Back logic.

### Instruction Execution Flow
| Step | Operation |
|------|-----------|
| 1 | PC provides instruction address |
| 2 | Instruction Memory fetches instruction |
| 3 | Control Unit decodes opcode, generates control signals |
| 4 | Register File supplies source operands |
| 5 | Immediate Generator extracts immediate value |
| 6 | ALU performs arithmetic/logical/branch operations |
| 7 | Data Memory executes load/store operations |
| 8 | Result is written back to destination register |

### Architectural Features
- ✅ Complete RV32I ISA — all 37 base instructions
- ✅ Single-cycle datapath (Patterson & Hennessy model)
- ✅ Support for R, I, S, B, U, and J instruction formats
- ✅ Byte, half-word, and word memory access
- ✅ Branch and jump control for program flow management

---

## 🛠️ Module Hierarchy
risc_v_top_module

├── ifu : instr_fetch        # PC generation, control flow

├── imu : instr_memory        # Instruction storage/retrieval

├── ig  : imm_gen             # Immediate extraction (all formats)

├── cu  : control_unit        # Instruction decode, control signals

└── dpu : datapath_unit

├── rf : register_file    # 32 general-purpose registers

├── au : alu_unit         # Arithmetic/logic/comparison ops

└── dm : data_memory      # Load/store operations

| Module | Function |
|--------|----------|
| Instruction Fetch Unit | Program counter generation & control flow |
| Instruction Memory | Instruction storage and retrieval |
| Control Unit | Instruction decoding, control signal generation |
| Immediate Generator | Immediate extraction for all instruction formats |
| Register File | Storage of 32 processor registers |
| ALU Unit | Arithmetic, logical, and comparison operations |
| Data Memory | Load and store operations |
| Datapath Unit | Execution-stage integration |
| Top Module | Complete processor integration |

---

## ✅ Functional Verification

Behavioral simulation was performed using **AMD Vivado XSim** 
with a 10 ns clock period.

**Verified blocks:**
- Instruction Fetch & Decode
- Control Signal Generation
- Immediate Generation
- Register File Operations
- ALU Operations
- Memory Access Operations
- Branch Evaluation

The Program Counter was confirmed advancing correctly 
(`0x00 → 0x04 → 0x08 → 0x0C → ...`), with each address correctly 
fetching its corresponding instruction from memory.

> **Note:** A minor simulation anomaly was observed in the JALR 
> execution path during final-stage testing. JALR was held 
> inactive during waveform verification while all other 
> instruction categories — arithmetic, logical, memory, branch, 
> LUI, AUIPC, and JAL — were fully validated.

---

## ⚙️ Logic Synthesis — Cadence Genus

| Parameter | Value |
|-----------|-------|
| Tool | Cadence Genus Synthesis Solution v21.14 |
| Technology | ASAP7 7nm standard cell library |
| PVT Conditions | 0.7V, 25°C |
| Clock Constraint | 600 ps (~1.67 GHz target) |
| Total Cell Count | 19,176 cells |
| Cell Area | 41,837.60 µm² |
| Net Area | 16,329.64 µm² |
| **Total Area** | **58,167.24 µm²** |

**Cell Distribution:** Logic cells (60.1%) · Sequential elements 
(28.8%) · Buffers (4.7%) · Inverters (6.3%) — with ~97% SLVT 
(Super Low Voltage Threshold) cells, including 2,506 flip-flop 
instances.

**Static Timing Analysis (post-synthesis):**
Critical path from `ifu_pc_reg[0]` → `dpu_rfu_reg_mem_reg[11][22]` 
showed a data path delay of 756 ps against 587 ps required 
(−170 ps setup slack) — attributed to a ~40-stage combinational 
path through the ALU and register write-back logic. This was 
resolved in the physical design stage.

**Power Analysis (Genus, 0.7V/25°C):**
| Category | Total Power | % |
|----------|-------------|---|
| Register Logic | 7.21 mW | 42.53% |
| Combinational Logic | 9.74 mW | 57.47% |
| **Total** | **16.94 mW** | 100% |

---

## 🏗️ Physical Design — Cadence Innovus

| Parameter | Value |
|-----------|-------|
| Tool | Cadence Innovus Implementation System v21.15 |
| Technology Node | ASAP7 7nm |
| Routing Layers | M2 (bottom) – M7 (top) |
| Core Dimensions | ~190 µm × 244 µm |
| Aspect Ratio | 1.0 (square die) |

**Floorplanning:** Power rings on M6/M7 (2.176 µm width), power 
mesh across M2–M4, well-tap cells inserted at 12.96 µm intervals 
to prevent latch-up.

**Placement & Optimization:**
| Metric | Value |
|--------|-------|
| WNS (Worst Negative Slack) | +0.017 ns ✅ |
| TNS (Total Negative Slack) | 0.000 ns ✅ |
| Violating Paths | 0 / 2,603 ✅ |
| Core Density | 82.362% |
| Routing Overflow (H / V) | 1.99% / 1.52% |

**Clock Tree Synthesis & Routing:** Performed via `ccopt_design` 
with propagated clock mode across all 2,506 sequential elements; 
full signal routing completed across M2–M7.

**DRC Verification:** ✅ **Zero DRC violations** in the final 
routed design (66 non-functional power-mesh color-assignment 
flags — a known ASAP7 multi-patterning artifact, not a circuit 
defect).

---

## 📊 Results Summary

| Metric | Result |
|--------|--------|
| Instructions Supported | 37 / 37 (Full RV32I) |
| Total Standard Cells | 19,176 |
| Total Area | 58,167.24 µm² |
| Total Power | 16.94 mW |
| Setup Violations (post-placement) | 0 |
| DRC Violations | 0 |
| Core Utilization | 82.36% |

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|---------|
| AMD Vivado 2025.2 | RTL Design & Functional Simulation |
| Cadence Genus 21.14 | Logic Synthesis |
| Cadence Innovus 21.15 | Physical Design (Floorplan → GDS) |
| ASAP7 7nm PDK | Target Technology Library |
| Verilog HDL | Hardware Description Language |

---

## 👥 Team

Project developed by a 6-member team as part of a Summer Project 
under the Department of Electronics and Communication Engineering, 
BIT Mesra

---

## 🚀 Future Work

- Extend to a 5-stage pipelined architecture for higher throughput
- Resolve JALR datapath timing issue
- Instruction/data cache integration
- Low-power optimization (clock gating, power gating)

---

## 📚 References

- Samir Palnitkar — *Verilog HDL: A Guide to Digital Design and Synthesis*, 2nd Edition
- David Patterson & John Hennessy — *Computer Organization and Design: RISC-V Edition*
- Cadence Genus Synthesis Solution User Guide, v21.14
- Cadence Innovus Implementation System User Guide, v21.15

> Base RTL inspired by open-source RISC-V educational HDL code by 
> Gourav Saha, substantially modified and extended for this project.

---

## 🏫 Institution

**Birla Institute of Technology, Mesra**
Department of Electronics & Communication Engineering
Batch of 2028
