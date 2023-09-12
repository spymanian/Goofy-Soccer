extends RigidBody2D

var _position: = Vector2.ZERO
var _reset_position: = false 
var velocity = Vector2(200, 200)

func _ready():
	var physics_material = PhysicsMaterial.new()
	physics_material.friction = 0.1
	physics_material.bounce = 0.8

	linear_damp = 0.0
	angular_damp = 0.0


func _physics_process(delta):

	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity  = velocity.bounce(collision_info.get_normal())

func make_static_and_set_position(position:Vector2):
	_position = position
	_reset_position = true
