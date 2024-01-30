extends Node2D

var card = preload("res://scene/card.tscn")
var pad = 20
var card_size = [0,0]

func create_table(table: Array[Array]):
	var prevx_pos = 0
	var prevy_pos = 0
	for i in table.size():
		prevx_pos = 0
		prevy_pos = i * (card_size[1] + pad - 5)
		for j in table[0].size():
			var ncard = card.instantiate() as Area2D
			ncard.get_child(1).is_bomb = table[i][j]
			ncard.position[0] += prevx_pos + pad
			prevx_pos = ncard.position[0] + card_size[0]
			ncard.position[1] += prevy_pos + pad
			add_child(ncard)
			ncard.intro()

func clear_table():
	for card in get_children():
		remove_child(card)
		card.queue_free()

func calc_size(rect_size: Vector2, scale: Vector2) -> Vector2:
	return Vector2(rect_size[0]*scale[0], rect_size[1]*scale[1])

func _ready():
	var ncard = card.instantiate() as Area2D
	var col = ncard.get_node("CollisionShape2D") as CollisionShape2D
	var col_sz = col.shape.get_rect().size
	var col_tf = col.transform.get_scale()
	card_size = calc_size(col_sz, col_tf)

func get_pos_card(index: int) -> Vector2:
	var card = get_children()[index] as Area2D
	var col = card.get_node("CollisionShape2D") as CollisionShape2D
	var size = calc_size(col.shape.get_rect().size, col.transform.get_scale()) / 2
	return position + card.position + size

func is_already_revealed(index: int) -> bool:
	#print(index, ' ', get_child_count())
	return get_child(index).card.disable

func reveal_card_on(index: int):
	print(index, get_child_count())
	var card = get_child(index) as Area2D
	card.card.reveal()

func check_cards() -> bool:
	var c_bombs = 0
	for i in get_child_count():
		var ccard: Node2D = get_child(i).card
		c_bombs += int(ccard.is_bomb)
	return c_bombs == 0

func reveal_all():
	for i in get_child_count():
		var ccard: Node2D = get_child(i).card
		ccard.reveal()
