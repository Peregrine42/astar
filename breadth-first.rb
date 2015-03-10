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
