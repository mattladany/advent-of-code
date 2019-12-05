#!/usr/bin/env ruby

require 'set'

class Coordinate
    attr_accessor :x, :y, :distance

    def initialize(x, y, distance)
        @x = x
        @y = y
        @distance = distance
    end

    def hash
        "#{@x}#{@y}".to_i
    end

    def eql?(other)
        @x == other.x && @y == other.y
    end
    alias :== eql?

    def to_s
        "#{@x}, #{@y}"
    end
end

class Intersection
    attr_accessor :one, :two
    def initialize(one, two)
        @one = one
        @two = two
    end
end

def generateCoordinates(wire)

    coordinates = Set.new([])
    current_x = 0
    current_y = 0
    distance = 0

    wire.each { |path_partial|

        prev_distance = distance
        
        case path_partial[0]
        when "R"
            for j in (current_x + 1..current_x + path_partial[1...path_partial.length].to_i)
                current_x = j
                distance += 1
                coordinates << Coordinate.new(j, current_y, distance)
            end
        when "L"
            (current_x - 1).downto(current_x - path_partial[1...path_partial.length].to_i) { |j|
                current_x = j
                distance += 1
                coordinates << Coordinate.new(j, current_y, distance)
            }
        when "U"
            for j in (current_y + 1..current_y + path_partial[1...path_partial.length].to_i)
                current_y = j
                distance += 1
                coordinates << Coordinate.new(current_x, j, distance)
            end
        when "D"
            (current_y - 1).downto(current_y - path_partial[1...path_partial.length].to_i) { |j|
                current_y = j
                distance += 1
                coordinates << Coordinate.new(current_x, j, distance)
            }
        end
    }
    coordinates.delete(Coordinate.new(0,0,0))
end

def calcManhattanDistance(coordinate)
    coordinate.x.abs + coordinate.y.abs
end

def calcDistanceTraveled(intersection)
    intersection.one.distance + intersection.two.distance
end

file = File.read("input")

lines = file.split(/\n/)

wire1 = lines[0].split(',')
wire2 = lines[1].split(',')

wire1_coordinates = generateCoordinates wire1
wire2_coordinates = generateCoordinates wire2

unique_intersections = wire1_coordinates & wire2_coordinates

intersections = []
unique_intersections.each { |coordinate|
    one = wire1_coordinates.filter {|sub_coordinate| coordinate == sub_coordinate} .pop
    two = wire2_coordinates.filter {|sub_coordinate| coordinate == sub_coordinate} .pop
    intersections << Intersection.new(one, two)
}
#lowest_intersection = nil
#intersections.each { |intersection| 
#    manhattanDistance = calcManhattanDistance(intersection)
#    lowest_intersection = manhattanDistance if lowest_intersection == nil
#    lowest_intersection = manhattanDistance if lowest_intersection >= manhattanDistance
#}

shortest_distance = nil
intersections.each { |intersection| 
    manhattanDistance = calcDistanceTraveled(intersection)
    shortest_distance = manhattanDistance if shortest_distance == nil
    shortest_distance = manhattanDistance if shortest_distance >= manhattanDistance
}

puts shortest_distance