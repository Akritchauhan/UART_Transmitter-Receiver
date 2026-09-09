class uart_monitor;
virtual uart_interface vif; 
  mailbox #(uart_transaction) mon2scb;
  uart_transaction trans; 
  function new( virtual uart_interface vif, mailbox #(uart_transaction) mon2scb ); 
    this.vif = vif; 
    this.mon2scb = mon2scb; 
  endfunction 
  task run(); 
    forever begin
      // Wait for receiver completion
      @(posedge vif.rxdone);
      trans = new(); 
      // Capture received data 
      trans.rx_data = vif.rxout; 
      $display("[MONITOR] Received Data = %h", trans.rx_data); 
      // Send received transaction
      mon2scb.put(trans); 
    end 
  endtask
endclass
