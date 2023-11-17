extends Node2D

#amount of cookies
var cookies: int = 0

#cookies_per_click
var cookies_per_click: int = 1

var machine_cookies: int = 0
var machine_cookies_prince: int = 5

var time_cookies: float = 0
var time_seconds: int = 0

var current_scene = null
var path = null

#skill_one
var skill_one_value: int = 0
var skill_one_buy: int = 0

func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)

func _deferred_goto_scene(path):
	# It is now safe to remove the current scene
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
