const std = @import("std");
const mem = std.mem;

input: []const u8,
allocator: mem.Allocator,

fn is_decreasing(array: []const i64) bool {
    var prev: i64 = array[0];
    for (array[1..]) |item| {
        // std.debug.print("{} : {}\n", .{ prev, item });
        const diff = @abs(prev - item);
        if (diff < 1 or diff > 3 or prev <= item) {
            return false;
        }
        prev = item;
    }
    return true;
}

fn is_increasing(array: []const i64) bool {
    var prev: i64 = array[0];
    for (array[1..]) |item| {
        // std.debug.print("{} : {}\n", .{ prev, item });
        const diff = @abs(prev - item);
        if (diff < 1 or diff > 3 or prev >= item) {
            return false;
        }
        prev = item;
    }
    return true;
}

pub fn part1(this: *const @This()) !?i64 {
    var safe_reports: i64 = 0;

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var list = std.ArrayList([]const u8).init(allocator);

    var it = mem.tokenizeSequence(u8, this.input, "\n");

    while (it.next()) |slice| {
        try list.append(slice);
    }

    for (list.items) |report| {
        var temp_list = std.ArrayList(i64).init(allocator);
        defer temp_list.deinit();
        var it2 = mem.tokenizeSequence(u8, report, " ");
        while (it2.next()) |token| {
            const parsed_int = try std.fmt.parseInt(u8, token, 10);
            try temp_list.append(parsed_int);
        }

        if (is_increasing(temp_list.items)) {
            safe_reports += 1;
        }
        if (is_decreasing(temp_list.items)) {
            safe_reports += 1;
        }
    }

    return safe_reports;
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

    try std.testing.expectEqual(11, try problem.part1());
    // try std.testing.expectEqual(null, try problem.part2());
}

// did not read the adjacency requirement...
// test "is_decreasing or increasing 1." {
//     const test_input = [_]i64{ 1, 3, 4, 7, 10, 12, 13, 17 };
//     try std.testing.expectEqual(true, is_increasing(&test_input));
//     try std.testing.expectEqual(false, is_decreasing(&test_input));
// }
//
// test "is_decreasing or increasing 2." {
//     const test_input = [_]i64{ 1, 3, 4, 7, 10, 12, 12, 17 };
//     try std.testing.expectEqual(false, is_increasing(&test_input));
//     try std.testing.expectEqual(false, is_decreasing(&test_input));
// }
//
// test "is_decreasing or increasing 3." {
//     const test_input = [_]i64{ 56, 58, 60, 61, 65, 67 };
//     try std.testing.expectEqual(true, is_increasing(&test_input));
//     try std.testing.expectEqual(false, is_decreasing(&test_input));
// }
//
// test "is_decreasing or increasing 4." {
//     const test_input = [_]i64{ 88, 85, 84, 83, 83 };
//     try std.testing.expectEqual(false, is_increasing(&test_input));
//     try std.testing.expectEqual(false, is_decreasing(&test_input));
// }
//
// test "is_decreasing or increasing 5." {
//     const test_input = [_]i64{ 88, 85, 84, 83, 82 };
//     try std.testing.expectEqual(false, is_increasing(&test_input));
//     try std.testing.expectEqual(true, is_decreasing(&test_input));
// }
