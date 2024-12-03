const std = @import("std");
const mem = std.mem;
const regex = std.regex;

input: []const u8,
allocator: mem.Allocator,

pub fn part1(this: *const @This()) !?u64 {
    // For reference I could not be assed to write a manual parser and zig has no std.regex parser, so a python script was used (day3-python-script.py)
    // Regex Used: (\d{1,3}),(\d{1,3})
    // They are seperated by newlines and only contain the numbers seperated by commas
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const ally = gpa.allocator();

    const Pair = struct { left: u64, right: u64 };
    var list = std.MultiArrayList(Pair){};
    var it = mem.tokenizeSequence(u8, this.input, "\n");
    while (it.next()) |slice| {
        var it2 = mem.tokenizeSequence(u8, slice, ",");
        while (it2.peek() != null) {
            try list.append(ally, Pair{
                .left = try std.fmt.parseInt(u64, it2.next().?, 10),
                .right = try std.fmt.parseInt(u64, it2.next().?, 10),
            });
        }
    }
    const left = list.items(.left);
    const right = list.items(.right);
    var sum: u64 = 0;
    for (left, right) |a, b| sum += (a * b);

    return sum;
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
