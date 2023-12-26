module main

import os
import math
import arrays


fn main() {
	// input_path := "./day09/pb1/test.txt"
	input_path := './day09/pb1/input.txt'

	lines := os.read_lines(input_path) or { panic('Could not read input file.') }
	mut sum := 0
	sequences := get_sequences(lines)
	for sequence in sequences {
		sum += extrapolate(sequence)
	}
	println('Final result: ${sum}')
}

fn get_sequences(lines []string) [][]int {
	mut result := [][]int{}
	for line in lines {
		result << line.split(" ").map(fn (s string) int { return s.int() })
	}
	return result
}

fn all_zeroes(sequence []int) bool {
	return arrays.sum(sequence.map(fn (x int) int { return math.abs(x) })) or { panic('Could not check if all elements of $sequence were 0.') } == 0
}

// Given a sequence, finds the next number
fn extrapolate(sequence []int) int {
	dif := get_all_differences(sequence)
	last := []int{len: dif.len-1, init: dif[index][dif[index].len-1]}
	return arrays.sum(last) or { panic("Could not extrapolate sequence $sequence") }
}

// Return the list of all differences of the sequence
fn get_all_differences(sequence []int) [][]int {
	mut res := [][]int{}
	res << sequence
	for {
		dif := differences(res[res.len-1])
		res << dif
		if all_zeroes(dif) {
			return res
		}
	}
	return res
}

// Given a sequence, returns the sequence of differences
fn differences(sequence []int) []int {
	return []int{len: sequence.len-1, init: sequence[index+1] - sequence[index]}
}
