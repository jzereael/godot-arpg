extends KinematicBody2D


export var MAX_SPEED = 50
export var ACCELERATION = 250
export var FRICTION = 400
export var ROLL_SPEED = 2



enum {
	MOVE,
	ROLL,
	ATTACK
}


var state = MOVE
var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN

#
onready var animation_player = $AnimationPlayer
onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")


func _ready():
	animation_tree.active = true


func _physics_process(delta):
	match(state):
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)


func move_state(delta):
	var input_vector = Vector2.ZERO
	
	#Normalize Inputs
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	#If player is moving
	if( input_vector != Vector2.ZERO):
		roll_vector = input_vector	#Roll only when moving
		
		#set animation tree
		animation_tree.set("parameters/idle/blend_position", input_vector)
		animation_tree.set("parameters/run/blend_position", input_vector)
		animation_tree.set("parameters/attack/blend_position", input_vector)
		animation_tree.set("parameters/roll/blend_position", input_vector)
		animation_state.travel("run")
	
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		animation_state.travel("idle")
		
	if( Input.is_action_just_pressed("attack") ):
		state = ATTACK
	if( Input.is_action_just_pressed("roll") ) :
		state = ROLL

		
	velocity = move_and_slide(velocity)	
		
		
		
		
	
			
func roll_state(delta):
	velocity = roll_vector * MAX_SPEED * ROLL_SPEED
	animation_state.travel("roll")
	velocity = move_and_slide(velocity) # move()


func roll_animation_finished():
	velocity = velocity / 2
	state = MOVE
	
	
func attack_state(delta):
	velocity = Vector2.ZERO
	animation_state.travel("attack")


func attack_animation_end():
	state = MOVE
	

