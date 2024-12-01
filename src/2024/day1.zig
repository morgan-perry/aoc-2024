const std = @import("std");
const mem = std.mem;
const assert = std.debug.assert;

input: []const u8,
allocator: mem.Allocator,

pub fn part1(this: *const @This()) !?i64 {
    // Initial Thoughts:
    // Duplicates matter
    // Distance is abs(x - y)
    // Sort both lists and iterate

    // Input only has 1000 lines
    var first_list = std.mem.zeroes([1000]i32);
    var second_list = std.mem.zeroes([1000]i32);

    var it = mem.tokenizeSequence(u8, this.input, "\n");

    var idx: u16 = 0;
    while (it.next()) |slice| {
        var it2 = mem.tokenizeSequence(u8, slice, " "); // Why does tokenize only like one space here?
        first_list[idx] = try std.fmt.parseInt(i32, it2.next().?, 10);
        second_list[idx] = try std.fmt.parseInt(i32, it2.next().?, 10);

        idx += 1;
        assert(idx <= 1000);
    }

    mem.sort(i32, &first_list, {}, comptime std.sort.asc(i32));
    mem.sort(i32, &second_list, {}, comptime std.sort.asc(i32));
    // Quick insanity test
    assert(first_list[0] <= first_list[first_list.len - 1]);
    assert(second_list[0] <= second_list[first_list.len - 1]);

    var total_distance: u32 = 0;

    for (first_list, second_list) |first, second| {
        total_distance += @abs(first - second);
    }

    return total_distance;
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
