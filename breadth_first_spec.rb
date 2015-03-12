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

Point = Struct.new(:name, :x, :y) do
  def to_s
    return name
  end
  def inspect
    return name
  end
end

def terse_point symbol, x, y
  return Point.new symbol, x, y
end

describe 'graph.neighbours' do

  before do
    @nodes = {
      :a => [:b, :c],
      :b => [],
      :c => []
    }

    @graph = Graph.new(@nodes)
  end

  it 'returns the neighbours of a node in a graph' do
    expect(@graph.neighbours(:a)).to eq [:b, :c]
  end

end

describe 'graph with weights #cost' do

  it 'returns the cost of a connection' do
    nodes = {
      :a => [:b, :c],
      :b => [],
      :c => []
    }
    weights = Hash.new(0)
    weights[[:a, :b]] = 3

    expect(GraphWithWeights.new(nodes, weights).cost(:a, :b)).to eq 3
  end

end

describe 'breadth first' do

  before do
    @nodes = {
      :a => [:b, :c],
      :b => [],
      :c => [:b]
    }

    @graph = Graph.new(@nodes)
  end

  it "visits all the nodes in a graph" do
    expect(breadth_first(@graph, :a).keys).to include :a, :b, :c
  end

end

describe 'path finder' do

  it 'follows a hash of path directions' do
    nodes = {
      a: [:b],
      b: [:c, :d],
      c: [],
      d: []
    }
    graph = Graph.new(nodes)

    path_directions = breadth_first_path_finder(graph, :a)

    expect(path(:a, :d, path_directions)).to eq [:a, :b, :d]
  end

end

describe 'priority queue' do

  it 'returns the item first queued if no priority' do
    queue = InversePriorityQueue.new
    queue.put :a, 1
    queue.put :b, 1
    expect(queue.get).to eq :a
    expect(queue.get).to eq :b
  end

  it 'returns the last item added with the highest priority' do
    queue = InversePriorityQueue.new
    queue.put :c, 0
    queue.put :a, 1
    queue.put :b, 1
    expect(queue.get).to eq :c
    expect(queue.get).to eq :a
    expect(queue.get).to eq :b
  end
end

describe "dijkstra's algorithm" do

  it 'prioritises paths of least resistance' do
    nodes = {
      a: [:b],
      b: [:c, :d],
      c: [:e],
      d: [:e],
      e: []
    }

    weights = Hash.new(0)
    weights[[:b, :d]] = 3

    graph = GraphWithWeights.new(nodes, weights)
    expect(dijkstra(:a, :e, graph)).to eq [:a, :b, :c, :e]
  end

end

describe 'a star' do

  before do
    @a = terse_point :a, 10, 10
    @b = terse_point :b, 12, 12
    @c = terse_point :c, 14, 14
    @d = terse_point :d, 8, 8
    @e = terse_point :e, 6, 6

    nodes = {
      @a => [@b],
      @b => [@c, @d],
      @c => [@e],
      @d => [@e],
      @e => []
    }

    weights = Hash.new(0)
    weights[[@b, @d]] = 3

    @graph = GraphWithWeights.new(nodes, weights)
  end

  it 'only searches in the direction of the goal' do
    expect(greedy(@a, @c, @graph)).to_not include @e
  end

  it 'finds a path' do
    expect(path(@a, @c, astar(@a, @c, @graph))).to include @a, @b, @c
  end

end
