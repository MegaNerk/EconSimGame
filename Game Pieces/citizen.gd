extends Node
class_name citizen
@export var name_label : Label
@export var value_bar : ProgressBar
@export var worth_label : Label
@export var job_label : Label
@export var default_job : job_data
@export var sat_bar : ProgressBar

var cur_name : String
var cur_value : float = 0.00
var cur_job : job_data:
	set(value):
		cur_job = value
		job_label.text = cur_job.name

var satisfaction : float = 1.0:
	set(value):
		satisfaction = value
		sat_bar.value = satisfaction

var job_duration_months : int = 0

func _ready():
	pass

func get_value():
	return cur_value

func update_bar():
	value_bar.max_value = ECONOMY.get_highest_value()
	value_bar.value = cur_value
	var new_text : String = "%0.2f" %cur_value
	worth_label.text = "$" + new_text

func setup():
	cur_name = NAMES.gen_name()
	name_label.text = cur_name
	call_deferred("resize_text", name_label)
	cur_job = default_job

func take_turn():
	job_duration_months += 1
	var changed_jobs = false
	
	var last_satisfaction = satisfaction
	
	var satisfaction_change : float = 0.0
	if ECONOMY.cost_of_living > cur_value:
		satisfaction_change -= randf_range(0.1,0.4)
	if ECONOMY.cost_of_living > cur_job.salary:
		satisfaction_change -= randf_range(0.01,0.1)
	if cur_job.salary > ECONOMY.cost_of_living:
		satisfaction_change += randf_range(0.01,0.2)

	satisfaction = clamp(satisfaction+satisfaction_change,0.0, 1.0)
	
	var dissatisfaction = 1.0 - (satisfaction * cur_job.satisfaction)
	if job_duration_months > 1 and satisfaction <= last_satisfaction and randf() < dissatisfaction:
		changed_jobs = true
		pursue_new_job()
	
	if !changed_jobs:
		cur_value += cur_job.salary
	
	cur_value = max(0, cur_value-ECONOMY.cost_of_living)
	call_deferred("update_bar")

func resize_text(this_label : Label):
	var min_size = 16
	var font = this_label.get_theme_font("font")
	var font_size = this_label.get_theme_font_size("font_size") + 8
	while font_size > min_size:
		var text_size = font.get_string_size(this_label.text, HORIZONTAL_ALIGNMENT_CENTER, -1, font_size)
		if text_size.x < this_label.size.x and text_size.y < this_label.size.y:
			break
		font_size -= 1
	this_label.add_theme_font_size_override("font_size", font_size)

#region Gameplay functionality
func pursue_new_job():
	cur_job = ECONOMY.get_random_job()
	job_duration_months = 0
	#Test comment
#endregion Gameplay functionality
