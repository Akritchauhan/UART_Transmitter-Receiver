class uart_transaction; 
  // Data sent to DUT
  rand bit [7:0] tx_data;
  // Data received from DUT
  bit [7:0] rx_data; 
  // Constructor 
  function new();
    tx_data = 8'h00;
    rx_data = 8'h00;
  endfunction 
  // Display transaction 
  function void display(string name);
    $display("----------------------------------------"); 
    $display("%s", name); $display("TX DATA = %h", tx_data);
    $display("RX DATA = %h", rx_data); $display("----------------------------------------"); 
  endfunction
endclass
