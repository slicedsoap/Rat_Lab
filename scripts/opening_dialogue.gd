extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var resource = load("res://dialogue/opening_dialogue.dialogue")
	start_dialogue(resource)

func start_dialogue(dialogue):
	DialogueManager.show_dialogue_balloon(dialogue, "start")

func end_dialogue():
	get_tree().change_scene_to_file("res://scenes/opening_cutscene.tscn")
