extends CharacterBody2D

#signal jump
const SPEED = 280.0
const JUMP_VELOCITY = -470.0
var push_force = 60.0
var screen_size
var current_level = 1
var push_instructions_already_given = false
var jump_instructions_given = false
var state_fallen = false
var resource = load("res://dialogue/scientist_dialogue.dialogue")

@export var shrunk = false

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	
	if get_tree().current_scene.scene_file_path == "res://scenes/opening_cutscene.tscn":
		if state_fallen == false:
			
			$AnimatedSprite2D.animation = "falling"
			state_fallen = true
		return
	
	if position.x > 900 && !jump_instructions_given:
		jump_instructions_given = true
		trigger_jump_instructions()
	
	if Input.is_action_just_pressed("jump"):
		$AnimatedSprite2D.animation = "jumping_test"
		#await get_tree().create_timer(1.0).timeout
	elif velocity != Vector2.ZERO:
		if is_on_floor():
			$AnimatedSprite2D.animation = "walking"
			$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity == Vector2.ZERO and is_on_floor():
		$AnimatedSprite2D.animation = "idle"
	

func trigger_jump_instructions():
	DialogueManager.show_dialogue_balloon(resource, "jump")

	
func trigger_push_instructions():
	if push_instructions_already_given:
		return
	else:
		push_instructions_already_given = true
		DialogueManager.show_dialogue_balloon(resource, "push")

func _physics_process(delta: float) -> void:
	#print("rat: " + str(position))
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#check if in a level in which rat can be controlled
	if get_tree().current_scene.scene_file_path != ("res://scenes/levels/level_" + str(current_level) + ".tscn"):
		#$AnimatedSprite2D.animation = "idle"
		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
		return
	if Input.is_action_just_pressed("shrink"):
		pass#shrink()

	# Handle walk.
	rat_walk(delta)
	# Handle jump.
	rat_jump(delta)
	# Handle push.
	rat_push()

	move_and_slide()


func rat_jump(delta):
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if shrunk:
			velocity.y = JUMP_VELOCITY / 1.5
		else:
			velocity.y = JUMP_VELOCITY
	

func rat_walk(delta):
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func rat_push():
	for i in get_slide_collision_count(): #number of times it collided
		var c = get_slide_collision(i) #get the collision
		#var normal = c.get_normal() #gets vector normal to collision
		if c.get_collider() is RigidBody2D: #if the collision was with a rigid body
			trigger_push_instructions()
			if Input.is_action_pressed("push"):
				if Input.is_action_pressed("jump"):
					c.get_collider().apply_impulse(Vector2(0, -1) * push_force)
				c.get_collider().apply_impulse(-c.get_normal() * push_force)

func _on_slide_body_entered(body: Node2D) -> void:
	#play rat sliding animation
	hide()
	position = Vector2(138, 202)
	show()
	
func shrink() -> void:
	if shrunk:
		$AnimatedSprite2D.set_scale(Vector2(0.077, 0.077))
		$CollisionShape2D.set_scale(Vector2(1, 1))
		shrunk = false
	else:
		$AnimatedSprite2D.set_scale(Vector2(0.0385, 0.0385))
		$CollisionShape2D.set_scale(Vector2(0.5, 0.5))
		push_force /= 2
		shrunk = true

func _on_button_toggled(toggled_on: bool) -> void:
	get_tree().reload_current_scene()
	
