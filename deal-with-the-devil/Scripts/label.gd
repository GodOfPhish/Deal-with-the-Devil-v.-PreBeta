extends Label

func _process(_float) -> void:
	# Show the amount of souls the player has
	text = "Souls - " + str(Global.souls)
