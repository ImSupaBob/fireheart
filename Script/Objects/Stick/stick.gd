extends Area2D


func _on_body_entered(body):
	if body is Hero:
		body.set_torch_durability(3)
		queue_free()
