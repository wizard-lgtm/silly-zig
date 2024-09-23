///
/// so as you might know rv64 stvec looks like this
///
/// +-------------------+-------+
/// |       64-2        |  0-2  |
/// +-------------------+-------+
/// | trap_handler_addr |  mode |
/// +-------------------+-------+
///
/// so we have to set first 2 bit as mode 0 (00) [direct mode stvec]
/// the other 62 bits are going to be our function pointer
/// for more details you may check  https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf 4.14 Supervisor Trap Vector Base Address Register
///
const std = @import("std");

// fake trap handler
fn example_trap_handler() align(4) void { // aligment is important for checkign our function's last 2 bit is not would be 1
    std.debug.print("fake fake fake!\n", .{});
}

pub fn main() !void {
    const handler_ptr = &example_trap_handler;
    var handler_addr: usize = @intFromPtr(handler_ptr);
    std.debug.print("handler addr {d}, {b}\n", .{ handler_addr, handler_addr });
    const mask = ~(@as(usize, 0b11));
    handler_addr = handler_addr & mask; // make sure the first 0 bits are setted to 0

    std.debug.print("handler ptr: {p}\n", .{handler_ptr});
    std.debug.print("handler addr {d}, {b}\n", .{ handler_addr, handler_addr });
}
