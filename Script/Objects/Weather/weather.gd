extends Node2D

@onready var audio_stream_player_2d : AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_audio_stream_player_2d_finished():
	audio_stream_player_2d.play(0.0)
