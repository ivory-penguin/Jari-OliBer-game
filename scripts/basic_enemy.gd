extends Area2D

var health := 50
var speed := 65
var velocity := Vector2.ZERO

func _ready():
	global_position.x += randi_range(-300, 300)
	global_position.y += randi_range(-300, 300)

func _process(delta: float) -> void:
	if health == 0:
		get_tree().root.add_child(preload("res://scenes/basic enemy.tscn").instantiate())
		get_tree().root.add_child(preload("res://scenes/basic enemy.tscn").instantiate())
		queue_free()
	
	velocity = global_position.direction_to(Global.player.global_position) * speed
	position += velocity * delta
	rotation += deg_to_rad(speed) * delta


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player Attacks"):
		health -= Global.player.attack_damage
