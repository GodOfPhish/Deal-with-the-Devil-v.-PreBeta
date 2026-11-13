extends Area2D

# Time before crux gets despawned
var live_time = 300

# Moving and rotating variables
var rot_spd : float = 10
var speed : float = 2.5
var dir = null

# Damage
var damage = 50

func _ready() -> void:
	# Set original position (don't spawn in the player)
	global_position.x += 8 * dir.x 
	global_position.y += 8 * dir.y

func _process(_float) -> void:
	# Countdown to despawn
	live_time -= 1 * Global.dtime
	# Check if ready to despawn
	if live_time <= 0:
		# If ready, despawn
		queue_free()
	
	# Rotate
	rotation_degrees += rot_spd
	
	# Decide movement based on direction
	if dir:
		position.x += speed * dir.x * Global.dtime
		position.y += speed * dir.y * Global.dtime

func _on_area_entered(area: Area2D) -> void:
	print("hi")
	# Check if colliding with an enemy
	if area.get_collision_layer_value(5) or area.get_collision_layer_value(6):
		# If so, deal damage and then despawn
		area.get_parent().health -= damage
		queue_free()
