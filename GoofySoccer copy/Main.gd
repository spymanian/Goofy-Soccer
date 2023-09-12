extends Node2D

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
		movement2.y -= 1
	if Input.is_action_pressed("ui_down"):
		movement2.y += 1
	if Input.is_action_pressed("ui_left"):
		movement2.x -= 1
	if Input.is_action_pressed("ui_right"):
		movement2.x += 1

	# Controls for Player2
	if Input.is_action_pressed("ui_w"):
		movement1.y -= 1
	if Input.is_action_pressed("ui_s"):
		movement1.y += 1
	if Input.is_action_pressed("ui_a"):
		movement1.x -= 1
	if Input.is_action_pressed("ui_d"):
		movement1.x += 1

	$Player1.velocity = movement1.normalized() * speed2
	$Player1.move_and_slide()

	$Player2.velocity = movement2.normalized() * speed1
	$Player2.move_and_slide()
	
# Function to handle when the ball enters Goal1
func _on_Goal1_body_entered(body):
	if body.name == "Ball":
		speed2 -= 50  # Reduce speed for Player2
		score2 += 1  # Increase score for Player2
		$Score2.text = str(score2)  # Update the Label2
		check_for_winner()
		reset_positions()

# Function to handle when the ball enters Goal2
func _on_Goal2_body_entered(body):
	if body.name == "Ball":
		speed1 -= 50  # Reduce speed for Player1
		score1 += 1  # Increase score for Player1
		$Score1.text = str(score1)
		check_for_winner()  # Update the Label1
		reset_positions()

# Function to reset positions of players and the ball
func reset_positions():

	$Player1.position = Vector2(0, 0)  # Replace with your actual coordinates
	$Player2.position = Vector2(0, 0)
	$Ball.make_static_and_set_position(ball_initial_position)

# New function to check for a winner
func check_for_winner():
	if score1 >= 3:
		get_tree().change_scene_to_file("res://Player1Wins.tscn")
		show_winner("Player 1")
	elif score2 >= 3:
		get_tree().change_scene_to_file("res://Player2Wins.tscn")
		show_winner("Player 2")
		

# New function to show the winner and switch to the main menu
func show_winner(winner: String):
	print(winner + " is the winner!")
	# You can replacesss this with a more elaborate victory screen
	# Switch back to the main menu

