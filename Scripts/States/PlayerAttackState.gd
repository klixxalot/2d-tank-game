extends State 
class_name PlayerAttackState

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
	var in_range : bool = false
	direction = (player.target_position - player.global_position)
	if direction.length() > player.attack_range: #stop moving 2 pixels from an object so it doesnt jitter
		#print(str(direction.length()) + " - " + str(player.attack_range))
		in_range = false
		player.velocity = direction.normalized() * player.speed
	else:
		in_range = true
		player.velocity = Vector2.ZERO
	
	#attack the target as long as it's in range
	if player.target_obj != null and in_range == true:
		attack_target(player.target_obj)
	
	#if ther is no longer a target, idle
	if player.target_obj == null:
		Transitioned.emit(self, "PlayerIdleState", null)
		
	return null

func HandleInput(_event : InputEvent) -> State:
	return null

func attack_target(target : CollisionObject2D) -> void:
	#print("attacking: " + str(target))
	pass
