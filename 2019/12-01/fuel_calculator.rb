#!/usr/bin/env ruby

total_fuel = 0

file = File.open("mass-input", "r")

file.each_line { |mass| 
    current_mass = mass.to_i
    loop do
        current_mass = current_mass / 3 - 2
        break if current_mass <= 0
        total_fuel += current_mass
    end
}

puts total_fuel