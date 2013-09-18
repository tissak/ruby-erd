class ERDBuilder
   def entities(type, *names)
    action = (type == :styled) ? :add_styled_entity : :add_entity
    entities = {}
    names.each do |name|
      entities[name.downcase.gsub(' ', '_').to_sym] = self.send(action, name)
    end
    entities
  end

  def relationsihp(entity, rel, other_entity, name='joins')
    relationship = directed_relationship(rel)
    self.associate(entity, other_entity, {association: relationship, name: name})
  end

  def directed_relationship(rel)
    case rel
    when :has_one
      :one_to_one
    when :has_many
      :one_to_many
    end
  end
end