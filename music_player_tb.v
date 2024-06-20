`default_nettype none
`define DUMPSTR(x) `"x.vcd`"
`timescale 100 ns / 10 ns

module music_player_tb;
    
    reg clk_t = 0;
    always begin
        clk_t = ~clk_t;
        #10;
    end

    reg rst_t = 0;
    wire speaker;

    music_player uut(
        .clk(clk_t),
        .rst(rst_t),
        .speaker(speaker)
    );

    initial begin
        $dumpfile(`DUMPSTR(`VCD_OUTPUT));
        $dumpvars(0, music_player_tb);

        rst_t = 0; #10
        rst_t = 1; #1000

        // #(DURATION) $display("End of simulation");
        $finish;
    end

endmodule
