extends Node2D

@onready var hero_2 = $Hero2
@onready var hero_4 = $Hero4
@onready var animation_player = $AnimationPlayer

var is_anim_end = false

func _ready():
	await get_tree().create_timer(8).timeout 
	var pos = hero_2.global_position 
	hero_2.queue_free()
	hero_4.position = pos
	animation_player.play("new_animation")
	

func _on_animation_player_animation_finished(anim_name):
	await get_tree().create_timer(10).timeout
	get_tree().quit()
