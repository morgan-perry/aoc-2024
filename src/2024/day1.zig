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
    // This time duplicates don't matter in the left list
    // Hash Set of first list
    // Iterate over each
    //
    // Could instead keep the appearance no. in the hashmap data
    // Now its a O(n) algo

    // Copied from part 1, not worth to create a function r.n.
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

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var map = std.AutoArrayHashMap(i32, u16).init(
        allocator,
    );
    defer map.deinit();

    for (first_list) |first| {
        try map.put(first, 0);
    }
    assert(map.count() <= 1000);
    for (second_list) |second| {
        if (map.get(second) != null) {
            map.getPtr(second).?.* += 1;
        }
    }

    var similarity: i32 = 0;
    var map_iter = map.iterator();

    while (map_iter.next()) |frequency| {
        similarity += frequency.value_ptr.* * frequency.key_ptr.*;
        assert((frequency.key_ptr.* * frequency.value_ptr.*) >= 0);
    }

    return similarity;
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
