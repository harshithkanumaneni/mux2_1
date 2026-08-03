`timescale 1ns/1ps

module mux_2to1_tb;

    logic a;
    logic b;
    logic sel;
    logic y;

    integer pass_count = 0;
    integer fail_count = 0;

    // DUT instantiation
    mux_2to1 dut (
        .a(a),
        .b(b),
        .sel(sel),
        .y(y)
    );

    // Task to apply inputs and verify output
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

            if (y == expected_y) begin
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

    // Waveform generation
    initial begin
        $dumpfile("mux_waveform.vcd");
        $dumpvars(0, mux_2to1_tb);
    end

    // Stimulus generation
    initial begin

        a   = 0;
        b   = 0;
        sel = 0;

        $display("-------------------------------------");
        $display("2:1 Multiplexer Verification Started");
        $display("-------------------------------------");

        // Test case 1
      apply_test(0, 0, 0, 1);

        // Test case 2
        apply_test(1, 0, 0, 1);

        // Test case 3
        apply_test(0, 1, 1, 1);

        // Test case 4
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