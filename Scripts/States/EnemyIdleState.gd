extends State 
class_name EnemyIdleState

@export var enemy : Enemy

func _ready() -> void:
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	return null
	
func PhysicsProcess ( _delta : float) -> State:
	enemy.velocity = Vector2.ZERO
	return null

func HandleInput(_event : InputEvent) -> State:
	return null
