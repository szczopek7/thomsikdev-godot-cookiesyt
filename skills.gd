extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$CookiesValue.text = str(Cookies.cookies)

func _on_button_pressed():
	Cookies.goto_scene("res://game.tscn") # Replace with function body.

func _on_skill_1_button_pressed():
	if(Cookies.cookies >= 25 && Cookies.skill_one_buy != 1):
		Cookies.cookies = Cookies.cookies - 25
		Cookies.skill_one_value = 4
		Cookies.skill_one_buy = 1
		$Skill_1/Skill_1_Button.text = str("Kupiono")
		$Skill_1/Skill_1_Button.disabled
