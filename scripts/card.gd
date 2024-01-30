extends Area2D

@onready var card: Node2D = $card
@onready var collision: CollisionShape2D = $CollisionShape2D
var clickable = false

func intro():
	card.intro()

func _input(event: InputEvent):
	if not get_tree().root.get_child(0).is_player_turn:
		return
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT
			and clickable):
			card.reveal()

func _on_area_entered(area):
	if ("mouse" in area and area.mouse) and ("is_turn" in area and area.is_turn):
		card.select()
		clickable = true

func _on_area_exited(area):
	if ("mouse" in area and area.mouse) and ("is_turn" in area and area.is_turn):
		card.select(true)
		clickable = false

func remove():
	get_parent().remove_child(self)
	queue_free()
