extends KinematicBody2D

var knockback = Vector2.ZERO
var knockback_distance = 100

onready var stats = $Stats

func create_bat_death_effect():
	var Death_Effect = load("res://effects/Enemy_Death_Effect.tscn")
	var death_effect = Death_Effect.instance()
	get_tree().current_scene.add_child(death_effect)
	death_effect.global_position = global_position
	


func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
#	pass


func _on_Hurtbox_area_entered(area):
	knockback = (global_position - area.get_parent().global_position).normalized() * knockback_distance
	stats.max_health -= 1
	print(stats.max_health)
	if (stats.max_health <= 0):
		create_bat_death_effect()
		queue_free()
