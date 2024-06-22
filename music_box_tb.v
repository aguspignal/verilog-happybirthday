module music_box_tb();

reg clk = 0;
always 
  #1 clk <= ~clk;

wire out;

music_box UUT (
    .clk(clk),
    .speaker_out(out)
  );

initial begin
  $dumpfile("music_box_tb.vcd");
  $dumpvars(0, music_box_tb);

  #15500

  $finish;
end

endmodule