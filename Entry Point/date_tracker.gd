extends Label
class_name date_tracker

enum MONTHS {Jan, Feb, Mar, Apr, May, Jun, Jul, Aug,Sep, Oct, Nov, Dec}
@export var start_year : int = 2025

var cur_year : int = start_year
var cur_month : MONTHS = MONTHS.Jan

func tick_up_month():
	if cur_month == MONTHS.Dec:
		cur_year += 1
		cur_month = MONTHS.Jan
	else:
		cur_month += 1
	update_text()

func update_text():
	text = str(MONTHS.keys()[cur_month]) + ", " + str(cur_year)
