extends KinematicBody2D

const MOVE_SPEED = 500
const DASH_SPEED = 11
const JUMP_FORCE = 600  # Adjusted jump force for snappy jumps
const GRAVITY = 50
const MAX_FALL_SPEED = 1000
const COYOTE_TIME = 0.2

const MIN_JUMP_TIME = 0.001
const MAX_JUMP_TIME = 0.2
var jump_timer = 0
var is_jumping = false

onready var sprite = $Sprite

var y_velo = 0
var facing_right = false
var can_dash = true
var coyote_timer = 0

func _ready():
	add_to_group("player")

func _physics_process(delta):
	var grounded = is_on_floor()
	
	var move_dir = 0
	if Input.is_action_pressed("move_right"):
		move_dir += 1
	if Input.is_action_pressed("move_left"):
		move_dir -= 1
	if Input.is_action_pressed("dash") and can_dash and not grounded:
		if facing_right:
			move_dir += DASH_SPEED
		else:
			move_dir -= DASH_SPEED
		jump_timer = 0
		y_velo = 0
		can_dash = false
	move_and_slide(Vector2(move_dir * MOVE_SPEED, y_velo), Vector2(0, -1))
	
	if grounded:
		coyote_timer = COYOTE_TIME
		can_dash = true
		is_jumping = false
		jump_timer = 0
	else:
		coyote_timer -= delta
	
	if (facing_right and move_dir < 0) or (!facing_right and move_dir > 0):
		facing_right = !facing_right
	
	y_velo += GRAVITY
	
	if grounded or coyote_timer > 0:
		if Input.is_action_pressed("jump"):
			if !is_jumping:
				is_jumping = true
				jump_timer = 0
			jump_timer += delta
			if jump_timer <= MAX_JUMP_TIME:
				y_velo = -JUMP_FORCE
		else:
			is_jumping = false
			jump_timer = 0
	
	if grounded and y_velo >= 5:
		y_velo = 5
	if y_velo > MAX_FALL_SPEED:
		y_velo = MAX_FALL_SPEED


		

