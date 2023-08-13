extends Node2D

func _on_Checkpoint_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("Player"):
		print("Success")

