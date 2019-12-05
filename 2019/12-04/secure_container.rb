#!/usr/bin/env ruby

# Generates the number of combinations of numbers that satisfy a set of
#   requirements within the given range.
#
# @param [Integer] low The low end of the range.
# @param [Integer] high The high end of the range.
# @return [Integer] The total count of valid combinations.
def generatePossibleCombinationsCount(low, high)
    count = 0
    for number in (low..high)
        count += 1 if testNumber(number)
    end
    count
end

# Test if the given number satisfies the following requirements:
#   - The digits must be in ascending order.
#   - There must exist a digits that repeats EXACTLY twice.
#
# @param [Integer] number The number being tested.
# @return true on success; false otherwise.
def testNumber(number)

    doubleFound = false
    previous = nil
    inARow = 0

    # Loop through each digit.
    for digit in number.split('')

        if previous == nil
            previous = digit.to_i
        elsif digit.to_i == previous
            inARow += 1
            next    # Skip re-initialization at the bottom of the loop.
        elsif digit.to_i < previous
            return false    # Short-circuit if this number is greater than the previous.
        end

        # A double was only found if the number of identical numbers in
        #   a row is two.
        doubleFound = true if inARow == 2

        # Re-initialize variables to account for the new number that was reached.
        previous = digit.to_i
        inARow = 1
    end

    
    return doubleFound || inARow == 2
end

# Get the current range.
input = ARGV[0]
range = input.split(/-/)

puts generatePossibleCombinationsCount(range[0], range[1])