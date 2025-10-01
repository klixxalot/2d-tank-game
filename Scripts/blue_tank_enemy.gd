extends CharacterBody2D

class_name Enemy

@export var target : CharacterBody2D
@export var speed : float = 50
@export var health : float = 100.0
@onready var target_box: ColorRect = $TargetBox

var targeted : bool = false

signal enemy_destroyed(body: CharacterBody2D)

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	#print (get_instance_id())
	pass
	
func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity, true)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Missile"):
			print ("Collided With: ", collider.missile_damage)
			if collider.missile_damage > 0:
				health = health - collider.missile_damage
				collider._destroy()
				if health <= 0:
					_enemy_destroyed()
		#if collider is CharacterBody2D:
			#print("Collided with CharacterBody2D: ", collider.name)

func _set_targeted (targeted : bool) -> void:
	target_box.visible = targeted

func _enemy_destroyed() -> void:
	emit_signal("enemy_destroyed", self)
	queue_free()

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#print ("I have been entered")
	#if body.is_in_group("Missile"):
		#if body.missile_damage != 0:
			#health = health - body.missile_damage
			#body.queue_free()
			#if health <= 0:
				#_enemy_destroyed()
	#pass # Replace with function body.
