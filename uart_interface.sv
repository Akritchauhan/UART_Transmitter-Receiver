interface uart_interface(input logic clk); 
  logic start; 
  logic [7:0] txin; 
  logic tx; 
  logic txdone; 
  logic rx; 
  logic [7:0] rxout; 
  logic rxdone; 
endinterface
