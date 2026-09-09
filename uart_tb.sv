`timescale 1ns / 1ps
module uart_tb; 
  logic clk;
  initial begin clk = 1'b0;
    forever #5 clk = ~clk;
  end
    uart_interface
  intf(clk);
main #( .CLK_FREQ (100_000), .BAUD_RATE (9600) ) 
  DUT ( .clk (intf.clk), 
       .start (intf.start),
       .txin (intf.txin),
       .tx (intf.tx),
       .txdone (intf.txdone),
       .rx (intf.rx),
       .rxout (intf.rxout), 
       .rxdone (intf.rxdone) ); 
assign intf.rx = intf.tx;
initial begin 
   // Initialize signals
  intf.start = 1'b0;
  intf.txin = 8'h00; 
  // Wait for initialization 
  #100;
  // Create test uart_test test; 
  test = new(intf);
  // Run test 
  test.run(); 
  // Finish simulation 
  #100;
  $finish;
end 
  initial begin 
    $dumpfile("uart_tb.vcd");
    $dumpvars(0, uart_tb); 
  end 
endmodule
