class Graph
  def initialize nodes, connections
    @nodes = nodes
    @connections = connections
  end

  def neighbours node
    return @connections
      .select { |connection| connection.include? node }
      .map    { |connection| connection.find { |n| n != node } }
      .uniq
  end

end

def breadth_first graph, start
  frontier = []
  frontier.unshift start
  visited = {}
  visited[start] = true

  while !frontier.empty? do
    current = frontier.pop
    graph.neighbours(current).each do |the_next|
      if !visited.include? the_next
        frontier.unshift the_next
        visited[the_next] = true
      end
    end
  end

  return visited
end

def breadth_first_with_paths graph, start
  frontier = []
  puts "\nalgorithm start"
  puts "  frontier: #{frontier.inspect}"
  puts "  push start onto frontier"
  frontier.unshift start
  puts "  frontier: #{frontier.inspect}"
  came_from = {}
  puts "  came_from #{came_from.inspect}"

  puts "  while frontier isnt empty"
  while !frontier.empty? do
    current = frontier.pop
    puts "    current: #{current.inspect}"
    puts "    frontier: #{frontier.inspect}"
    current_neighbours = graph.neighbours(current)
    puts "    current neighbours of #{current.inspect}: #{current_neighbours.inspect}"
    puts "    iterating over current_neighbours"
    current_neighbours.each do |the_next|
      puts "      current neighbour: #{the_next.inspect}"
      if !came_from.include? the_next
        frontier.unshift the_next
        came_from[the_next] = current
        puts "      frontier: #{frontier.inspect}"
        puts "      came_from #{came_from.inspect}"
      end
    end
  end

  puts "result #{came_from.inspect}"
  return came_from
end
