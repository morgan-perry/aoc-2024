const std = @import("std");
const mem = std.mem;

input: []const u8,
allocator: mem.Allocator,

fn check_xmas(c1: u8, c2: u8, c3: u8, c4: u8) bool {
    // zig fmt: off
    const new_xmas = [_]u8{c1, c2, c3, c4};
    const target = [_]u8{'X', 'M', 'A', 'S'};
    // zig fmt: on
    return mem.eql(u8, &new_xmas, &target);
}

pub fn part1(this: *const @This()) !?i64 {
    var found_words: i64 = 0;
    var a: [140][140]u8 = mem.zeroes([140][140]u8);
    var it = mem.tokenizeScalar(u8, this.input, '\n');
    var array_init_idx: u64 = 0;
    // transfer to 2d array
    while (it.next()) |next| {
        for (next, 0..) |char, idx| {
            a[array_init_idx][idx] = char;
        }
        array_init_idx += 1;
    }
    for (a, 0..) |row, ri| {
        for (row, 0..) |char, ci| {
            _ = char;
            // Horizontal left to right
            if (ci <= 140 - 4) {
                if (check_xmas(a[ri][ci], a[ri][ci + 1], a[ri][ci + 2], a[ri][ci + 3])) found_words += 1;
            }

            // Horizontal right to left
            if (ci >= 3) {
                if (check_xmas(a[ri][ci], a[ri][ci - 1], a[ri][ci - 2], a[ri][ci - 3])) found_words += 1;
            }

            // Vertical top to bottom
            if (ri <= 140 - 4) {
                if (check_xmas(a[ri][ci], a[ri + 1][ci], a[ri + 2][ci], a[ri + 3][ci])) found_words += 1;
            }

            // Vertical bottom to top
            if (ri >= 3) {
                if (check_xmas(a[ri][ci], a[ri - 1][ci], a[ri - 2][ci], a[ri - 3][ci])) found_words += 1;
            }

            // Diagonal top-left to bottom-right
            if (ci <= 140 - 4 and ri <= 140 - 4) {
                if (check_xmas(a[ri][ci], a[ri + 1][ci + 1], a[ri + 2][ci + 2], a[ri + 3][ci + 3])) found_words += 1;
            }

            // Diagonal bottom-right to top-left
            if (ci >= 3 and ri >= 3) {
                if (check_xmas(a[ri][ci], a[ri - 1][ci - 1], a[ri - 2][ci - 2], a[ri - 3][ci - 3])) found_words += 1;
            }

            // Diagonal top-right to bottom-left
            if (ci >= 3 and ri <= 140 - 4) {
                if (check_xmas(a[ri][ci], a[ri + 1][ci - 1], a[ri + 2][ci - 2], a[ri + 3][ci - 3])) found_words += 1;
            }

            // Diagonal bottom-left to top-right
            if (ci <= 140 - 4 and ri >= 3) {
                if (check_xmas(a[ri][ci], a[ri - 1][ci + 1], a[ri - 2][ci + 2], a[ri - 3][ci + 3])) found_words += 1;
            }
        }
    }
    return found_words;
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
