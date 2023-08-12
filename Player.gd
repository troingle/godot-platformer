
extends KinematicBody2D

const MOVE_SPEED = 420
const JUMP_FORCE = 850
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const COYOTE_TIME = 0.2

onready var sprite = $Sprite

var y_velo = 0
var facing_right = false
var coyote_timer = 0

func _physics_process(delta):
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	var grounded = is_on_floor()

	if grounded:
		coyote_timer = COYOTE_TIME
	else:
		coyote_timer -= delta
	
	y_velo += GRAVITY

	if (grounded or coyote_timer > 0) and Input.is_action_pressed("jump"):
		y_velo = -JUMP_FORCE
		coyote_timer = 0

	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED

