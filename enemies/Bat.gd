extends KinematicBody2D

var knockback = Vector2.ZERO
var knockback_distance = 100

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200 * delta)
	knockback = move_and_slide(knockback)
#	pass


func _on_Hurtbox_area_entered(area):
	knockback = (global_position - area.get_parent().global_position).normalized() * knockback_distance
