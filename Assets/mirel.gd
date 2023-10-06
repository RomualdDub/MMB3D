extends CharacterBody3D

var speed = 10
var jump_speed = 20
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta * 10
		$AnimationTree.set("parameters/jumping/transition_request", "true")
		
	else:
		$AnimationTree.set("parameters/jumping/transition_request", "false")

	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	
	if (direction != 0):
		$AnimationTree.set("parameters/moving/transition_request", "walk")
	else:
		$AnimationTree.set("parameters/moving/transition_request", "idle")
	
	if velocity.x < 0:															# going left
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(0, -45, 0), 0.1) # rotate left

	elif velocity.x > 0:														# goign right
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(0, 45, 0), 0.1) # rotate right

	else:																		# not moving
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(0, 0, 0), 0.1) # rotate front

	if Input.is_action_just_pressed("move_jump") and is_on_floor():				# jumping
		velocity.y = jump_speed

	move_and_slide()
