class_name WoodenTree
extends StaticBody2D

@export var durability : int = 0

func chop():
	if durability >= 0:
		queue_free()
