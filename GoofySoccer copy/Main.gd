extends Node2D

@onready var mini_game_manager = $MiniGameManager

var speed1 = 350
var speed2 = 350
var score1 = 0
var score2 = 0
var ball_initial_position = Vector2.ZERO


func _ready():
	ball_initial_position = $Ball.position
# Put any initialization code here.

# Physics processing function
func _physics_process(delta):
	var movement1 = Vector2.ZERO  # Initialize to zero vector
	var movement2 = Vector2.ZERO  # Initialize to zero vector

	# Controls for Player1
	if Input.is_action_pressed("ui_up"):
		movement1.y -= 1
	if Input.is_action_pressed("ui_down"):
		movement1.y += 1
	if Input.is_action_pressed("ui_left"):
		movement1.x -= 1
	if Input.is_action_pressed("ui_right"):
		movement1.x += 1

	# Controls for Player2
	if Input.is_action_pressed("ui_w"):
		movement2.y -= 1
	if Input.is_action_pressed("ui_s"):
		movement2.y += 1
	if Input.is_action_pressed("ui_a"):
		movement2.x -= 1
	if Input.is_action_pressed("ui_d"):
		movement2.x += 1

	$Player1.velocity = movement2.normalized() * speed1
	$Player1.move_and_slide()

	$Player2.velocity = movement1.normalized() * speed2
	$Player2.move_and_slide()
	
# Function to handle when the ball enters Goal1
func _on_Goal1_body_entered(body):
	if body.name == "Ball":
		speed2 -= 50  # Reduce speed for Player2
		mini_game_manager.goal_scored_by_player2()
		reset_positions()

# Function to handle when the ball enters Goal2
func _on_Goal2_body_entered(body):
	if body.name == "Ball":
		speed1 -= 50  # Reduce speed for Player1
		mini_game_manager.goal_scored_by_player1()
		reset_positions()

# Function to reset positions of players and the ball
func reset_positions():

	$Player1.position = Vector2(0, 0)  # Replace with your actual coordinates
	$Player2.position = Vector2(0, 0)
	$Ball.make_static_and_set_position(ball_initial_position)
	# You can replacesss this with a more elaborate victory screen
	# Switch back to the main menu



func _on_show_winner(winner):
	
	get_tree().change_scene_to_file("res://" + winner.replace(" ", "") + "Wins.tscn")# Replace with function body.
	


func _on_mini_game_manager_update_score(player, score):
	if player == "Player 1":
		$Score1.text = str(score)
	elif player == "Player 2":
		$Score2.text = str(score)


func _on_mini_game_manager_winner_declared(winner):
	print("Winner is Player ", winner) # Replace with function body.
	mini_game_manager.end_game([{
		"player": winner,
		"points": 3  # Change this to whatever points you want to award for a win
	}])
