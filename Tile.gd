extends Sprite

var number = 2
var enabled = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  pass # Replace with function body.

func get_number():
  return number

func double():
  number *= 2
  get_node("Number").text = str(number)
  material.set_shader_param("number", number)

func set_pos(x, y):
  self.position.y = y * 268 + 138
  self.position.x = x * 268 + 138

func enabled():
  return enabled

func enable():
  enabled = true

func disable():
  enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
