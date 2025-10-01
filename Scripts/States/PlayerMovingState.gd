extends State 
class_name PlayerMovingState

@export var player : Player
@export var speed: float = 5.0

var direction : Vector2


func _ready() -> void:
	pass
	
func Enter() -> void:
	pass
	
func Exit() -> void:
	pass
	
func Process( _delta : float ) -> State:
	return null
	
func PhysicsProcess ( _delta : float) -> State:
	direction = (player.target_position - player.global_position)
	if direction.length() > 2.0: #stop moving 2 pixels from an object so it doesnt jitter
		player.velocity = direction.normalized() * player.speed
	else:
		Transitioned.emit(self, "PlayerIdleState", null)
	return null

func HandleInput(_event : InputEvent) -> State:
	return null
