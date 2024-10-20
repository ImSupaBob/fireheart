extends Area2D

@export var load_scene : PackedScene

@onready var point_light_2d = $PointLight2D
@export var light_range : int = 2

func _ready():
	point_light_2d.texture_scale = light_range

func _on_body_entered(body : Node2D):
	await get_tree().create_timer(2).timeout 
	if body is Hero:
		get_tree().change_scene_to_packed(load_scene)
