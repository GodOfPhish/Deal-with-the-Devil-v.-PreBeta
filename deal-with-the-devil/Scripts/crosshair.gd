extends Node2D

# Rotation Speed
var rot_spd = 1

func _ready() -> void:
	# Set Global crosshair
	Global.crosshair = self

func _process(_float) -> void:
	# Check if the game is not paused
	if get_tree().paused == false:
		# If not, rotate
		rotation_degrees += rot_spd
	
	# Set global position
	global_position = get_global_mouse_position()
	
	# Hide actual mouse
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
