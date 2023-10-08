extends CharacterBody3D

var speed = 60
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	velocity.x = -speed * Global.direction
	
func _physics_process(delta):
	velocity.y -= gravity * delta
	move_and_slide()
