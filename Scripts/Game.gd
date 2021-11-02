extends Node2D

#the bullet scene to instance
var bullet = preload("res://Scenes/Bullet.tscn")
var explosion = preload("res://Scenes/Explosion.tscn")
var enemy = preload("res://Scenes/Enemy.tscn")

var lives = 3

#spawn one enemy at a randpom position
func spawn_enemy():
	var x = 1720 * randf()
	var e = enemy.instance()
	e.position = Vector2(x+100,50)
	e.connect("enemy_killed",self,"_on_Enemy_enemy_killed")
	add_child(e)

#signal from ship to shoot-passes the position of the ship as pos
func _on_Ship_shoot(pos):
	var b = bullet.instance()
	b.position = pos
	add_child(b)

#signal from ship when it is killed
func _on_Enemy_enemy_killed(position):
	#make an explosion
	make_explosion(position)

func _on_Timer_timeout():
	spawn_enemy()

func _on_player_killed(position):
	lives -= 1
	$LivesContainer.set_lives(lives)
	make_explosion(position)
	if lives <= 0:
		#we are completely dead. reload the level or go to menu scene?
		#delete all the enemies
		get_tree().call_group("enemy", "queue_free")
		$Timer.paused = true
		$PausePanel.show()
		#show message and wait 5 seconds
		yield (get_tree().create_timer(5),"timeout")
		lives = 3
		$PausePanel.hide()
		$Timer.paused = false
		print("Starting again")

func make_explosion(position):
	var e = explosion.instance()
	e.position = position
	e.emitting = true
	add_child(e)
	$Camera2D.shake()

