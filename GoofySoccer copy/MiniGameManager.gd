extends Node2D
class_name MiniGameManager

signal show_winner(winner)
signal game_started(player_data)
signal game_ended()
signal update_score(player, score)
signal winner_declared(winner)



var score1 = 0
var score2 = 0

const DUMMY_SAVE_DATA: Dictionary = {
	"players": [
		{
			"color": "#a83232",
			"points": 0,
		},
		{
			"color": "#63a832",
			"points": 0,
		},
		{
			"color": "#327ba8",
			"points": 2,
		},
		{
			"color": "#7932a8",
			"points": 0,
		},
	],
	"games": [
		{
			"name": "Test Game",
			"results": [
				{
					"player": 0,
					"points": 1
				},
				{
					"player": 1,
					"points": 3
				},
			]
		},
		{
			"name": "Other Game",
			"results": [
				{
					"player": 2,
					"points": 1
				},
			]
		},
	]
}


## The path of the save file.
var save_file_path: String = ""
## The data of the save file
var save_file_data: Dictionary = {}
var applied_results: bool = false

## Our minigame's name
@export var game_name: String = "Goofy Soccer"
@export var min_player_count: int = 2
@export var max_player_count: int = 2

class PlayerData:
	var number: int
	var index: int
	var color: Color
	var points: int

	func _init(_index: int, _color: Color, _points: int):
		index = _index;
		number = _index + 1
		color = _color
		points = _points

class PlayerResultData:
	## Player's number
	var player: int
	## The points a player has earned/lost
	var points: int
	
	func _init(_player: int, _points: int):
		player = _player
		points = _points
	
	func to_dict() -> Dictionary:
		return {
			"player": player - 1,
			"points": points
		}


func goal_scored_by_player1():
	score1 += 1
	emit_signal("update_score", "Player 1", score1)
	check_for_winner()

func goal_scored_by_player2():
	score2 += 1
	emit_signal("update_score", "Player 2", score2)
	check_for_winner()
func check_for_winner():
	if score1 >= 3:
		emit_signal("show_winner", "Player 1")
		reset_scores()
	elif score2 >= 3:
		emit_signal("show_winner", "Player 2")
		reset_scores()
func reset_scores():
	score1 = 0
	score2 = 0

func end_game(results = null):
	game_ended.emit()

	if save_file_path != "":
		var file = FileAccess.open(save_file_path, FileAccess.WRITE)
		if file:
			file.store_string(JSON.stringify(save_file_data, "  "))
			file.close()
		else:
			printerr("Could not write to save file.")
	else:
		push_warning("No file saved because we're using dummy data...")
		print("Ending game with save_file_data:\n%s" % JSON.stringify(save_file_data, "  "))
	get_tree().quit()
