#!/usr/bin/env ruby

def generatePossiblePasswordsCount(low, high)
    count = 0
    for password in (low..high)
        count += 1 if testPassword(password)
    end
    count
end

def testPassword(password)

    doubleFound = false
    previous = nil
    inARow = 0
    for number in password.split('')
        if previous == nil
            previous = number.to_i
        elsif number.to_i == previous
            inARow += 1
            next
        elsif number.to_i < previous
            return false
        end
        doubleFound = true if inARow == 2
        previous = number.to_i
        inARow = 1
    end

    return doubleFound || inARow == 2
end

input = ARGV[0]
range = input.split(/-/)

puts generatePossiblePasswordsCount(range[0], range[1])