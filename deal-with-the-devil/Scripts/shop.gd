extends Control

# Shop time and timer
var shoptime = 3600
var shoptimer = 0

func _ready() -> void:
	# Hide and set shop timer to shop time
	shoptimer = shoptime
	visible = false

func _process(_float) -> void:
	# Count down shop timer
	shoptimer -= 1 * Global.dtime
	# Check if shoptimer is less than or equal to 0
	if shoptimer <= 0:
		# If so then show the shop and pause the game
		visible = true
		get_tree().paused = true
		shoptimer = shoptime
