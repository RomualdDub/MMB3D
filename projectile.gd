extends CharacterBody3D

func _ready():
	velocity.x = 60
	
func _physics_process(delta):
	move_and_slide()
