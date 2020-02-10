extends Node2D

var swipe_start = null
var minimum_drag = 100

var tiles = []

func _ready():
  for y in 4:
    var row = []
    for x in 4:
      row.append(null)
    tiles.append(row)
  randomize()
  var x = randi() % 4
  var y = randi() % 4
  create_tile(x, y)

func create_tile(x : int, y : int):
  var tile = get_node("Tile").duplicate()
  print(tile)
  tile.position.y = y * 268 + 138
  tile.position.x = x * 268 + 138
  tile.show()
  add_child(tile)
  tiles[y][x] = tile

func update_board(x, y):
  print("Sliding board " + str(x) + ", " + str(y))
  x = randi() % 4
  y = randi() % 4
  create_tile(x, y)

func _unhandled_input(event):
  if event.is_action_pressed("click"):
    swipe_start = get_global_mouse_position()
  if event.is_action_released("click"):
    _calculate_swipe(get_global_mouse_position())

func _calculate_swipe(swipe_end):
  if swipe_start == null:
    return
  var swipe = swipe_end - swipe_start
  if abs(swipe.x) > minimum_drag:
    if abs(swipe.y) > minimum_drag:
      if abs(swipe.x) > abs(swipe.y):
        if swipe.x > 0:
          update_board(1, 0)
        else:
          update_board(-1, 0)
      else:
        if swipe.y > 0:
          update_board(0, 1)
        else:
          update_board(0, -1)
    else:
      if swipe.x > 0:
        update_board(1, 0)
      else:
        update_board(-1, 0)
  else:
    if abs(swipe.y) > minimum_drag:
      if swipe.y > 0:
        update_board(0, 1)
      else:
        update_board(0, -1)