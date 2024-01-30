extends CanvasLayer

@export var hcontainer: HBoxContainer

func _ready():
	if get_meta("ltr",false):
		hcontainer.layout_direction = Control.LAYOUT_DIRECTION_LTR
	if get_meta("anchorb", false):
		(get_child(0) as Control).anchors_preset = Control.LayoutPreset.PRESET_BOTTOM_WIDE
		get_child(0).get_child(0).anchors_preset = Control.LayoutPreset.PRESET_BOTTOM_WIDE
	pass
