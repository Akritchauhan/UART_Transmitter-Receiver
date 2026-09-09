class uart_generator;
  uart_transaction trans;
  mailbox #(uart_transaction) gen2drv;
  int number_of_transactions = 10;
  function new(mailbox #(uart_transaction) gen2drv);
    this.gen2drv = gen2drv; 
  endfunction task run();
    repeat(number_of_transactions)
      begin trans = new(); 
        // Generate random 8-bit data 
        assert(trans.randomize());
        $display("[GENERATOR] Generated Data = %h", trans.tx_data); 
        // Send transaction to driver 
        gen2drv.put(trans); 
      end 
  endtask
endclass
