class uart_test;
  virtual uart_interface vif;
  uart_environment env; 
  function new(virtual uart_interface vif);
    this.vif = vif;
    env = new(vif);
  endfunction 
  task run(); 
    $display("");
    $display("========================================");
    $display(" UART TEST STARTED"); 
    $display("========================================"); 
    // Start environment 
    env.run();
    // Wait for all transactions 
    #5000; 
    // Print result 
    env.report(); 
    $display("");
    $display("========================================");
    $display(" UART TEST COMPLETED");
    $display("========================================");
  endtask 
endclass
