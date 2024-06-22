`include "constants.vh"

module frequency_divider(
  input wire clk, 
  output wire clk_out
);

parameter CLK_DIV = 12000;

// bits necesarios para representar CLK_DIV
localparam N = $clog2(CLK_DIV);

reg [N-1:0] counter = 0;

//-- Contador de modulo DIV
always @(posedge clk)
  if (counter == CLK_DIV - 1)
    counter <= 0;
  else 
    counter <= counter + 1;

assign clk_out = counter[N-1];

endmodule