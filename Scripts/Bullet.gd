extends Area2D

var speed = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move the bullet up the screen
	translate(Vector2(0,-speed)* delta)
	if position.y < 0:
		queue_free()
	



