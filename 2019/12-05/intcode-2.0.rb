#!/usr/bin/env ruby

def intcode_executor(intcode)

    loop do

        puts "Enter 1 to continue, 0 to exit"
        input = gets

        if input != 1
            return
        end

        puts input

        index = 0
        while index < intcode.length

            optcode = intcode[index] % 100
    
            break if optcode == 99
    
            if optcode == 1
                param1_type = intcode[index] / 100 % 10
                param1_value = getParamValue(param1_type, intcode, index+1)
                param2_type = intcode[index] / 1000 % 10
                param2_value = getParamValue(param2_type, intcode, index+2)
    
                intcode[intcode[index+3]] = param1_value + param2_value
                index += 4
            elsif optcode == 2
                param1_type = intcode[index] / 100 % 10
                param1_value = getParamValue(param1_type, intcode, index+1)
                param2_type = intcode[index] / 1000 % 10
                param2_value = getParamValue(param2_type, intcode, index+2)
    
                intcode[intcode[index+3]] = param1_value * param2_value
                index += 4
            elsif optcode == 3
                intcode[intcode[index+1]] = input
                index += 2
            elsif optcode == 4
                print intcode[index+1]
            else
                raise "Uh oh...bad optcode"
            end
        end
    end
   
end

def getParamValue(param_type, intcode, index)
    if param_type == 0
        return intcode[intcode[index]]
    elsif param_type == 1
        return intcode[index]
    else
        raise "Uh oh...bad param_type"
    end
end

file = File.read("2019/12-05/input")

intcode = file.split(',').map(&:to_i)

#intcode_executor(intcode)

puts "getting input"
x = gets
puts "got input"
puts x