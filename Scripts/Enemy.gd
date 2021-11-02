extends Area2D

signal enemy_killed(position)

func _process(delta):
	move_local_y(100 * delta)


func _on_Enemy_body_entered(body):
	#kill the enemy ship
	print(body.name)
	queue_free()
	#kill the bullet that hit it
	body.queue_free()
	#tell the game that we killed an enemy
	emit_signal("enemy_killed",position)




func _on_Enemy_area_entered(area):
	#kill the enemy ship
	if area.is_in_group("bullet"):
		print(area.name)
		queue_free()
		#kill the bullet that hit it
		area.queue_free()
		#tell the game that we killed an enemy
		emit_signal("enemy_killed",position)

