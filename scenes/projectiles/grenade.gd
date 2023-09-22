extends RigidBody2D

const SPEED = 1500

func _explode():
	$AnimationPlayer.play("explosion_anim")
