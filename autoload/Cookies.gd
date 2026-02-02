extends Node2D

#amount of cookies
var cookies: int = 5000

#cookies_per_click
var cookies_per_click: int = 1

var machines = {
	"oven": {
		"name": "Oven",
		"count": 0,
		"interval": 2.0,
		"cookies": 1
	},
	"belt": {
		"name": "Belt",
		"count": 0,
		"interval": 5.0,
		"cookies": 5
	},
	"plant": {
		"name": "Plant",
		"count": 0,
		"interval": 10.0,
		"cookies": 20
	},
	"factory": {
		"name": "Factory",
		"count": 0,
		"interval": 30.0,
		"cookies": 100
	},
	"lab": {
		"name": "Lab",
		"count": 0,
		"interval": 1.0,
		"cookies": 500
	}
}

var current_scene = null
var path = null

#skill_one
var skill_one_value: int = 0
var skill_one_buy: int = 0

func _ready():
	_create_machine_timers()
	_create_endgame_timer()
	

func _create_machine_timers():
	for machine_name in machines.keys():
		var timer := Timer.new()
		timer.wait_time = machines[machine_name].interval
		timer.autostart = true
		timer.timeout.connect(_on_machine_timeout.bind(machine_name))
		add_child(timer)

func _on_machine_timeout(machine_name: String):
	var data = machines[machine_name]
	if data.count > 0:
		cookies += data.count * data.cookies



func _create_endgame_timer():
	var end_timer := Timer.new()
	end_timer.wait_time = 300.0 # 5 minut
	end_timer.autostart = true
	end_timer.timeout.connect(_on_endgame)
	add_child(end_timer)

func _on_endgame():
	print("EndGame")
	
	
#Funkcje w grze

#Pobierz nazwe maszyny
func get_machine_name(machine_name: String) -> String:
	return machines[machine_name].name

#Zworaca c/s 
func get_value_c_s_name(machine_name: String) -> int:
	return machines[machine_name].count * machines[machine_name].cookies

#Pobierz cene maszyny bazową
func get_machine_base_price(machine_name: String) -> int:
	return machines[machine_name].cookies * 10

#Pobierz cene maszyny aktualną do UI
func get_machine_price(machine_name: String) -> int:
	var data = machines[machine_name]
	return get_machine_base_price(machine_name) * (data.count + 1)

#Sprawdzamy czy można kupić maszyne
func can_buy_machine(machine_name: String) -> bool:
	return cookies >= get_machine_price(machine_name)

func buy_machine(machine_name: String):
	if not machines.has(machine_name):
		return

	var price = get_machine_price(machine_name)

	if cookies < price:
		#Nie da sie kupić
		return

	cookies -= price
	machines[machine_name].count += 1

	#Wszystko okej kupiło maszyne


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
