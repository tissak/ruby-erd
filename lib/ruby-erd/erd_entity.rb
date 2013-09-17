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

  def gradient=(attributes)
    @node.fillcolor = attributes[:colour]
    @node.gradientangle = attributes[:gradientangle]
  end

  def build(attributes)
    @graph = attributes[:graph]
    @name  = attributes[:name]
    shape = attributes[:shape] || 'record'
    style = attributes[:style] || 'filled'
    # Returns a GraphViz::Node
    @node = @graph.add_nodes(name, shape: shape, style: style)
  end

end