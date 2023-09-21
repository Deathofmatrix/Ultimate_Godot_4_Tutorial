extends CharacterBody2D

const SPEED: int = 200
var direction: Vector2 = Vector2.RIGHT

func _process(delta):
	velocity = direction * SPEED 
	move_and_slide()
