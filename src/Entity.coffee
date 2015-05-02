# Class Entity
#
# An entity contains some components that can be added and removed at any time.
# In the description, a component "name" is the name of the class of the
# component, starting with an uppercase.
#
# The entity class must be extended.
#
module.exports = class Entity



	# @id :: Integer
	#
	@id: 0



	# constructor :: ... -> Entity
	#
	# Should not be extended.
	#
	constructor: () ->
		@id = Entity.id++
		@components = {}
		@initialize.apply @, arguments if @initialize?



	# as :: String -> Boolean
	#
	# Tell if the entity as the given component. The string is the name
	# of the class.
	#
	as: (k) ->
		@components[k]?



	# asAll :: [String] -> Boolean
	#
	# Tell if tne entity as all the given components.
	#
	asAll: (ks) ->
		ks.every (k) => @as k



	# attach :: Component -> null
	#
	# Attach the givent component in the entity. The component must already be
	# instanciated.
	#
	attach: (c) ->
		@components[c.constructor.name] = c
		null



	# detach :: String -> null
	#
	# Detach the component of the entity by it's name.
	#
	detach: (name) ->
		@components[name] = null



	# get :: String, String -> A
	#
	# Retrieve the attributs from the component. The component must be present
	# in the entity before getting it's attribut. (see `Entity#as`)
	#
	get: (component, attr) ->
		try
			@components[component].get attr
		catch
			s = "#{@constructor.name}[#{component}][#{attr}]"
			throw new Error "Entity#get : #{s} is undefined."
			null



	# set :: String, String, A -> null
	#
	# Set the attribut in the component. The component must be present in the
	# entity.
	#
	set: (component, attr, value) ->
		try
			@components[component].set attr, value
		catch
			s = "#{@constructor.name}[#{component}][#{attr}]"
			throw new Error "Entity#set : #{s} is undefined."
		null



	# toJSON :: -> Hash
	#
	# Transform the component into JSON.
	#
	toJSON: ->
		ret = {}
		for n, c of @components
			ret[n] = c.toJSON()
		ret

