extends Sprite

var number = 2
var enabled = true

var target_x
var target_y

var old_x
var old_y

var timer = 2

var needs_die = false

var grid_x
var grid_y

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
  timer = 2

func _process(delta):
  if (timer <= 2):
    if old_x != null:
      position.x = lerp(old_x, target_x, timer / 2)
      position.y = lerp(old_y, target_y, timer / 2)
    timer += delta
  else:
    get_node("Number").text = str(number)
    material.set_shader_param("number", number)
    if needs_die:
      get_parent().remove_child(self)
      queue_free()

func get_number():
  return number

func double():
  number *= 2

func set_pos(x, y):
  old_x = position.x
  old_y = position.y
  target_x = x * 268 + 138
  target_y = y * 268 + 138
  grid_x = x
  grid_y = y
  timer = 0

func destroy():
  needs_die = true

func enabled():
  return enabled

func enable():
  enabled = true

func disable():
  enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#  pass
