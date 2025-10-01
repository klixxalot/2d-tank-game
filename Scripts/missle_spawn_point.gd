extends Node2D

class_name MissleSpawnPoint

@export var missile : PackedScene

#set the range, effective range and reload - range is the distance the missle will travel, 
#effective range is the distance the missle is fired at

enum TYPES {MISSILE, BULLET}

@export_range(1.0, 500) var range: float = 1.0
@export_range(1.0, 500) var effective_range: float = 1.0
@export_range(10.0, 200.00) var missile_damage: float = 100.0
@export var reload: float = 15.0
@export var speed: float = 5.0
@export var player: Player
# types determine flight characteristics
@export var type: TYPES


var missile_cooldown: float

#create a signal for the spawned missles to attach noises etc
signal missile_spawned(body: RigidBody2D)
signal bullet_spawned(body: RigidBody2D)

func _ready() -> void:
	var missile_cooldown : float = reload
	if missile == null:
		push_error("Missile $s has no PackedScene assigned" % name)
		return
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if missile_cooldown > 0.0:
		missile_cooldown -= delta
	if player.target_obj != null and missile_cooldown <= 0.0:
		print ("Enemy Detected")
		print ("launch missles")
		_spawn_missile(player.target_obj)
		missile_cooldown = reload

func _spawn_missile(target : CollisionObject2D) -> void:
	var missiles = missile.instantiate()
	missiles.global_transform = global_transform
	missiles.set("target", target)
	missiles.set("speed", speed)
	missiles.set("missile_damage", missile_damage)
	missiles.set("range", range)
	match type:
		TYPES.MISSILE:
			emit_signal("missile_spawned", missiles)
		TYPES.BULLET:
			emit_signal("bullet_spawned", missiles)
	get_tree().current_scene.add_child(missiles)
	
	
