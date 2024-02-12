extends Node2D

signal reveal_card(is_bomb: bool)
@onready var bomb = $bomb
@onready var anim_flip: AnimatedSprite2D = $card_flip
@onready var anim_intro: AnimatedSprite2D = $card_intro
@onready var select_indicator: AnimatedSprite2D = $select
@onready var fire_emitter: GPUParticles2D = $fire
@onready var sfx_flip: AudioStreamPlayer2D = $flip
@onready var sfx_explode: AudioStreamPlayer2D = $explode
var disable = false
var is_bomb = false

func intro():
	disable = true
	anim_intro.show()
	anim_intro.play()
	sfx_flip.play()

func reveal():
	if disable:
		return
	anim_flip.play()
	sfx_flip.play()
	disable = true
	reveal_card.emit(is_bomb)
	select_indicator.hide()

func select(reverse: bool = false):
	if disable:
		return
	if not reverse:
		select_indicator.play()
	else:
		select_indicator.play_backwards()

func _ready():
	bomb.hide()
	anim_flip.hide()
	var tl_node = get_tree().root.get_child(0) as Node2D
	reveal_card.connect(tl_node._on_table_reveal_card, Object.CONNECT_ONE_SHOT)

func _on_animation_finished():
	if is_bomb:
		bomb.show()
		sfx_explode.play()
		fire_emitter.emitting = true
		await get_tree().create_timer(2).timeout
		get_parent().remove()

func _on_card_intro_animation_finished():
	disable = false
	anim_flip.show()
	anim_intro.hide()
