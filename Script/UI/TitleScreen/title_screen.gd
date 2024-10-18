extends Node2D

var packed_scene = load("res://Scene/game.tscn")

func _input(event):
	if event is InputEventKey or event is InputEventMouseButton:
		get_tree().change_scene_to_packed(packed_scene)
