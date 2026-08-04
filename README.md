# mux2_1
2:1 Multiplexer Verification Using SystemVerilog
Project Description

This project verifies the functionality of a 2:1 multiplexer using a basic SystemVerilog testbench.

The testbench applies different combinations of input signals to the Design Under Test, monitors the output, compares it with the expected result, and displays PASS or FAIL for every test case.

The simulation is developed and executed using EDA Playground.

Project Structure
mux_2to1_project/
├── design.sv
├── testbench.sv
└── README.md
design.sv contains the 2:1 multiplexer RTL design.
testbench.sv contains the SystemVerilog testbench.
README.md contains the project description and simulation instructions.
DUT Functionality

The 2:1 multiplexer contains the following inputs and output:

Inputs
a
b
sel
Output
y

The output depends on the value of sel.

Select	Output
sel = 0	y = a
sel = 1	y = b

The mux functionality can be represented as:

y = sel ? b : a;
DUT Code
`timescale 1ns/1ps

module mux_2to1 (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);

    always_comb begin
        if (sel == 0)
            y = a;
        else
            y = b;
    end

endmodule
Verification Approach

The testbench performs the following operations:

Declares the input and output signals.
Instantiates the multiplexer DUT.
Applies different input combinations.
Waits for the combinational output to update.
Compares the DUT output with the expected output.
Displays PASS or FAIL for every test.
Counts the total passed and failed test cases.
Generates a VCD file for waveform viewing.

A clock and reset are not required because the multiplexer is a combinational circuit.

Testbench Code
`timescale 1ns/1ps

module mux_2to1_tb;

    logic a;
    logic b;
    logic sel;
    logic y;

    integer pass_count = 0;
    integer fail_count = 0;

    mux_2to1 dut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    task apply_test(
        input logic test_a,
        input logic test_b,
        input logic test_sel,
        input logic expected_y
    );

        begin
            a   = test_a;
            b   = test_b;
            sel = test_sel;

            #10;

            if (y === expected_y) begin
                $display(
                    "Time=%0t a=%0d b=%0d sel=%0d y=%0d PASS",
                    $time, a, b, sel, y
                );

                pass_count = pass_count + 1;
            end
            else begin
                $display(
                    "Time=%0t a=%0d b=%0d sel=%0d y=%0d expected=%0d FAIL",
                    $time, a, b, sel, y, expected_y
                );

                fail_count = fail_count + 1;
            end
        end

    endtask

    initial begin
        $dumpfile("mux_waveform.vcd");
        $dumpvars(0, mux_2to1_tb);
    end

    initial begin

        a   = 0;
        b   = 0;
        sel = 0;

        $display("-------------------------------------");
        $display("2:1 Multiplexer Verification Started");
        $display("-------------------------------------");

        apply_test(0, 0, 0, 0);
        apply_test(0, 1, 0, 0);
        apply_test(1, 0, 0, 1);
        apply_test(1, 1, 0, 1);

        apply_test(0, 0, 1, 0);
        apply_test(0, 1, 1, 1);
        apply_test(1, 0, 1, 0);
        apply_test(1, 1, 1, 1);

        $display("-------------------------------------");
        $display(
            "Total Passed = %0d, Total Failed = %0d",
            pass_count, fail_count
        );

        if (fail_count == 0)
            $display("FINAL RESULT: ALL TESTS PASSED");
        else
            $display("FINAL RESULT: SOME TESTS FAILED");

        $display("-------------------------------------");

        $finish;
    end

endmodule
Test Scenarios

All possible binary combinations of a, b, and sel are verified.

Test Case	Input A	Input B	Select	Expected Output
1	0	0	0	0
2	0	1	0	0
3	1	0	0	1
4	1	1	0	1
5	0	0	1	0
6	0	1	1	1
7	1	0	1	0
8	1	1	1	1
Expected Simulation Output
-------------------------------------
2:1 Multiplexer Verification Started
-------------------------------------
Time=10000 a=0 b=0 sel=0 y=0 PASS
Time=20000 a=0 b=1 sel=0 y=0 PASS
Time=30000 a=1 b=0 sel=0 y=1 PASS
Time=40000 a=1 b=1 sel=0 y=1 PASS
Time=50000 a=0 b=0 sel=1 y=0 PASS
Time=60000 a=0 b=1 sel=1 y=1 PASS
Time=70000 a=1 b=0 sel=1 y=0 PASS
Time=80000 a=1 b=1 sel=1 y=1 PASS
-------------------------------------
Total Passed = 8, Total Failed = 0
FINAL RESULT: ALL TESTS PASSED
-------------------------------------

The displayed time can vary depending on the simulator time-format settings.

Waveform Generation

The following statements generate the waveform file:

$dumpfile("mux_waveform.vcd");
$dumpvars(0, mux_2to1_tb);
$dumpfile specifies the VCD waveform file name.
$dumpvars records the signal changes.
0 means all hierarchy levels under the testbench are included.
mux_2to1_tb is the testbench module scope.

The waveform should contain:

a
b
sel
y

When sel is 0, output y should follow a.

When sel is 1, output y should follow b.

Timescale Explanation
`timescale 1ns/1ps
1ns is the simulation time unit.
1ps is the simulation time precision.
Therefore, #10 represents a delay of 10 nanoseconds.
The simulator can represent timing values with precision up to 1 picosecond.
Running the Project on EDA Playground
Open EDA Playground.
Select SystemVerilog as the language.
Select a simulator such as Icarus Verilog.
Paste the DUT code into design.sv.
Paste the testbench code into testbench.sv.
Enable the option Open EPWave after run.
Click Run.
Check the output log.
Confirm that all test cases display PASS.
Open EPWave and add a, b, sel, and y.
Verify that the output follows the selected input.
Possible Testbench Failures

Even when the DUT is correct, the testbench can report a failure because of:

An incorrect expected output
Incorrect DUT port connections
Checking the output before it updates
Uninitialized input signals
Applying X or Z values
Using an incorrect comparison
Writing the test case arguments in the wrong order

Using case equality improves unknown-value detection:

if (y === expected_y)
