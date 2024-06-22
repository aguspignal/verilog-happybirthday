// `timescale 1ms / 1ms

module music_box_tb();

reg clk = 0;
always 
  #1 clk <= ~clk;

wire out;

// Si se pusiesen los valores reales la simulacion
// seria inviable, asi que usamos valores de prueba solo
// para ver que se sincronizen las notas de forma secuenciada
music_box #(
  .note_C(9), 
  .note_D(8), 
  .note_E(7), 
  .note_F(6), 
  .note_G(5), 
  .note_A(4), 
  .note_AHash(3), 
  .note_PlusC(2), 
  .note_duration(12)
  )
  UUT (
    .clk(clk),
    .speaker_out(out)
  );

initial begin
  $dumpfile("music_box_tb.vcd");
  $dumpvars(0, music_box_tb);

  #800

  $finish;
end

endmodule