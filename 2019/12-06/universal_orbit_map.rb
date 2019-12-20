#!/usr/bin/env ruby

class Node

    attr_reader :val, :children
    attr_accessor :height, :parent

    def initialize(val, parent)
        @val = val
        @height = 0
        @children = []
        @parent = parent
    end

    def addChild(child)
        @children << child
    end

    def hash
        @val.chars.map(&:ord).to_i
    end

    def eql?(other)
        other != nil && @val == other.val
    end
    alias :== eql?

    def to_s
        "Node: #{@val}, children_count: #{@children.length}"
    end
end

class GraphNode

    attr_reader :val, :neighbors
    attr_accessor :parent, :distance

    def initialize(val, parent)
        @val = val
        @neighbors = []
        @parent = parent
        @distance = 0
    end

    def addNeighbor(neighbor)
        @neighbors << neighbor
    end

    def hash
        @val.chars.map(&:ord).to_i
    end

    def eql?(other)
        other != nil && @val == other.val
    end
    alias :== eql?

    def to_s
        "Node: #{@val}, neighbor_count: #{@neighbors.length}"
    end
end

def getOrbits(root)
    root.height = 0
    
    orbits = 0
    queue = []
    queue << root
    until queue.empty?
        node = queue.shift
        orbits += node.height
        node.children.each { |child|
            child.height = node.height + 1
            queue << child
        }
    end
    orbits
end

def findDistance(start, dest)

    queue = []
    queue << start
    visited = []

    until queue.empty?
        planet = queue.shift
        next if visited.include? planet
        return planet.distance if planet == dest
        planet.neighbors.each { |neighbor|
            neighbor.distance = planet.distance + 1
            queue << neighbor
        }
        visited << planet
    end

    raise "Destination not found"
end

planets = Hash.new

File.readlines("2019/12-06/input").each do |line|
    relation = line.split(")").map(&:chomp)
    planet = planets[relation[0]]
    if planet == nil
        planet = GraphNode.new(relation[0], nil)
        #planet = Node.new(relation[0], nil)
        planets[relation[0]] = planet
    end

    sub_planet = planets[relation[1]]
    if sub_planet == nil
        sub_planet = GraphNode.new(relation[1], planet)
        #sub_planet = Node.new(relation[1], planet)
        planets[relation[1]] = sub_planet
    end

    if sub_planet.parent == nil
        sub_planet.parent = planet
    end

    planet.addNeighbor sub_planet
    sub_planet.addNeighbor planet
end



# puts getOrbits(planets["COM"])
puts findDistance(planets["YOU"].parent, planets["SAN"].parent)

