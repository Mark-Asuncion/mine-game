extends CanvasLayer

signal button_pressed
@onready var label = $Control/Label

func set_text(text: String):
	label.text = text

func _on_button_pressed():
	button_pressed.emit()
