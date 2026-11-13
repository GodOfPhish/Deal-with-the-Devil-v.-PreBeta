extends CharacterBody2D

# Sub-Nodes
@onready var collision : CollisionShape2D = $Collision

# Player speed
var spd : float = 100

# Dashing variables
var dashing : bool = false
var dashlength : float = 75
var dashtime : float = 20
var dashtimer : float = 0
var dashspd : float
var dashdir : Vector2
var dashcooldowntime : float = 3
var dashcooldowntimer : float = 0

# Crux setup
var crux = preload("res://Scenes/crux.tscn")
var crux_reload_times : Array = [15, 30]
var crux_reload_timer : float = 0

func _ready() -> void:
	# Set global player
	Global.player = self

func _physics_process(_float) -> void:
	# Check if crux timer is positive, if so count it down
	if crux_reload_timer > 0:
		crux_reload_timer -= 1 * Global.dtime
	# Check if able to fire and player intends to fire
	if Input.is_action_pressed("left_click") and crux_reload_timer <= 0:
		# If so, fire
		var cruxspawn = crux.instantiate()
		cruxspawn.global_position = global_position
		cruxspawn.dir = global_position.direction_to(Global.crosshair.global_position)
		add_sibling(cruxspawn)
		# Set crux reload to correct reload type (depends if it's the main weapon)
		crux_reload_timer = crux_reload_times[0]
	
	# Find direction
	var direction := Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
	
	# Check if able to dash and player intends to dash
	if Input.is_action_just_pressed("dash") and dashcooldowntimer <= 0 and direction:
		dashspd = dashlength / (dashtime / 60.0)
		dashdir = direction
		dashtimer = dashtime
		dashing = true
	
	# If player intends to move, move
	if dashing:
		collision.disabled = true
		velocity.x = dashdir.x * dashspd * Global.dtime
		velocity.y = dashdir.y * dashspd * Global.dtime
		dashtimer -= 1
		if dashtimer <= 0:
			dashing = false
			dashcooldowntimer = dashcooldowntime
	else:
		collision.disabled = true
		if dashcooldowntimer > 0:
			dashcooldowntimer -= 1
		if direction:
			velocity.x = direction.x * spd * Global.dtime
			velocity.y = direction.y * spd * Global.dtime
		else:
			# Else don't move
			velocity.x = 0
			velocity.y = 0

	move_and_slide()
