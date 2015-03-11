require './breadth-first'

Double = Struct.new(:name) do
  def to_s
    return name
  end
  def inspect
    return name
  end
end

def terse_double symbol
  return Double.new symbol
end

describe 'graph.neighbours' do
  it 'returns the neighbours of a node in a graph' do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c]]
    graph = Graph.new(nodes, links)
    expect(graph.neighbours(a)).to eq [b, c]
  end

  it 'returns the neighbours of a node in a graph with loops' do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c], [c, b]]
    graph = Graph.new(nodes, links)
    expect(graph.neighbours(a)).to eq [b, c]
  end

  it 'returns neighbours in a graph with connections in both directions' do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c], [c, b], [c, a]]
    graph = Graph.new(nodes, links)
    expect(graph.neighbours(a)).to eq [b, c]
  end
end

describe 'graph.cost' do

  it 'returns the cost of a connection' do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c
    d = terse_double :d
    e = terse_double :e
    nodes = [a, b, c, d, e]
    links = [
      [a, b, 1],
      [b, c, 1],
      [b, d, 3],
      [c, e, 1],
      [d, e, 1]
    ]

    expect(Graph.new(nodes, links).cost(b, d)).to eq 3
  end

end

describe 'breadth first' do

  it "visits all the nodes in a graph" do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c], [c, b]]
    graph = Graph.new(nodes, links)

    expect(breadth_first(graph, a).keys).to include a, b, c
  end

end

describe 'breadth first with paths' do

  it "produces all the links in a graph" do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c], [c, b]]
    graph = Graph.new(nodes, links)

    expect(breadth_first_with_paths(graph, a)).to include(
      {
        b => a,
        c => a,
        a => b
      })
  end

end

describe 'path finder' do

  it 'follows a hash of path directions' do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c
    d = terse_double :d

    nodes = [a, b, c, d]
    links = [[a, b], [b, c], [b, d]]
    graph = Graph.new(nodes, links)

    path_directions = breadth_first_with_paths(graph, a)

    expect(path(a, d, path_directions)).to eq [a, b, d]
  end

end

describe 'breadth-first path finder' do

  it 'builds and follows a hash of path directions' do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c
    d = terse_double :d

    nodes = [a, b, c, d]
    links = [[a, b], [b, c], [b, d]]
    graph = Graph.new(nodes, links)

    expect(breadth_first_path_finder(a, d, graph)).to eq [a, b, d]
  end

end

describe 'priority queue' do

  it 'returns the item with the highest priority' do
    queue = PriorityQueue.new
    queue.put :c, 6
    queue.put :a, 1
    queue.put :b, 2
    expect(queue.get).to eq :c
  end
end

describe "dijkstra's algorithm" do

  it 'prioritises paths of least resistance' do
    a = terse_double :a
    b = terse_double :b
    c = terse_double :c
    d = terse_double :d
    e = terse_double :e

    nodes = [a, b, c, d, e]
    links = [
      [a, b, 1],
      [b, c, 1],
      [b, d, 3],
      [c, e, 1],
      [d, e, 1]
    ]

    graph = Graph.new(nodes, links)
    expect(dijkstra(a, e, graph)).to eq [a, b, c, e]
  end

end
