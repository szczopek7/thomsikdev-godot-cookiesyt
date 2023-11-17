extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	Cookies.current_scene = root.get_child(root.get_child_count() - 1)
	$GUI/CookiesMachinePrince.text = str(Cookies.machine_cookies_prince)
	$GUI/CookiesMachineValue.text = str(Cookies.machine_cookies)
	$GUI/CookiesValue.text = str(Cookies.cookies)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Cookies.time_cookies += delta
	Cookies.time_seconds = fmod(Cookies.time_cookies,60)
	if Cookies.time_seconds >= 5:
		machine_cookies_action()
		Cookies.time_cookies = 0.0
	
	
func machine_cookies_action():
	Cookies.cookies = Cookies.cookies + (Cookies.machine_cookies * 2)
	$GUI/CookiesValue.text = str(Cookies.cookies)

func add_cookies(new_cookies_amount: int):
	Cookies.cookies = new_cookies_amount
	$GUI/CookiesValue.text = str(Cookies.cookies)
	
func buy_machine_cookies():
	if(Cookies.cookies >= Cookies.machine_cookies_prince):
		Cookies.cookies = Cookies.cookies - Cookies.machine_cookies_prince
		Cookies.machine_cookies = Cookies.machine_cookies + 1
		Cookies.machine_cookies_prince = Cookies.machine_cookies_prince + 10
		$GUI/CookiesMachinePrince.text = str(Cookies.machine_cookies_prince)
		$GUI/CookiesMachineValue.text = str(Cookies.machine_cookies)
		$GUI/CookiesValue.text = str(Cookies.cookies)

func _on_add_cookies_pressed():
	add_cookies(Cookies.cookies + Cookies.cookies_per_click + Cookies.skill_one_value)


func _on_button_pressed():
	buy_machine_cookies()
	
func _on_button_buy_skills_pressed():
	Cookies.goto_scene("res://skills.tscn")
