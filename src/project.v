`default_nettype none

module tt_um_wunn (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // Stored WNN pattern
    wire [7:0] stored_pattern;
    assign stored_pattern = 8'b10101010;

    // Prevent unused warnings
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

    // Match detection
    wire match;
    assign match = (ui_in == stored_pattern);

    // Output
    // uo_out[0] = final match result
    // uo_out[7:1] = bitwise comparison display
    assign uo_out[0] = match;
    assign uo_out[7:1] = ~(ui_in[7:1] ^ stored_pattern[7:1]);

    // Unused bidirectional IO
    assign uio_out = 8'b0;
    assign uio_oe  = 8'b0;

endmodule

`default_nettype wire
