#!/usr/bin/env ruby

def intcode_executor(intcode)

    index = 0

    while index < intcode.length
        break if intcode[index] == 99
        if intcode[index] == 1
            intcode[intcode[index+3]] = intcode[intcode[index+1]] + intcode[intcode[index+2]]
        elsif intcode[index] == 2
            intcode[intcode[index+3]] = intcode[intcode[index+1]] * intcode[intcode[index+2]]
        else
            break
        end
        index += 4
    end
    intcode[0]
end

file = File.read("input")

for i in (0...100)
    for j in (0...100)
        intcode = file.split(',').map(&:to_i)
        intcode[1] = i
        intcode[2] = j
        puts "#{i}, #{j}" if intcode_executor(intcode) == 19690720
    end
end