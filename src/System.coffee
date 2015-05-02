# Class System
#
# A system as an internal state and is animated by the engine.
#
# The system class must be extended with the functions :
#
# - tickBefore, at each tick of the engine, this function is called.
# - tickLoop, at each tick, this functon is called for each entity in the
#   engine.
# - tickAfter, at each tick, after the loop.
#
# Thoses functions have the time passed since the last tick, in second.
# `timeLoop` also take an entity as the second argument.
#
module.exports = class System



	# constructor :: Engine, ... -> System
	#
	# Should not be extended.
	#
	constructor: (@engine, opt...) ->
		@data = {}
		@initialize.apply @, opt if @initialize?



	# toJSON :: -> Hash
	#
	# Transform the component into JSON.
	#
	toJSON: ->
		@data

