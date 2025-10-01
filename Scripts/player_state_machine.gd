extends Node2D

class_name PlayerStateMachine
@export var character: Player
@export var initial_state : State

var states : Dictionary = {}

var _current_state : State
var _target_cell : Vector2i
var _speed : float = 30 #

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transition)
	if initial_state:
		initial_state.Enter()
		_current_state = initial_state

func _process(delta: float) -> void:
	if _current_state:
		_current_state.Process(delta)
		
	#print(str(_current_state))

func _physics_process(delta: float) -> void:
	if _current_state:
		_current_state.PhysicsProcess(delta)

func on_child_transition(state, new_state_name, target):
	if state != _current_state:
		return
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
	
	if _current_state:
		_current_state.Exit()
		
	new_state.Enter()
	_current_state = new_state
	
	if target != null:
		character.target_obj = target
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		var mouse_pos = get_global_mouse_position() #use global mouse position instead of local, 3 hrs to debug this

		#var mouse_pos = get_viewport().get_mouse_position()
		var clicked : bool = false

		var paremeters := PhysicsPointQueryParameters2D.new()

		paremeters.position = mouse_pos
		paremeters.collision_mask = 0xFFFFFFFF # all for testing
		paremeters.collide_with_areas = true
		paremeters.collide_with_bodies = true
		#print (mouse_pos)
		#print_debug(get_world_2d().direct_space_state.intersect_point(paremeters, 32))
		for obj in get_world_2d().direct_space_state.intersect_point(paremeters, 32):
			var collider = obj["collider"]
			if collider.is_in_group("Enemy"):
				print (str(collider))
				_current_state.Transitioned.emit(_current_state, "playerattackstate", collider)
				collider._set_targeted(true)
				clicked = true
				break
		if clicked == false:  #If you click on the map and its not an enemy
			if character.target_obj != null:
				character.target_obj._set_targeted(false) #deselect the enemy
			character.target_obj = null
			_current_state.Transitioned.emit(_current_state, "playermovingstate", null)
