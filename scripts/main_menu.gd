extends CanvasLayer

var game = preload("res://scene/game.tscn")

func _on_new_game_pressed():
	get_tree().change_scene_to_file("res://scene/game.tscn")

func _on_exit_pressed():
	get_tree().quit()
