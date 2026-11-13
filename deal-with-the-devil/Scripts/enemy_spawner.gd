extends Node2D

# Enemy preloads
var base_enemy = preload("res://Scenes/enemy_base.tscn")

# Spawn time & timer
var spawntime : int = 300
var spawntimer : int = 30

# Wave number (decides amount of enemies spawned)
var wavenum : int = 1

func _process(_float) -> void:
	# Count down spawn timer
	spawntimer -= 1 * Global.dtime
	# Check if spawn timer is less than or equal to 0
	if spawntimer <= 0:
		# If so, then spawn enemies equal to the wave number
		for n in wavenum:
			var new_enemy = base_enemy.instantiate()
			var axis_change = ["x", "y"].pick_random()
			if axis_change == "x":
				new_enemy.global_position.x = clamp(Global.player.global_position.x + randf_range(-266, 266), -290, 290)
				new_enemy.global_position.y = clamp(Global.player.global_position.y + [-144, 144].pick_random(), -190, 190)
			else:
				new_enemy.global_position.x = clamp(Global.player.global_position.x + [-256, 256].pick_random(), -290, 290)
				new_enemy.global_position.y = clamp(Global.player.global_position.y + randf_range(-154, 154), -190, 190)
			add_child(new_enemy)
		# Reset spawn timer and add one to the wave number
		spawntimer = spawntime
		wavenum += 1
