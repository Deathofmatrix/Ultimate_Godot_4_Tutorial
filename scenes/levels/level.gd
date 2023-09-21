extends Node2D

var laser_scene: PackedScene = preload("res://scenes/projectiles/laser.tscn")
var grenade_scene: PackedScene = preload("res://scenes/projectiles/grenade.tscn")

func _on_gate_player_entered_gate(_body):
	print("player has entered gate")

func _on_player_shoot_laser(laser_pos, player_direction):
	var laser = laser_scene.instantiate() as Area2D
	laser.position = laser_pos
	laser.rotation_degrees = rad_to_deg(player_direction.angle()) + 90
	laser.direction = player_direction

	$Projectiles.add_child(laser)

func _on_player_shoot_grenade(grenade_pos, player_direction):
	var grenade = grenade_scene.instantiate() as RigidBody2D
	grenade.position = grenade_pos
	grenade.linear_velocity = player_direction * grenade.SPEED
	
	$Projectiles.add_child(grenade)
