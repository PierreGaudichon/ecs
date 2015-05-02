class Engine
	@now: -> Integer
	@requestAnimationFrame: (Function) -> null

	data: Hash
	playing: Boolean
	lastTime: Integer
	entities: [Entity]
	systems: [System]
	constructor: () -> Engine
	setSystem: ([System]) -> null
	spawn: (Entity) -> null
	despawn: (Entity) -> null
	tick: (Real) -> null
	anim: (Integer) -> null
	play: -> null
	pause: -> null
	toJSON: -> Hash

	initialize: () -> null



class System
	engine: Engine
	data: Hash
	constructor: (Engine, ...) -> System
	toJSON: -> Hash

	initialize: () -> null
	tickBefore: (Integer) -> null
	tickloop: (Integer, Entity) -> null
	tickAfter: (Integer) -> null



class Entity
	@id: Integer

	id: Integer
	components: {Component}
	constructor: () -> Entity
	as: (String) -> Boolean
	asAll: ([String]) -> Boolean
	attach: (Component) -> null
	detach: (Component) -> null
	get: (String, String) -> A
	set: (String, String, A) -> null
	toJSON: -> Hash

	initialize: () -> null


class Component
	attrs: Hash
	constructor: () -> Component
	get: (String) -> A
	set: (String, A) -> null
	toJSON: -> Hash

	initialize: () -> null
