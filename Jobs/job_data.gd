extends Resource
class_name job_data

enum INDUSTRIES {
	AGRICULTURE,
	FINANCE,
	RETAIL,
	SERVICE,
	TECH,
	UNEMPLOYMENT
}

@export var name : String
@export var salary : float #2 decimal float for monthly pay
@export_range(0.0, 1.0, 0.01) var satisfaction : float #0-1 exclusive percentage score for job satisfaction
@export_range(0.0, 1.0, 0.01) var competitiveness : float #0-1 exclusive percentage score for job competitiveness
@export var level : int
@export var promotion : Array[job_data] #The potential next jobs in this career ladder
@export var industry : INDUSTRIES
