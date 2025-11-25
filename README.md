UART Transmitter–Receiver (Verilog)

This project implements a UART Transmitter and Receiver module entirely in Verilog HDL.
It supports 8-bit data, start/stop bit framing, and works with a configurable clock and baud rate.

🔧 Features
✅ UART Transmitter

Sends 8-bit serial data

Adds start bit (0) and stop bit (1) automatically

Uses a configurable clock divider (based on clk_value and baud)

Generates a txdone pulse after transmission completes

FSM-based design: IDLE → SEND → CHECK

✅ UART Receiver

Detects start bit

Samples incoming bits at mid-bit timing for accuracy

Reconstructs 8-bit parallel data

Generates rxdone pulse after receiving 1 full frame

FSM-based design: IDLE → RWAIT → RECV

✅ Additional

Loopback possible (TX → RX) for testing

Fully synchronous to posedge clk

No external IPs required

📁 File: main.v

This file contains:

Baud-rate generator

UART Transmitter module

UART Receiver module

State machines for both TX and RX

Parallel-to-serial (TX) and serial-to-parallel (RX) logic

⚙️ Parameters
parameter clk_value = 100_000;  // System clock frequency
parameter baud = 9600;          // UART baud rate
parameter wait_count = clk_value / baud;


Adjust clk_value and baud to match your FPGA board.

🧠 How It Works
Transmitter Operation

On start = 1, the module loads {stop_bit, data, start_bit}

Each bit is sent after wait_count cycles

txdone becomes 1 after the last bit

Receiver Operation

Waits for the falling edge (start bit)

Delays half bit-time for correct sampling

Samples each of the 10 bits

Extracts received byte → rxout

rxdone goes HIGH after reception

🧪 Simulation / Testing

You can test UART loopback by connecting:

tx → rx


Expected behavior:

When start = 1, transmitter sends txin

Receiver reconstructs data and asserts rxdone = 1

Output appears on rxout

📦 Usage
Instantiation
main uart_unit (
    .clk(clk),
    .start(start),
    .txin(txin),
    .tx(tx),
    .rx(rx),
    .rxout(rxout),
    .rxdone(rxdone),
    .txdone(txdone)
);

📚 Applications

FPGA-to-FPGA communication

FPGA to PC via USB-UART

Low-speed serial debugging

Embedded systems communication

📝 Future Improvements

Parity bit support

Configurable stop bits

FIFO buffers

Higher baud rate support

Separate TX and RX modules

If you want, I can also create:

✅ GitHub description
✅ Commit message
✅ Folder structure
✅ Block diagram (image)
✅ Simulation testbench
