const expect = @import("std").testing.expect;

///
/// takes a value and n sets n'th bit to 0
///
pub fn bitwise_set_zero(value: usize, comptime n: u7) usize {
    const mask = ~(@as(usize, 1 << n));
    return value & mask;
}
///
/// takes a value and n sets n'th bit to 1
///
pub fn bitwise_set_one(value: usize, comptime n: u7) usize {
    const mask = 1 << n;
    return value | mask;
}
test "bitwise set one" {
    const value = 0b1000001; // 65
    const n: u7 = 3; // 3rd bit

    const result: usize = bitwise_set_one(value, n);

    try expect(result == @as(usize, 0b1001001));
}
test "bitwise set zero" {
    const value = 0b1000001; // 65
    const n: u7 = 0; // 0th bit

    const result: usize = bitwise_set_zero(value, n);

    try expect(result == @as(usize, 0b1000000));
}
