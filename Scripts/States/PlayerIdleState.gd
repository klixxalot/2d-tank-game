extends State 
class_name PlayerIdleState

@export var player : Player

func _ready() -> void:
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	return null
	
func PhysicsProcess ( _delta : float) -> State:
	player.velocity = Vector2.ZERO
	return null

func HandleInput(_event : InputEvent) -> State:
	return null
