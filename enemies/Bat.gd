extends KinematicBody2D

const DEATH_EFFECT = preload("res://effects/Enemy_Death_Effect.tscn")

var knockback = Vector2.ZERO
var knockback_distance = 100

onready var stats = $Stats

func create_bat_death_effect():

	var death_effect = DEATH_EFFECT.instance()
	get_tree().current_scene.add_child(death_effect)
	death_effect.global_position = global_position
	

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
#	pass


func _on_Hurtbox_area_entered(area):
	knockback = (global_position - area.get_parent().global_position).normalized() * knockback_distance
	stats.health -= area.damage
	print("Player inflicted ", area.damage, "damage to bat. Bat has ", stats.health, "left")

	
func _on_Stats_no_health():
		create_bat_death_effect()
		queue_free()
