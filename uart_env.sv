class uart_environment;
  virtual uart_interface vif;
  uart_generator gen;
  uart_driver drv;
  uart_monitor mon;
  uart_scoreboard scb;
  mailbox #(uart_transaction) gen2drv;
  mailbox #(uart_transaction) gen2scb;
  mailbox #(uart_transaction) mon2scb; 
  function new(virtual uart_interface vif);
    this.vif = vif;
    // Create mailboxes 
    gen2drv = new();
    gen2scb = new();
    mon2scb = new();
    // Create components 
    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, mon2scb);
    scb = new(gen2scb, mon2scb);
  endfunction 
  task run(); 
    fork gen.run();
      drv.run();
      mon.run(); 
      scb.run();
    join_none 
  endtask 
  task report();
    scb.report();
  endtask
endclass
