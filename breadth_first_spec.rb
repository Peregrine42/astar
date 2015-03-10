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
