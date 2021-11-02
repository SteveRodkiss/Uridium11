extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var shake_timer = 0
onready var start_position = position
var shake_amount = 0
var shake_offset_h = 0
var shake_offset_v = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	pass # Replace with function body.

func _process(delta):
	#camera shake
	shake_timer += delta
	offset_h =  shake_amount * sin(shake_timer*100 + shake_offset_h)
	offset_v = shake_amount * sin(shake_timer*100+ shake_offset_v)
	shake_amount = lerp(shake_amount,0,10*delta)
	

func shake():
	shake_timer = 0
	shake_amount = 0.3
	shake_offset_h = PI * randf()
	shake_offset_h = PI * randf()
