module main

import os

fn main() {
	// input_path := "./day01/pb1/test.txt"
	input_path := './day01/pb1/input.txt'

	lines := os.read_lines(input_path) or { panic('Could not read input file.') }
	mut sum := 0 // will contain the final result
	for line in lines {
		line_nums := get_line_nums(line)
		sum += get_line_number(line_nums)
	}
	println('Final result: ${sum}')
}

// Given a string, returns the array of all numbers in this string
fn get_line_nums(line string) []rune {
	nums := [`0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`]
	mut line_nums := []rune{}
	for c in line {
		if rune(c) in nums {
			line_nums << rune(c)
		}
	}
	return line_nums
}

// Given a array of digits as runes, returns the 2-digits number formed by
// the first digit in the array, concatenated with the last digit in the array.
fn get_line_number(nums []rune) int {
	// runes cannot be concatenated easily. So first cast to string, concatenate and cast to int.
	mut res := rune(nums[0]).str()
	res += rune(nums[nums.len - 1]).str()
	return res.int()
}
