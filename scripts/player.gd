extends CharacterBody2D

const MOVE_SPEED := 200
var animation_frame = 0
var animation_mode = 0
var next_frame_time = 0.0
const ANIMATION_RATE = 0.1

func _process(delta: float) -> void:
	process_inputs()

func process_inputs():
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		$Sprite2D.flip_h = false
		dir.y -= 1
		animation_mode = 1
	if Input.is_action_pressed("down"):
		$Sprite2D.flip_h = false
		dir.y += 1
		animation_mode = 0
	if Input.is_action_pressed("left"):
		$Sprite2D.flip_h = false
		dir.x -= 1
		animation_mode = 2
	if Input.is_action_pressed("right"):
		$Sprite2D.flip_h = true
		dir.x += 1
		animation_mode = 2
	
	dir = dir.normalized()
	if next_frame_time < Global.clock:
		next_frame_time += ANIMATION_RATE
		if dir != Vector2.ZERO:
			animation_frame+=1
			if animation_frame == 3:
				animation_frame = 0
		else:
			animation_frame = 0
			
	$Sprite2D.frame_coords.x = animation_frame
	$Sprite2D.frame_coords.y = animation_mode
	
	velocity = dir * MOVE_SPEED
	move_and_slide()
	position.x = round(position.x)
	position.y = round(position.y)
