extends Area2D

func _on_body_entered(body):
	if body is Hero:
		body.decrease_torch_durability()
