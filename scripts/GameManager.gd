extends Node2D

@onready var table: Node2D = $table
@onready var bot: CanvasLayer = $bot_info
@onready var player: CanvasLayer = $player_info
@onready var player_cursor = $mouse
@onready var bot_cursor = $"mouse-bot"
@onready var game_end_dialog = $end_game
var is_player_turn = false
var move_count = 0
var grid_len = 5

func game_restart():
	get_tree().reload_current_scene()

func show_game_end_dialog(text: String):
	player_cursor.is_turn = false
	player_cursor.mouse = false
	bot_cursor.is_turn = false
	bot_cursor.mouse = false
	game_end_dialog.set_text(text)
	game_end_dialog.show()

func new_game() -> Array[Array]:
	var rng = RandomNumberGenerator.new()
	var play_grid: Array[Array]
	var max_bombs_prow = 1
	for i in grid_len:
		play_grid.push_back([])
		var cbombs = 0
		for j in grid_len:
			var i_bomb = rng.randi_range(0, grid_len-1)
			cbombs += int(i_bomb == j)
			play_grid[i].push_back(i_bomb == j)
			if j == grid_len-1:
				while cbombs < max_bombs_prow:
					i_bomb = rng.randi_range(0, grid_len-1)
					if not play_grid[i][i_bomb]:
						play_grid[i][i_bomb] = true
						cbombs+=1
	return play_grid

func _ready():
	var n_table = new_game()
	table.create_table(n_table)
	set_turn()

func _on_player_dead(player):
	var name = player.get_meta("name","")
	if name == "bot":
		show_game_end_dialog("Player wins")
	else:
		show_game_end_dialog("Bot wins")

func set_turn():
	is_player_turn = not is_player_turn
	print("turn?",is_player_turn)
	if is_player_turn:
		player_cursor.is_turn = true
		bot_cursor.is_turn = false
	else:
		player_cursor.is_turn = false
		bot_cursor.is_turn = true
		bot_cursor.choose_card(table)

func _on_table_reveal_card(is_bomb):
	if table.check_cards():
		table.reveal_all()
		show_game_end_dialog("Draw")
		return
	if is_bomb:
		if is_player_turn:
			player.dec_health()
		else:
			bot.dec_health()
	set_turn()

func _on_mousebot_mouse_left_click(index):
	table.reveal_card_on(index)

func _on_end_game_button_pressed():
	game_restart()
