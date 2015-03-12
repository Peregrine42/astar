class Graph
  def initialize edges
    @edges = edges
  end

  def neighbours edge
    return @edges[edge]
  end
end

class GraphWithWeights
  def initialize edges, weights
    @edges = edges
    @weights = weights
  end

  def neighbours edge
    return @edges[edge]
  end

  def cost a, b
    @weights[[a, b]]
  end
end

class Queue
  def initialize
    @elements = []
  end

  def empty?
    @elements.empty?
  end

  def put x
    @elements.push x
  end

  def get
    @elements.shift
  end
end

def breadth_first graph, start
  frontier = Queue.new
  frontier.put start
  visited = {}
  visited[start] = true

  while not frontier.empty? do
    current = frontier.get
    puts "Visiting #{current}"
    graph.neighbours(current).each do |the_next|
      unless visited.include? the_next
        frontier.put the_next
        visited[the_next] = true
      end
    end
  end
  visited
end

def breadth_first_path_finder graph, start
  frontier = []
  frontier.unshift start
  came_from = {}

  while !frontier.empty? do
    current = frontier.pop
    current_neighbours = graph.neighbours(current)
    current_neighbours.each do |the_next|
      if !came_from.include? the_next
        frontier.unshift the_next
        came_from[the_next] = current
      end
    end
  end

  came_from
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

class InversePriorityQueue

  def initialize
    @queue = Hash.new { |hash, key| hash[key] = [] }
  end

  def empty?
    @queue.values.all?(&:empty?)
  end

  def put item, priority
    @queue[priority].push item
  end

  def get
    #puts "queue before: #{@queue.inspect}"
    priority = @queue.keys.min
    #puts priority
    result = @queue[priority].shift
    @queue.delete priority if @queue[priority].empty?
    #puts "queue after: #{@queue.inspect}"

    result
  end

end

def dijkstra start, goal, graph
  frontier = InversePriorityQueue.new
  frontier.put(start, 0)
  came_from = {}
  cost_so_far = {}
  came_from[start] = nil
  cost_so_far[start] = 0

  until frontier.empty?
    current = frontier.get

    break if current == goal

    graph.neighbours(current).each do |the_next|
      new_cost = cost_so_far[current] + graph.cost(current, the_next)
      if (not cost_so_far.include?(the_next)) || (new_cost < cost_so_far[the_next])
        cost_so_far[the_next] = new_cost
        priority = new_cost
        frontier.put(the_next, priority)
        came_from[the_next] = current
      end
    end
  end
  return path(start, goal, came_from)
end

def heuristic a, b
  return (a.x - b.x).abs + (a.y - b.y).abs
end

def greedy start, goal, graph
  frontier = InversePriorityQueue.new
  frontier.put(start, 0)
  came_from = {}
  came_from[start] = nil

  while !frontier.empty?
    current = frontier.get()

    if current == goal
      break
    end

    graph.neighbours(current).each do |the_next|
      if !came_from.include? the_next
        priority = heuristic(goal, the_next)
        frontier.put(the_next, priority)
        came_from[the_next] = current
      end
    end
  end

  return came_from
end

def astar start, goal, graph
  frontier = InversePriorityQueue.new
  frontier.put(start, 0)
  came_from = {}
  cost_so_far = {}
  came_from[start] = nil
  cost_so_far[start] = 0

  until frontier.empty?
    current = frontier.get

    break if current == goal

    graph.neighbours(current).each do |the_next|

      new_cost = cost_so_far[current] + graph.cost(current, the_next)

      if (!cost_so_far.include? the_next) || (new_cost < cost_so_far[the_next])
        cost_so_far[the_next] = new_cost
        priority = new_cost + heuristic(goal, the_next)
        frontier.put(the_next, priority)
        came_from[the_next] = current
      end
    end
  end

  came_from
end
