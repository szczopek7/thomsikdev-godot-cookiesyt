extends Node2D

#amount of cookies
var cookies: int = 0

#cookies_per_click
var cookies_per_click: int = 1

#timer konca gry
var end_timer:Timer

#koniec gry

var endgame = false
var endgame_cost: int = 128
var endgame_multiplier: float = 1.4

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
		"interval": 4.0,
		"cookies": 5
	},
	"plant": {
		"name": "Plant",
		"count": 0,
		"interval": 8.0,
		"cookies": 20
	},
	"factory": {
		"name": "Factory",
		"count": 0,
		"interval": 16.0,
		"cookies": 100
	},
	"lab": {
		"name": "Lab",
		"count": 0,
		"interval": 32.0,
		"cookies": 500
	}
}

var current_goal = {
	"machine": "",
	"required": 0,
	"cookies_required": 0
}

var extra_goal = {
	"active": false,
	"machine": "",
	"required": 0
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

# Co 60 sekund - gra sama odejmuje wymagane przedmioty
# np . ciastka
# lub maszyny
# Jeśli nie mamym to wtedy koniec gry TODO: Ekran konca gry

func _create_endgame_timer():
	end_timer = Timer.new()
	end_timer.wait_time = 30.0
	end_timer.autostart = true
	end_timer.timeout.connect(_on_endgame)
	add_child(end_timer)


func _on_endgame():
	
	if current_goal["machine"] == "":
		generate_goal()
		return

	var main_machine = current_goal["machine"]

	# zabezpieczenie jeśli klucz nie istnieje
	if not machines.has(main_machine):
		return
	
	var owned_main = machines[main_machine]["count"]

	var cookies_pass = cookies >= current_goal["cookies_required"]
	var main_pass = owned_main >= current_goal["required"]
	var extra_pass = true

	if extra_goal["active"]:
		if machines.has(extra_goal["machine"]):
			var owned_extra = machines[extra_goal["machine"]]["count"]
			extra_pass = owned_extra >= extra_goal["required"]

	if cookies_pass and main_pass and extra_pass:

		print("Lecimy Dalej")

		cookies -= current_goal["cookies_required"]
		
		#Timer dodaje dodatkowe sekundy
		end_timer.wait_time += 10.0
		print(end_timer.time_left)
		end_timer.start()

		endgame_cost = int(endgame_cost * endgame_multiplier)

		generate_goal()

	else:
		end_timer.stop()
		endgame = true
		get_tree().change_scene_to_file("res://end_game.tscn");

	# zwiększamy koszt na kolejny tick
	
	
#Funkcje w grze

#Pobierz nazwe maszyny
func get_machine_name(machine_name: String) -> String:
	return machines[machine_name].name

#Zworaca c/s 
func get_value_c_s_name(machine_name: String) -> int:
	var cs_overall = machines[machine_name].count * machines[machine_name].cookies
	cs_overall = cs_overall / machines[machine_name].interval
	
	return cs_overall

#Pobierz cene maszyny bazową
func get_machine_base_price(machine_name: String) -> int:
	return machines[machine_name].cookies * 10

#Pobierz aktualno ilosc posiadanych maszyn
func get_machine_owned_count(machine_name: String) -> int:
	return machines[machine_name].count

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

#generowanie celi w grze
func generate_goal():

	#sprawdzamy odblokowane maszyny
	var unlocked = []

	#sprawdzamy czy odblokowano maszyne, czyli po prostu kupiono ja
	for key in machines.keys():
		if machines[key]["count"] > 0:
			unlocked.append(key)
	#jesli nie ma maszyn to nic
	if unlocked.is_empty():
		current_goal["machine"] = ""
		return

	#Wybieramy losową maszyne do celu gry
	var random_machine = unlocked[randi() % unlocked.size()]
	var current_count = machines[random_machine]["count"]


	current_goal["machine"] = random_machine
	
	#Musimy mieć o 1 do 6 więcej aby przejść dalej
	current_goal["required"] = randi_range(current_count + 1, current_count + 4)
	current_goal["cookies_required"] = endgame_cost

	#print("Cel:", random_machine, current_goal["required"], " + cookies ", endgame_cost)

	#Bonusowe zadalnie 
	extra_goal["active"] = false

	if randi() % 2 == 0 and unlocked.size() > 1:

		var extra_machine = unlocked[randi() % unlocked.size()]

		if extra_machine != random_machine:

			var extra_count = machines[extra_machine]["count"]

			extra_goal["active"] = true
			extra_goal["machine"] = extra_machine
			extra_goal["required"] = randi_range(extra_count + 1, extra_count + 5)

			#print("extra cel:", extra_machine, extra_goal["required"])


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
