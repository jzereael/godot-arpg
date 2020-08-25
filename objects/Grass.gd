extends Node2D

func create_grass_death_effect():
	var Grass_Effect = load("res://effects/Grass_Death_Effect.tscn")
	var grass_effect = Grass_Effect.instance()
	get_tree().current_scene.add_child(grass_effect)
	grass_effect.global_position = global_position
	
		

func _on_Hurtbox_area_entered(area):
	create_grass_death_effect()
	queue_free()
