extends Node

var all_jobs : Array[job_data] = []
var all_citizens : Array[citizen]

var cost_of_living : float = 1000.00

func _ready():
	load_job_data_from_path("res://Jobs/Specific Jobs")

func load_job_data_from_path(path : String):
	var this_dir := DirAccess.open(path)
	assert(this_dir != null)
	
	this_dir.list_dir_begin()
	while true:
		var file = this_dir.get_next()
		if file == "":
			break
		if file.ends_with(".tres") or file.ends_with(".res"):
			var next_job = load(path + "/" + file)
			if next_job is job_data:
				all_jobs.append(next_job)
	
	this_dir.list_dir_end()

func get_highest_value():
	var cur_highest = 0
	for citizen in all_citizens:
		if citizen.get_value() > cur_highest:
			cur_highest = citizen.get_value()
	return cur_highest

func get_random_job() -> job_data:
	return all_jobs.pick_random()

func add_citizen(new_cit : citizen):
	all_citizens.append(new_cit)

func take_turn():
	var col_increase = randf_range(1.001, 1.003)
	cost_of_living *= col_increase
