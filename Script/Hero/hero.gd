class_name Hero
extends CharacterBody2D

@onready var tile_map : TileMap = $"../TileMap"
@onready var sprite_2d = $Sprite2D
@onready var ray_cast_2d = $RayCast2D
@onready var chop_sound = $ChopSound
@onready var torch_light = %TorchLight

@export var torch_durability : int = 3

var is_moving = false

func _ready():
	_up_date_torch_durability()

func decrease_torch_durability():
	if torch_durability > 0:
		torch_durability -= 1
		_up_date_torch_durability()
		if torch_durability == 0:
			game_over()
	elif torch_durability <= 0:
		game_over()

func set_torch_durability(value : int):
	torch_durability = value
	_up_date_torch_durability()

func game_over():
	await get_tree().create_timer(2).timeout 
	get_tree().reload_current_scene()

func _physics_process(delta):
	if not is_moving:
		return
	
	if global_position == sprite_2d.global_position:
		is_moving = false
		return
	
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 2)

func _process(delta):
	if torch_durability <= 0:
		return
	
	if is_moving:
		return
	
	if Input.is_action_just_pressed("Up"):
		move(Vector2.UP)
	elif Input.is_action_just_pressed("Down"):
		move(Vector2.DOWN)
	elif Input.is_action_just_pressed("Left"):
		move(Vector2.LEFT)
	elif Input.is_action_just_pressed("Right"):
		move(Vector2.RIGHT)

func move(direction: Vector2):
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)
	
	var tile_data: TileData = tile_map.get_cell_tile_data(0, target_tile)
	
	if tile_data.get_custom_data("walkable") == false:
		return
	
	ray_cast_2d.target_position = direction * 16
	ray_cast_2d.force_raycast_update()
	
	var collid_area = ray_cast_2d.get_collider()
	
	if collid_area is Area2D:
		return
	elif collid_area is WoodenTree:
		collid_area.chop()
		chop_sound.play(0.0)
		return
	
	is_moving = true
	
	global_position = tile_map.map_to_local(target_tile)
	
	sprite_2d.global_position = tile_map.map_to_local(current_tile)

func _up_date_torch_durability():
	torch_light.texture_scale = torch_durability
