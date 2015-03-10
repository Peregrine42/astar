describe 'graph.neighbours' do
  it 'returns the neighbours of a node in a graph' do
    graph = Graph.new(nodes, links)
    expect(graph.neighbours(a)).to eq [b, c, d]
  end
end

describe 'breadth first' do

  xit "visits all the nodes in a graph" do
  end

end
