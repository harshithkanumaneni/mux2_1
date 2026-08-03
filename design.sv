// Code your design here
`timescale 1ns/1ps

module mux_2to1 (
    input  logic a,
    input  logic b,
    input  logic sel,
    output logic y
);

    // 2:1 multiplexer logic
    always_comb begin
       if (sel == 0)
            y = a;
        else
            y = b;
    end

endmodule