extends Area2D

export var speed = 500
var vertical = 0
var horizontal = 0
var fire_rate = 0.1
var timer = 0

var bullet_scene = preload("res://Scenes/Bullet.tscn")
onready var game = get_tree().get_root()

#a signal that says we want to shoot
signal player_killed(position)

func _physics_process(delta):
	move(delta)
	shoot(delta)

func move(delta):
	var v = Vector2.ZERO
	if Input.is_action_pressed("left") and position.x > 200:
		v.x = -1
	elif Input.is_action_pressed("right") and position.x < 1720:
		v.x = 1
	horizontal = lerp(horizontal,v.x,delta*5)
	#now the up and down
	if Input.is_action_pressed("down") and position.y < 880:
		v.y = 1
	if Input.is_action_pressed("up") and position.y > 540:
		v.y = -1
	#lerp to v
	vertical = lerp(vertical,v.y,delta*5)
	#move_and_collide(Vector2(horizontal * speed,vertical * speed)* delta)
	translate(Vector2(horizontal * speed,vertical * speed)* delta)

func shoot(delta):
	timer += delta
	if Input.is_action_pressed("fire") and timer > fire_rate:
		#shoot!
		#emit_signal("shoot",position)
		shoot_bullet()
		timer = 0
		$AudioStreamPlayer.play()
		
func shoot_bullet():
	var bullet = bullet_scene.instance()
	bullet.position = position
	game.add_child(bullet)
	
	
func _on_Ship_area_entered(area):
	if area.is_in_group("enemy"):
		#this is something that can kill us- like an enemy or a enemy bullet
		print("We Dead!")
		emit_signal("player_killed",position)
		area.queue_free()
