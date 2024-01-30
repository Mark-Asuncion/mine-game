extends CanvasLayer

signal dead(player: CanvasLayer)
var health = 3
var res_health_none = preload("res://img/hb-none.png")
@onready var hb_container = $Control/MarginContainer/hcontainer/healthbarcontainer

func update_bar():
	var trect = (hb_container.get_children()[health] as TextureRect)
	trect.texture = res_health_none

func dec_health():
	health-=1
	update_bar()
	if health == 0:
		dead.emit(self)
