extends KinematicBody2D
onready var stats = $Stats
onready var player_detection_radius = $Player_Detection_Radius

const DEATH_EFFECT = preload("res://effects/Enemy_Death_Effect.tscn")

export var ACCELERATION = 300
export var MAX_SPEED = 70
export var FRICTION = 200

enum {
	IDLE,
	WANDER,
	CHASE
}

var state = CHASE
var velocity  = Vector2.ZERO
var knockback = Vector2.ZERO
var knockback_distance = 100








func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
			
		WANDER:
			pass
			
			
		CHASE:

			var player = player_detection_radius.target

			if player != null:
				var direction = global_position.direction_to(player.global_position).normalized()
				velocity = velocity.move_toward(direction * MAX_SPEED, ACCELERATION * delta)
			else:
				velocity = velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
				
	velocity = move_and_slide(velocity)	
#	pass

func seek_player():
	if player_detection_radius.is_target_seen():
		state = CHASE 
	

func _on_Hurtbox_area_entered(area):
	knockback = (global_position - area.get_parent().global_position).normalized() * knockback_distance
	stats.health -= area.damage
	print("Player inflicted ", area.damage, "damage to bat. Bat has ", stats.health, "left")
	
func create_bat_death_effect():

	var death_effect = DEATH_EFFECT.instance()
	get_tree().current_scene.add_child(death_effect)
	death_effect.global_position = global_position
	
func _on_Stats_no_health():
		create_bat_death_effect()
		queue_free()
