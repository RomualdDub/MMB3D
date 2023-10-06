extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_input(true)  # Enable input processing

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()  # Close the game

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
