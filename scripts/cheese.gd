extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var current_scene_file = get_tree().current_scene.get_child(0).scene_file_path #gets filepath of current scene
		var next_level_number = current_scene_file.to_int() + 2 #gets next level
		var next_level_path = "res://scenes/levels/level_" + str(next_level_number) + ".tscn"
		get_tree().call_deferred("change_scene_to_file", next_level_path)
		print(next_level_path)
		
