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

  def cost the_start, the_end
    #puts "connections: #{@connections}"
    result = @connections.find { |array|
      array[0] == the_start
      array[1] == the_end
    }
    if result.nil?
      result = @connections.find { |array|
        array[0] == the_end
        array[1] == the_start
      }
    end
    result[2]
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

def path start, goal, came_from
  #puts "path_start"
  #puts start.inspect
  #puts goal.inspect
  #puts came_from
  current = goal
  path = [current]
  while current != start
    current = came_from[current]
    path.unshift(current)
  end
  return path
end

def breadth_first_path_finder start, goal, graph
  frontier = []
  frontier.unshift start
  came_from = {}

  while !frontier.empty? do
    current = frontier.pop

    if current == goal
      break
    end

    current_neighbours = graph.neighbours(current)
    current_neighbours.each do |the_next|
      if !came_from.include? the_next
        frontier.unshift the_next
        came_from[the_next] = current
      end
    end
  end

  return path(start, goal, came_from)
end

class PriorityQueue

  def initialize
    @queue = []
  end

  def put item, priority
    @queue.push [item, priority]
  end

  def empty?
    @queue.empty?
  end

  def get
    @queue.sort! { |a, b| a[1] <=> a[1] }
    result = @queue.shift
    return result[0]
  end

end

def dijkstra(start, goal, graph)
  frontier = PriorityQueue.new
  frontier.put(start, 0)
  came_from = {}
  cost_so_far = {}
  came_from[start] = nil
  cost_so_far[start] = 0

  while !frontier.empty?
    current = frontier.get

    break if current == goal

    graph.neighbours(current).each do |the_next|
      #puts "145: #{cost_so_far[current]}"
      #puts "current: #{current.inspect}"
      #puts "the_next: #{the_next.inspect}"
      #puts graph.cost(current, the_next)
      new_cost = cost_so_far[current] + graph.cost(current, the_next)
      if !cost_so_far.include?(the_next) || (new_cost < cost_so_far[the_next])
        cost_so_far[the_next] = new_cost
        priority = new_cost
        frontier.put(the_next, priority)
        came_from[the_next] = current
      end
    end
  end
  #puts came_from
  return path(start, goal, came_from)
end
