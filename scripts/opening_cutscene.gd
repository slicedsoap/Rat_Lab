extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#AudioStreamPlayer.play_music_level()
	pass

func start_dialogue(dialogue):
	DialogueManager.show_dialogue_balloon(dialogue, "start")
	
func switch_level():
	get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")

func _on_timer_timeout() -> void:
	var resource = load("res://dialogue/scientist_dialogue.dialogue")
	start_dialogue(resource)
	
	
