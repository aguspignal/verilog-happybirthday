module frequency_divider #(parameter CLK_DIV = 12000) (
  input wire clk, 
  output wire clk_out
);

// Bits necesarios para representar CLK_DIV
// No podemos fijar un valor constante porque para las notas
// necesitamos 2^16 pero para el clk_note_duration 2^22
parameter N = $clog2(CLK_DIV);

reg [N-1:0] counter = 0;

always @(posedge clk)
  if (counter == CLK_DIV - 1)
    counter <= 0;
  else 
    counter <= counter + 1;

assign clk_out = counter[N-1];

endmodule