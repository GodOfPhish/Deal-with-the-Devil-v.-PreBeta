extends CharacterBody2D

# Speed
var spd : float = 75

# Health & Damage
var health : float = 100
var damage : float = 5

func _physics_process(_float) -> void:
	# Check if health is equal to or below 0
	if health <= 0:
		# If so, give the player a soul and despawn
		Global.souls += 1
		queue_free()
	
	# Set direction to move the player
	var direction := global_position.direction_to(Global.player.global_position)
	
	# Move 
	if direction:
		velocity = direction * spd
	else:
		velocity = Vector2(0, 0)

	move_and_slide()
