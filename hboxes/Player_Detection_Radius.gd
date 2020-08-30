extends Area2D


var target = null

func is_target_seen():
	return target != null


func _on_Player_Detection_Radius_body_entered(body):
	target = body


func _on_Player_Detection_Radius_body_exited(body):
	target = null
