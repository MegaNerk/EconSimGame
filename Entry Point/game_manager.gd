extends Node

@export var citizen_scene : PackedScene
@export var citizen_board : GridContainer
@export var date : date_tracker
@export var col : Label

func _ready():
	add_citizen()
	add_citizen()
	add_citizen()
	add_citizen()
	add_citizen()
	add_citizen()
	add_citizen()
	add_citizen()
	add_citizen()

func add_citizen():
	var new_cit = citizen_scene.instantiate()
	citizen_board.add_child(new_cit)
	ECONOMY.add_citizen(new_cit)
	new_cit.setup()

func move_next_month():
	for cit in ECONOMY.all_citizens:
		cit.take_turn()
	date.tick_up_month()
	ECONOMY.take_turn()
	var new_col = ECONOMY.cost_of_living
	col.text = "Cost of living: $" + "%0.2f" %new_col

func move_next_year():
	for i in range(12):
		move_next_month()
