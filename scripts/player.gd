extends CharacterBody2D

const MOVE_SPEED := 200
var animation_frame := 0
var animation_mode := 0
var next_frame_time := 0.0
const ANIMATION_RATE := 0.1

const ATTACK_DURATION := 0.5
var attack_end_time := 0.0
var is_attacking = false

@onready var main_body = $Main_Body

func _ready() -> void:
	Global.player = self

func _process(delta: float) -> void:
	process_inputs()

func process_inputs():
	movement_inputs()
	special_inputs()

func special_inputs():
	# main attack logic
	is_attacking = attack_end_time > Global.clock
	$Swordlike_Collider/CollisionPolygon2D.disabled = not is_attacking
	$Swordlike_Collider/CollisionPolygon2D.visible = is_attacking # for debug collider view

	if Input.is_action_just_pressed("main attack") and not is_attacking:
		attack_end_time = Global.clock + ATTACK_DURATION
	

func movement_inputs():
	if is_attacking:
		return
	
	var dir = Vector2.ZERO
	
	# direction determination based on inputs
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("right"):
		dir.x += 1
	if Input.is_action_pressed("up"):
		dir.y -= 1
	if Input.is_action_pressed("down"):
		dir.y += 1

	# make sure we don't move 1.41x faster when moving diagonally
	dir = dir.normalized()
	
	if dir != Vector2.ZERO:
		# rotate such that the attack hitbox faces forwards
		rotation = dir.angle() - PI/2
	
	movement_animation(dir)
	
	velocity = dir * MOVE_SPEED
	move_and_slide()
	position.x = round(position.x)
	position.y = round(position.y)

func movement_animation(dir):
	if dir == Vector2.ZERO:
		animation_frame = 0
		return

	if dir.x < 0:
		main_body.flip_h = false
		animation_mode = 2
	elif dir.x > 0:
		main_body.flip_h = true
		animation_mode = 2
	if dir.y < 0:
		main_body.flip_h = false
		animation_mode = 1
	elif dir.y > 0:
		main_body.flip_h = false
		animation_mode = 0
	
	# some animation logic
	if next_frame_time < Global.clock:
		next_frame_time += ANIMATION_RATE
		animation_frame+=1
		if animation_frame == main_body.hframes:
			animation_frame = 0
	
	main_body.frame_coords.x = animation_frame
	main_body.frame_coords.y = animation_mode
	
	main_body.global_rotation = 0
