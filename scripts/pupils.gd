extends CharacterBody2D

var root_node
var rat_node
var initial_rat_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	root_node = get_parent().get_parent().get_parent()
	rat_node = root_node.get_children()[1]
	initial_rat_position = rat_node.position
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#get how much rat has moved since last frame
	var rat_movement = rat_node.position - initial_rat_position
	
	#1152 x 648
	#pixels to move: 117 on x axis
	var width = get_viewport_rect().size.x
	var scaling = width / 117
	var pupil_movement = rat_movement.x * scaling
	position.x += pupil_movement * delta
	#print(rat_node.position)
	
