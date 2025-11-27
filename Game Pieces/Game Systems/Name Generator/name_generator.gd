extends Node

var first_names = FileAccess.open("res://Game Pieces/Game Systems/Name Generator/first_names.txt", FileAccess.READ).get_as_text().split("\n")
var last_names = FileAccess.open("res://Game Pieces/Game Systems/Name Generator/last_names.txt", FileAccess.READ).get_as_text().split("\n")

func gen_name() -> String:
	var random_index : int = randi() % first_names.size()
	var first = first_names[random_index]
	random_index = randi() % last_names.size()
	var last = last_names[random_index]
	
	if len(first) > 1:
		first = first[0].to_upper() + first.substr(1).to_lower()
	if len(last) > 1:
		last = last[0].to_upper() + last.substr(1).to_lower()
	
	name = first + " " + last
	return name
