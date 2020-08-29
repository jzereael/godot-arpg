extends AnimatedSprite


#onready var animated_sprite = $AnimatedSprite


func _ready():
	connect("animation_finished", self, "_on_AnimatedSprite_animation_finished" )
	frame = 0
	play("Animate")


func _on_AnimatedSprite_animation_finished():
	queue_free()

