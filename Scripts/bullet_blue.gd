extends RigidBody2D

var target: CharacterBody2D 
var speed:float
var missile_damage:float
var range:float

var starting_position:Vector2
@onready var explosion: AnimationPlayer = $Explosion
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	starting_position = global_position
	
	if target == null:
		#print(str(target.global_position))
		push_error("Missle has no target")

func _physics_process(delta: float) -> void:
	var selfposition : Vector2 = self.global_position
	#print_debug(starting_position.distance_to(selfposition))
	if starting_position.distance_to(selfposition) > range:
		_destroy()
		print(str(starting_position.distance_squared_to(selfposition)))
	if target != null:
		var direction = (target.global_position - selfposition).normalized()
		if selfposition.distance_to(target.global_position) > .01:
			#Move the missile towards the tartet
			self.global_position += direction * speed * delta
			#Rotate the missile to orient to the target
			look_at(target.global_position)
			
func _destroy() -> void:
	collision_shape_2d.disabled = true
	explosion.play("Explosion")
	#queue_free()
