const std = @import("std");
const mem = std.mem;

input: []const u8,
allocator: mem.Allocator,

fn getDistance(x: u32, y: u32) u32 {
    return @abs(x - y);
}

pub fn part1(this: *const @This()) !?i64 {
    // Initial Thoughts:
    // Duplicates matter
    // Distance is abs(x - y)
    // Sort both lists and iterate
    _ = this;
    return null;
}

pub fn part2(this: *const @This()) !?i64 {
    _ = this;
    return null;
}

test "it should do nothing" {
    const allocator = std.testing.allocator;
    const input = "";

    const problem: @This() = .{
        .input = input,
        .allocator = allocator,
    };

    try std.testing.expectEqual(null, try problem.part1());
    try std.testing.expectEqual(null, try problem.part2());
}

test "getDistanceCheck" {
    const x1: u32 = 1;
    const y1: u32 = 2;
    try std.testing.expectEqual(getDistance(x1, y1), 1);
}
