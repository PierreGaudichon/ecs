
# Class Engine
#
# The engine holds all the systems and entities in place and animate them. It
# uses the requestAnimationFrame to animate.
#
# The engine must be extended.
#
module.exports = class Engine

	# @now :: -> Integer
	#
	# Helper function which return the timestamp for now.
	#
	@now: -> (new Date).getTime()



	# @requestAnimationFrame :: (Integer -> null) -> null
	#
	# Helper function which wrap requestAnimationFrame.
	#
	# http://www.paulirish.com/2011/requestanimationframe-for-smart-animating/
	# http://js2.coffee/
	# + modifications
	#
	@requestAnimationFrame: if window? then do ->
		ret = null
		lastTime = 0
		vendors = ['webkit', 'moz']
		x = 0

		if window.requestAnimationFrame?
			ret = window.requestAnimationFrame

		while x < vendors.length and !ret?
			ret = window[vendors[x] + 'RequestAnimationFrame']
			++x

		if !ret?
			ret = (callback) ->
				currTime = (new Date).getTime()
				timeToCall = Math.max(0, 16 - (currTime - lastTime))
				id = window.setTimeout((->
					callback currTime + timeToCall
					return
				), timeToCall)
				lastTime = currTime + timeToCall
				id

		return ret.bind window



	# constructor :: ... -> Engine
	#
	# Should not be extended
	#
	constructor: (opt) ->
		@data = {}
		@playing = false
		@lastTime = 0
		@entities = []
		@systems = []

		@initialize.apply @, arguments if @initialize?



	# setSystems :: [System] -> null
	#
	# Set the systems of that engine. All the systems will be called in
	# order on each tick.
	#
	setSystems: (@systems) ->
		null


	# spawn :: Entity -> null
	#
	# Add an entity in the entity list.
	#
	spawn: (entity) ->
		@entities.push entity



	# despawn :: Entity -> null
	#
	# Remove the entity from the list.
	# (perf ?)
	#
	despawn: (entity) ->
		@entities.split @entities.indexOf(entity), 1
		null



	# tick :: Real -> null
	#
	# Make the system avance in time by `t` seconds. Call each system to make
	# him tick.
	#
	tick: (t) ->
		for s in @systems when s.tickBefore?
			s.tickBefore t

		for e in @entities
			for s in @systems when s.tickLoop?
				s.tickLoop t, e

		for s in @systems when s.tickAfter?
			s.tickAfter t

		null



	# anim :: Integer -> null
	# Private.
	#
	# Animate the engine by calling tick at regular interval (60 Hz). Computes
	# the time passed between each call.
	#
	anim: (t = Engine.now())->
		Engine.requestAnimationFrame (t) =>
			@anim t if @playing

		delta = (t - @lastTime) / 1000
		@lastTime = t
		@tick delta
		null



	# play :: -> null
	#
	# Start the animation.
	#
	play: ->
		unless @playing
			@lastTime = Engine.now()
			@playing = true
			@anim()
		null



	# pause :: -> null
	#
	# Pause the animation.
	#
	pause: ->
		@playing = false
		null



	# toJSON :: -> Hash
	#
	# Transform the component into JSON.
	#
	toJSON: ->
		r = {@data, systems: {}, entities: []}
		for n, s of @systems
			r.systems[n] = s.toJSON()
		r.entities = (e.toJSON() for e in @entities)
		return r
