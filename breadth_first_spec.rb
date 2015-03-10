require './breadth-first'

describe 'graph.neighbours' do
  it 'returns the neighbours of a node in a graph' do
    a = double :a
    b = double :b
    c = double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c]]
    graph = Graph.new(nodes, links)
    expect(graph.neighbours(a)).to eq [b, c]
  end

  it 'returns the neighbours of a node in a graph with loops' do
    a = double :a
    b = double :b
    c = double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c], [c, b]]
    graph = Graph.new(nodes, links)
    expect(graph.neighbours(a)).to eq [b, c]
  end

  it 'returns neighbours in a graph with connections in both directions' do
    a = double :a
    b = double :b
    c = double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c], [c, b], [c, a]]
    graph = Graph.new(nodes, links)
    expect(graph.neighbours(a)).to eq [b, c]
  end
end

describe 'breadth first' do

  it "visits all the nodes in a graph" do
    a = double :a
    b = double :b
    c = double :c

    nodes = [a, b, c]
    links = [[a, b], [a, c], [c, b]]
    graph = Graph.new(nodes, links)

    expect(breadth_first(graph, a).keys).to include a, b, c
  end

end
