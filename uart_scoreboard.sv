class uart_scoreboard; 
  mailbox #(uart_transaction) gen2scb;
  mailbox #(uart_transaction) mon2scb;
  uart_transaction expected;
  uart_transaction actual;
  int pass_count = 0;
  int fail_count = 0;
  function new( mailbox #(uart_transaction) gen2scb, mailbox #(uart_transaction) mon2scb );
    this.gen2scb = gen2scb; 
    this.mon2scb = mon2scb; 
  endfunction
  task run();
    forever begin 
      // Get expected transaction
      gen2scb.get(expected); 
      // Get actual transaction 
      mon2scb.get(actual);
      $display("----------------------------------------"); 
      $display("[SCOREBOARD]"); $display("Expected = %h", expected.tx_data);
      $display("Actual = %h", actual.rx_data);
      // Compare 
      if(expected.tx_data == actual.rx_data) 
        begin $display("RESULT = PASS"); 
          pass_count++; 
        end 
      else begin 
        $display("RESULT = FAIL");
        fail_count++; 
      end $display("----------------------------------------");
    end
  endtask
  function void report();
    $display("");
    $display("========================================");
    $display(" UART VERIFICATION REPORT");
    $display("========================================");
    $display("PASS COUNT = %0d", pass_count);
    $display("FAIL COUNT = %0d", fail_count);
    if(fail_count == 0) $display("VERIFICATION PASSED");
    else $display("VERIFICATION FAILED");
    $display("========================================");
  endfunction 
endclass
