extends Node2D

# any scenes placed here will load when the game is run
var on_load = [
	preload("res://scenes/tiles.tscn"),
	preload("res://scenes/player.tscn"),
	preload("res://scenes/basic enemy.tscn")
]

func _ready() -> void:
	for scene in on_load:
		add_child(scene.instantiate())
