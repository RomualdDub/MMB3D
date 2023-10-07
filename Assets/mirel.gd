extends CharacterBody3D

var speed = 10
var jump_speed = 20
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var projectile: PackedScene 

func _ready():
	$AnimationTree.active = true

func _physics_process(delta):
	# jumping
	if not is_on_floor():
		velocity.y -= gravity * delta * 10
		$AnimationTree.set("parameters/jumping/transition_request", "true")
	else:
		$AnimationTree.set("parameters/jumping/transition_request", "false")

	if Input.is_action_just_pressed("move_jump") and is_on_floor():
		velocity.y = jump_speed														# jump !

	# direction
	var direction = Input.get_axis("move_left", "move_right")
	velocity.x = direction * speed
	
	# walking
	if !Input.is_action_pressed("attack_left") and !Input.is_action_pressed("attack_right"):
		if velocity.x < 0:															# going left
			var tween = create_tween()
			tween.tween_property(self, "rotation_degrees", Vector3(0, -45, 0), 0.1) # rotate left
			$AnimationTree.set("parameters/moving/transition_request", "walk")

		elif velocity.x > 0:														# goign right
			var tween = create_tween()
			tween.tween_property(self, "rotation_degrees", Vector3(0, 45, 0), 0.1) # rotate right
			$AnimationTree.set("parameters/moving/transition_request", "walk")

		else:
			var tween = create_tween()												#looking front
			tween.tween_property(self, "rotation_degrees", Vector3(0, 0, 0), 0.1) 	# rotate front
			$AnimationTree.set("parameters/moving/transition_request", "idle")

	# attacking
	if Input.is_action_pressed("attack_left") and !Input.is_action_pressed("attack_right"):
		velocity.x = 0 
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(0, -45, 0), 0.1) # rotate left
		$AnimationTree.set("parameters/moving/transition_request", "attack")	# attack left 
		
	elif Input.is_action_pressed("attack_right") and !Input.is_action_pressed("attack_left"):
		velocity.x = 0 
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(0, 45, 0), 0.1) # rotate left
		$AnimationTree.set("parameters/moving/transition_request", "attack")	# attack right

	elif Input.is_action_pressed("attack_left") and Input.is_action_pressed("attack_right"):
		velocity.x = 0
		var tween = create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(0, 0, 0), 0.1) 	# rotate front
		$AnimationTree.set("parameters/moving/transition_request", "idle")

	move_and_slide()

func attack():
	var bullet = projectile.instantiate()
	owner.add_child(bullet)
	
