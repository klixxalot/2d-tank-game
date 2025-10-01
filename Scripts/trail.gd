extends Line2D
@onready var player: Player = $".."

var queue : Array
@export var max_length : int = 5

func _process(delta: float) -> void:
	var pos = player.global_position
	
	queue.push_front(pos)
	
	if queue.size() > max_length:
		queue.pop_back()
	
	clear_points()
	
	for point in queue:
		add_point(point)
