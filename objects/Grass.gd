extends Node2D

const GRASS_EFFECT = preload("res://effects/Grass_Destroy_Effect.tscn")

func create_grass_death_effect():
	var grass_effect = GRASS_EFFECT.instance()
	get_tree().current_scene.add_child(grass_effect)
	grass_effect.global_position = global_position
	
		

func _on_Hurtbox_area_entered(area):
	create_grass_death_effect()
	queue_free()
