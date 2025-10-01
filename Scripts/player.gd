extends CharacterBody2D

class_name Player
@onready var player: Sprite2D = $player
@onready var canon: Sprite2D = $TankBarrel

@export_range(10, 1500.0) var speed: float = 250
@export_range(1, 25) var ammo_count: int = 1
@export var attack_range: int = 25

@export var rotation_durration : float = 0.3
@onready var tracks: GPUParticles2D = $TracksParticles

var speed_multiplier : int = 10
var last_move_direction : Vector2

var mouse_postion : Vector2
var target_position : Vector2
var target_obj : CollisionObject2D = null
var is_moving : bool = false
var direction : Vector2

func _ready() -> void:
	#last_move_direction = Vector2.RIGHT
	target_position = global_position
	

func _process(delta: float) -> void:
	#add tracks particles
	if velocity != Vector2.ZERO:
		direction = (target_position - global_position)
		tracks.rotation = direction.angle()
		tracks.emitting = true
	else:
		tracks.emitting = false
		
	if target_obj != null:
		target_position = target_obj.global_position
		#target_obj._targeted()
		#print_debug(target_obj)
	#var direction = Vector2.ZERO
	
	#mouse_postion = CalcCannonAngle()
	
	#if is_moving:
		#direction = (target_position - global_position)
		#tracks.emitting = true
		#tracks.rotation = direction.angle()
		#if direction.length() > 2.0: #stop moving 2 pixels from an object so it doesnt jitter
			#velocity = direction.normalized() * speed
		#else:
			#tracks.emitting = false
			#is_moving = false
			#velocity = Vector2.ZERO
	#if direction.length() > 0:
		#last_move_direction = direction.normalized()
	
	
	#canon.rotation = mouse_postion.angle()
	#$player.rotation = last_move_direction.angle()
	pass
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT and event.pressed:
		target_position = get_global_mouse_position()
		is_moving = true
		var mouse_dir = CalcCannonAngle()
		var tween := create_tween()
		tween.tween_property($player, "rotation", mouse_dir.angle(), rotation_durration)
	
	pass

func CalcCannonAngle() -> Vector2:
	var direction : Vector2
	var mouse_pos : Vector2 = get_global_mouse_position()
	direction = mouse_pos - global_position
	return direction
