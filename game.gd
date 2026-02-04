extends Control

@onready var cookies_value: Label = $VBoxContainer/GameCore/PanelContainer/CookiesValue

@onready var device_1: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_1/Device_1
@onready var cookies_machine_price_1: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_1/CookiesMachinePrice_1
@onready var cookies_machine_value_1: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_1/CookiesMachineValue_1
@onready var button_1: Button = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_1/Button_1

@onready var device_2: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_2/Device_2
@onready var cookies_machine_price_2: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_2/CookiesMachinePrice_2
@onready var cookies_machine_value_2: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_2/CookiesMachineValue_2
@onready var button_2: Button = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_2/Button_2

@onready var device_3: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_3/Device_3
@onready var cookies_machine_price_3: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_3/CookiesMachinePrice_3
@onready var cookies_machine_value_3: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_3/CookiesMachineValue_3
@onready var button_3: Button = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_3/Button_3

@onready var device_4: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_4/Device_4
@onready var cookies_machine_price_4: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_4/CookiesMachinePrice_4
@onready var cookies_machine_value_4: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_4/CookiesMachineValue_4
@onready var button_4: Button = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_4/Button_4

@onready var device_5: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_5/Device_5
@onready var cookies_machine_price_5: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_5/CookiesMachinePrice_5
@onready var cookies_machine_value_5: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_5/CookiesMachineValue_5
@onready var button_5: Button = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_5/Button_5

@onready var up_bar_2: Control = $VBoxContainer/UpBar/UpBar2

@onready var owned_count_1: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_1/Owned_Count_1
@onready var owned_count_2: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_2/Owned_Count_2
@onready var owned_count_3: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_3/Owned_Count_3
@onready var owned_count_4: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_4/Owned_Count_4
@onready var owned_count_5: Label = $VBoxContainer/GameCore/PanelContainer2/Machine/Device_5/Owned_Count_5

func _init() -> void:
	if(Cookies.endgame == true):
		Cookies.cookies = 0
		Cookies.cookies_per_click = 1
		Cookies.endgame_cost = 128
		Cookies.machines["oven"]["count"] = 0
		Cookies.machines["belt"]["count"] = 0
		Cookies.machines["plant"]["count"] = 0
		Cookies.machines["factory"]["count"] = 0
		Cookies.machines["lab"]["count"] = 0
		
		#cel
		Cookies.current_goal["machine"] = ""
		Cookies.current_goal["required"] = 0
		Cookies.current_goal["cookies_required"] = 0
		#extra cel
		Cookies.extra_goal["active"]
		Cookies.extra_goal["machine"]
		Cookies.extra_goal["required"]
		
		#skill
		Cookies.skill_one_value = 0
		Cookies.skill_one_buy = 0
		
		if Cookies.end_timer:
			Cookies.end_timer.wait_time = 30.0
			Cookies.end_timer.start()
			
		Cookies.endgame = false



# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	Cookies.current_scene = root.get_child(root.get_child_count() - 1)
	cookies_value.text = str(Cookies.cookies)

	device_1.text = Cookies.get_machine_name("oven")
	cookies_machine_price_1.text = str(Cookies.get_machine_price("oven"))
	cookies_machine_value_1.text = str(Cookies.get_value_c_s_name("oven"))
	owned_count_1.text = str(Cookies.get_machine_owned_count("oven"))
	
	device_2.text = Cookies.get_machine_name("belt")
	cookies_machine_price_2.text = str(Cookies.get_machine_price("belt"))
	cookies_machine_value_2.text = str(Cookies.get_value_c_s_name("belt"))
	owned_count_2.text = str(Cookies.get_machine_owned_count("belt"))
	
	device_3.text = Cookies.get_machine_name("plant")
	cookies_machine_price_3.text = str(Cookies.get_machine_price("plant"))
	cookies_machine_value_3.text = str(Cookies.get_value_c_s_name("plant"))
	owned_count_3.text = str(Cookies.get_machine_owned_count("plant"))
	
	device_4.text = Cookies.get_machine_name("factory")
	cookies_machine_price_4.text = str(Cookies.get_machine_price("factory"))
	cookies_machine_value_4.text = str(Cookies.get_value_c_s_name("factory"))
	owned_count_4.text = str(Cookies.get_machine_owned_count("factory"))
	
	device_5.text = Cookies.get_machine_name("lab")
	cookies_machine_price_5.text = str(Cookies.get_machine_price("lab"))
	cookies_machine_value_5.text = str(Cookies.get_value_c_s_name("lab"))
	owned_count_5.text = str(Cookies.get_machine_owned_count("lab"))
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	cookies_value.text = str(Cookies.cookies)

	device_1.text = Cookies.get_machine_name("oven")
	cookies_machine_price_1.text = str(Cookies.get_machine_price("oven"))
	cookies_machine_value_1.text = str(Cookies.get_value_c_s_name("oven"))
	owned_count_1.text = str(Cookies.get_machine_owned_count("oven"))
	
	device_2.text = Cookies.get_machine_name("belt")
	cookies_machine_price_2.text = str(Cookies.get_machine_price("belt"))
	cookies_machine_value_2.text = str(Cookies.get_value_c_s_name("belt"))
	owned_count_2.text = str(Cookies.get_machine_owned_count("belt"))
	
	device_3.text = Cookies.get_machine_name("plant")
	cookies_machine_price_3.text = str(Cookies.get_machine_price("plant"))
	cookies_machine_value_3.text = str(Cookies.get_value_c_s_name("plant"))
	owned_count_3.text = str(Cookies.get_machine_owned_count("plant"))
	
	device_4.text = Cookies.get_machine_name("factory")
	cookies_machine_price_4.text = str(Cookies.get_machine_price("factory"))
	cookies_machine_value_4.text = str(Cookies.get_value_c_s_name("factory"))
	owned_count_4.text = str(Cookies.get_machine_owned_count("factory"))
	
	device_5.text = Cookies.get_machine_name("lab")
	cookies_machine_price_5.text = str(Cookies.get_machine_price("lab"))
	cookies_machine_value_5.text = str(Cookies.get_value_c_s_name("lab"))
	owned_count_5.text = str(Cookies.get_machine_owned_count("lab"))

func _on_add_cookies_pressed():
	Cookies.cookies = Cookies.cookies + Cookies.cookies_per_click + Cookies.skill_one_value

	
func _on_button_buy_skills_pressed():
	Cookies.goto_scene("res://scene/skills.tscn")


func _on_button_1_pressed() -> void:
	if(Cookies.can_buy_machine("oven")):
		Cookies.buy_machine("oven")

func _on_button_2_pressed() -> void:
	if(Cookies.can_buy_machine("belt")):
		Cookies.buy_machine("belt")

func _on_button_3_pressed() -> void:
	if(Cookies.can_buy_machine("plant")):
		Cookies.buy_machine("plant")

func _on_button_4_pressed() -> void:
	if(Cookies.can_buy_machine("factory")):
		Cookies.buy_machine("factory")

func _on_button_5_pressed() -> void:
	if(Cookies.can_buy_machine("lab")):
		Cookies.buy_machine("lab")
