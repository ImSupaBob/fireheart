extends Node2D

var packed_scene = load("res://Scene/UI/TitleScreen/title_screen.tscn")

func _input(event):
	if event.is_released():
		get_tree().change_scene_to_packed(packed_scene)
