extends KinematicBody2D

# Declare member variables here.
const TURN_SPEED = 180
const MOVE_SPEED = 150
const ACC = 0.05
const DEC = 0.05

var motion = Vector2(0, 0)

var fSpeed : float
var iOrientation : int
var iGear : int

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Rotation code, temporary shit, use mouse later
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= TURN_SPEED * delta
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += TURN_SPEED * delta
	
	
	
	var movedir = Vector2(1, 0).rotated(rotation)

	# Apply acceleration
	if iGear != 0:
		motion = motion.linear_interpolate(movedir, ACC)
		position += motion * (MOVE_SPEED * iGear) * delta
	else:
		motion = motion.linear_interpolate(movedir, 0)
		position += motion * MOVE_SPEED * delta
		
	# Apply friction
	motion = motion.linear_interpolate(Vector2(0,0), DEC)
	position += motion * MOVE_SPEED * delta

	return

# Gear shift
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_W and iGear < 5:
			iGear += 1
		if event.scancode == KEY_S and iGear > 0:
			iGear -= 1
	return