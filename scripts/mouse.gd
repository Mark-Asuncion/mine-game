extends Area2D

@onready var col = $CollisionShape2D
var mouse = true
var is_turn = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_global_mouse_position()
	pass

func _on_game_turn_change(player):
	is_turn = player
