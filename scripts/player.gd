extends CharacterBody2D

const MOVE_SPEED := 200

func _process(delta: float) -> void:
	process_inputs(delta)

func process_inputs(delta):
	var dir = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		dir.y -= 1
	if Input.is_action_pressed("down"):
		dir.y += 1
	if Input.is_action_pressed("left"):
		dir.x -= 1
	if Input.is_action_pressed("right"):
		dir.x += 1
	
	dir = dir.normalized()
	velocity = dir * MOVE_SPEED
	move_and_slide()
