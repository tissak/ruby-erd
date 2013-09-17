class ERDBuilder
	 def entities(type, *names)
    action = (type == :styled) ? :add_styled_entity : :add_entity
    entities = {}
    names.each do |name|
      entities[name.downcase.gsub(' ', '_').to_sym] = self.send(action, name)
    end
    entities
  end

	def assoc(entity, rel, other_entity, name='joins')
		relationship = assoc_rel(rel)
		self.associate(entity, other_entity, {association: relationship, name: name})
	end

	def assoc_rel(rel)
		case rel
		when :has_one
			:one_to_one
		when :has_many
			:one_to_many
		end
	end
end