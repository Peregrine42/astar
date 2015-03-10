def breadth_first graph
  frontier = Queue.new
  frontier.put start
  visited = {}
  visited[start] = true

  while !frontier.empty? do
    current = frontier.get
    graph.neighbours(current).each do |the_next|
      if !visited.include? the_next
        frontier.put the_next
        visited[the_next] = true
      end
    end
  end

  return visited
end
