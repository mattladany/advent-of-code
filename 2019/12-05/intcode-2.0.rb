#!/usr/bin/env ruby

# Executes the provided Intcode.
# 
# @param [Integer[]] intcode The Intcode being processed.
def intcode_executor(intcode)

    index = 0
    while index < intcode.length

        # Get the optcode for this instruction.
        optcode = intcode[index] % 100

        # Short-circuit if the program should exit.
        break if optcode == 99

        # Get the paramter values (in case they are needed).
        param1_value = getParamValue(intcode[index] / 100 % 10, intcode, index+1)
        param2_value = getParamValue(intcode[index] / 1000 % 10, intcode, index+2)

        case optcode

        # Add parameter values.
        when 1
            intcode[intcode[index+3]] = param1_value + param2_value
            index += 4

        # Multiply parameter values.
        when 2
            intcode[intcode[index+3]] = param1_value * param2_value
            index += 4

        # Save the input value to a location.
        when 3
            puts "Enter 1 to continue, 0 to exit"
            input = gets.chomp
            intcode[intcode[index+1]] = input.to_i
            index += 2

        # Print the parameter value.
        when 4
            puts param1_value
            index += 2

        # Jump if true.
        when 5
            if param1_value != 0
                index = param2_value
            else
                index += 3
            end

        # Jump if false.
        when 6
            if param1_value == 0
                index = param2_value
            else
                index += 3
            end

        # Check if less than.
        when 7
            if param1_value < param2_value
                intcode[intcode[index+3]] = 1
            else
                intcode[intcode[index+3]] = 0
            end
            index += 4

        # Check if equals.
        when 8
            if param1_value == param2_value
                intcode[intcode[index+3]] = 1
            else
                intcode[intcode[index+3]] = 0
            end
            index +=4
        else
            raise "Uh oh...bad optcode"
        end
    end
end

# Gets a particular parameter value from the intcode provided.
# 
# @param [Integer] param_type The type of the parameter.
#   This can be one of two values:
#       - 0 : if the parameter holds an address.
#       - 1 : if the parameter holds a value.
# @param [Integer[]] intcode The Intcode being processed.
# @param [Integer] index The index the parameter information is located at.
def getParamValue(param_type, intcode, index)
    if param_type == 0
        return intcode[intcode[index]]
    elsif param_type == 1
        return intcode[index]
    else
        raise "Uh oh...bad param_type"
    end
end

file = File.read("input")

intcode = file.split(',').map(&:to_i)

intcode_executor(intcode)