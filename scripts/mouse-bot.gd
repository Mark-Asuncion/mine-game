extends Area2D

signal mouse_left_click(index: int)
@onready var col = $CollisionShape2D
var mouse = true
var is_turn = false
var move = false
var target: Vector2 = Vector2()
var target_id = -1
var timer = null
@onready var rng = RandomNumberGenerator.new()

func choose_card(table: Node2D):
	print("choosing target")
	var size = table.get_child_count()-1
	if size == -1:
		return
	target_id = rng.randi_range(0, size)
	while table.is_already_revealed(target_id):
		target_id = rng.randi_range(0, size)
	target = table.get_pos_card(target_id)
	move = true

func emit_click():
	mouse_left_click.emit(target_id)
	move = false
	target = Vector2()
	target_id = -1
	timer = null

func _process(delta):
	print("move?", move)
	if move:
		var dist = target - position
		#print(dist)
		if absi(dist.x) == 0 and absi(dist.y) == 0:
			if timer == null:
				timer = get_tree().create_timer(.4)
				timer.timeout.connect(emit_click)
		else:
			#print(clamp(dist[0], -5, 5), clamp(dist[1], -5, 5))
			position.x += clamp(dist[0], -5, 5)
			position.y += clamp(dist[1], -5, 5)
