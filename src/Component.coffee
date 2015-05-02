
# Class Component
#
# A component contains some properties (with types if possible). The list of
# attributs should be static and always not null.
#
# The component class must be extended, the extended class must have the
# `initialize` method, which set the needed attributs.
#
module.exports = class Component


	# constructor :: ... -> Component
	#
	# Should not be extended.
	#
	constructor: () ->
		@attrs = {}
		@initialize.apply @, arguments if @initialize?



	# get :: String -> A
	#
	# Get the attribut register under `key`. All attributs should be
	# initialized.
	#
	get: (key) ->
		@attrs[key] ? null


	# set :: String, A -> null
	#
	# Set the attribut registered under `key`.
	#
	set: (key, val) ->
		@attrs[key] = val
		null


	# toJSON :: -> Hash
	#
	# Transform the component into JSON.
	#
	toJSON: ->
		ret = {}
		for k, v of @attrs
			ret[k] = if v? and v.toJSON? then v.toJSON() else v
		ret

