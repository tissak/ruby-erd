class ERDEntity

  attr_reader :name, :node

  def attributes=(attributes)
    attributes_as_string = attributes.collect do |key, value|
      "#{key} :#{value}"
    end.join('\l')

    @node.label = "{#{name}| #{attributes_as_string}}"
  end

  def background_color=(color)
    @node.color = color
    @node.style = :filled
  end

  def build(attributes)
    @graph = attributes[:graph]
    @name  = attributes[:name]
    # Returns a GraphViz::Node
    @node = @graph.add_nodes(name, shape: 'record')
  end

end