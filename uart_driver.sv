class uart_driver; 
  virtual uart_interface vif;
  mailbox #(uart_transaction) gen2drv;
  uart_transaction trans;
  function new( virtual uart_interface vif, mailbox #(uart_transaction) gen2drv ); 
    this.vif = vif; 
    this.gen2drv = gen2drv; 
  endfunction 
  task run(); 
    forever begin 
      // Get transaction from generator
      gen2drv.get(trans);
      $display("[DRIVER] Driving Data = %h", trans.tx_data); 
      // Drive data
      @(posedge vif.clk);
      vif.txin <= trans.tx_data; 
      vif.start <= 1'b1; 
      // Start pulse
      @(posedge vif.clk); 
      vif.start <= 1'b0; 
      // Wait until transmission is complete
      wait(vif.txdone == 1'b1); 
      $display("[DRIVER] Transmission Done"); 
      // Wait for receiver 
      wait(vif.rxdone == 1'b1);
      $display("[DRIVER] Reception Done"); 
    end
  endtask
endclass
