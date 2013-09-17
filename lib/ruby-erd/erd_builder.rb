class ERDBuilder

  attr_accessor :default_node_background_color
  attr_reader :name

  def add_entity(name)
    ERDEntity.new.tap do |entity|
      entity.build(graph: graph, name: name)
      entity.background_color = node_background_color
    end
  end

  def add_styled_entity(name)
    ERDEntity.new.tap do |entity|
      entity.build(graph: graph, name: name, style: 'rounded,filled')
      entity.gradient = {colour: '/blues5/1:/blues5/3', gradientangle: 270 }
    end
  end

  def associate(entity, other_entity, attributes)
    case other_entity
    when Array
      diagram.add_edges(entity.node, other_entity.collect(&:node), edge_attributes_for(attributes))
    else
      diagram.add_edges(entity.node, other_entity.node, edge_attributes_for(attributes))
    end
  end

  def begin_system(name)
    @name = name

    # Initialize these objects
    graph
  end

  # Public: Returns the current diagram, or a new instance if there is none.
  #
  # For a list of available attributes, see:
  #   * https://github.com/glejeune/Ruby-Graphviz/blob/master/lib/graphviz/constants.rb
  #   * http://www.graphviz.org/content/attrs
  #
  # Ruby-Graphviz overrides []= on GraphViz objects so to set an attribute, treat
  # the GraphViz object like a hash.
  #
  # Example: diagram[attribute] = value
  #
  # Returns a GraphViz instance
  def diagram
    @diagram ||= GraphViz.digraph(name) do |diagram|
      # Prevent node overlap
      # http://www.graphviz.org/content/attrs#doverlap
      diagram[:overlap] = 'false'

      # Draw straight lines between nodes
      # http://www.graphviz.org/content/attrs#dsplines
      diagram[:splines] = 'true'

      # Contents of the diagram's label
      # http://www.graphviz.org/content/attrs#dlabel
      diagram[:label] = name

      # Label location: Display the title at the top 't' of the diagram
      # http://www.graphviz.org/content/attrs#dlabelloc
      diagram[:labelloc] = "t"
    end
  end

  def export_as_png
    diagram.output(png: "#{name}.png")
  end

  def graph
    @graph ||= diagram.add_graph(name).tap do |graph|
      graph[:overlap] = 'false'
      graph[:splines] = 'true'
    end
  end

  def join(entity, other_entity, label="joins")
    join_table = add_entity("#{entity.name}#{other_entity.name}")
    join_table.background_color = '#5182FF'

    associate(entity, join_table, {association: :one_to_many, name: label})
    associate(join_table, other_entity, {association: :many_to_one, name: ""})
  end

private

  def edge_attributes_for(attributes)
    case attributes[:association]
    when :one_to_one
      arrowhead = 'odot'
      arrowtail = 'odot'
    when :one_to_many
      arrowhead = 'crow'
      arrowtail = 'odot'
    when :many_to_one
      arrowhead = 'odot'
      arrowtail = 'crow'
    when :many_to_many
      arrowhead = 'crow'
      arrowtail = 'crow'
    else
      arrowhead = 'odot'
      arrowtail = 'odot'
    end

    label = attributes[:name] || "Label"

    {
      arrowhead: arrowhead,
      arrowtail: arrowtail,
      dir: 'both',
      label: label
    }
  end

  def node_background_color
    default_node_background_color || '#51CEFF'
  end

end