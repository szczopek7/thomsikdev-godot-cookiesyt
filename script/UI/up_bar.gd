extends Control

@onready var timer: Label = $HBoxContainer/VBoxContainer/Timer
@onready var time_to_end_progress: ProgressBar = $HBoxContainer/VBoxContainer/Time_To_End_Progress

@onready var cookies_pass: Label = $HBoxContainer/VBoxContainer2/Cookies_Pass
@onready var machine_pass: Label = $HBoxContainer/VBoxContainer2/Machine_Pass
@onready var extra_pass: Label = $HBoxContainer/VBoxContainer2/Extra_Pass


func _physics_process(delta):

	_update_timer_ui()
	_update_goal_ui()

func _update_timer_ui():

	if Cookies.end_timer == null:
		return

	time_to_end_progress.max_value = Cookies.end_timer.wait_time
	time_to_end_progress.value = Cookies.end_timer.time_left

	timer.text = "Time: " + str(int(Cookies.end_timer.time_left))

func _update_goal_ui():

	if Cookies.current_goal["machine"] == "":
		machine_pass.text = "Brak celu"
		cookies_pass.text = ""
		extra_pass.text = ""
		return

	var machine_key = Cookies.current_goal["machine"]
	var machine_name = Cookies.get_machine_name(machine_key)

	var owned = Cookies.machines[machine_key]["count"]
	var required = Cookies.current_goal["required"]

	cookies_pass.text = "Cookies: " + str(Cookies.current_goal["cookies_required"])

	machine_pass.text = machine_name + ": " + str(owned) + " / " + str(required)

	if Cookies.extra_goal["active"]:
		var extra_key = Cookies.extra_goal["machine"]
		var extra_name = Cookies.get_machine_name(extra_key)
		var extra_owned = Cookies.machines[extra_key]["count"]
		var extra_required = Cookies.extra_goal["required"]

		extra_pass.text = extra_name + ": " + str(extra_owned) + " / " + str(extra_required)
	else:
		extra_pass.text = ""
