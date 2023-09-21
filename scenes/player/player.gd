extends CharacterBody2D

signal shoot_laser(laser_pos, player_direction)
signal shoot_grenade(grenade_pos, player_direction)

@export var speed: float = 500

var direction: Vector2 = Vector2.ZERO
var can_laser: bool = true
var can_grenade: bool = true
var player_direction: Vector2 = Vector2.ZERO

func _process(_delta):
	# input 
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())
	
	# laser shooting input
	player_direction = (get_global_mouse_position() - position).normalized()
	
	if Input.is_action_pressed("primary action") and can_laser:
		can_laser = false
		var laser_markers = $LaserStartPositions.get_children()
		var selected_laser_pos = laser_markers[randi() % laser_markers.size()]

		$LaserTimer.start()
		
		shoot_laser.emit(selected_laser_pos.global_position, player_direction)
		$GPUParticles2D.restart()
		
		# grenade shooting input
	if Input.is_action_pressed("secondary action") and can_grenade:
		can_grenade = false
		var selected_grenade_pos = $LaserStartPositions.get_children()[1].global_position
		
		$GrenadeTimer.start()
		
		shoot_grenade.emit(selected_grenade_pos, player_direction)

func _on_laser_timer_timeout():
	can_laser = true


func _on_grenade_timer_timeout():
	can_grenade = true
