extends TileMapLayer

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (is_collision_enabled()):
		pass
	if body.is_in_group("Player"):
		collision_enabled = true
