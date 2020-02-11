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
  #var x = randi() % 4
  #var y = randi() % 4
  create_tile(0, 0)
  tiles[0][0].double()
  create_tile(0, 1)
  create_tile(0, 2)

func create_tile(x : int, y : int):
  var tile = get_node("Tile").duplicate()
  tile.material = tile.material.duplicate(false)
  tile.set_pos(x, y)
  tile.show()
  add_child(tile)
  tiles[y][x] = tile

func update_board(dir):
  print("Sliding board " + dir)
  var x = 0
  var y = 0
  for row in 4:
    var col_items = []
    for col in 4:
      var coords = calc_pos(row, col, dir)
      x = coords[0]
      y = coords[1]
      var tile = tiles[y][x]
      if tile != null:
        if len(col_items) > 0 and col_items[-1].get_number() == tile.get_number() && col_items[-1].enabled():
          col_items[-1].double()
          col_items[-1].disable()
          tile.queue_free()
          remove_child(tile)
        else:
          col_items.append(tile)
      tiles[y][x] = null
    for col in len(col_items):
      var coords = calc_pos(row, col, dir)
      x = coords[0]
      y = coords[1]
      tiles[y][x] = col_items[col]
      col_items[col].enable()
      col_items[col].set_pos(x, y)
  while true:
    x = randi() % 4
    y = randi() % 4
    if tiles[y][x] == null:
      create_tile(x, y)
      break

func calc_pos(row, col, dir):
  if dir == "up":
    return [row, col]
  elif dir == "down":
    return [row, -col + 3]
  elif dir == "left":
    return [col, row]
  elif dir == "right":
    return [-col + 3, row]

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
          update_board("right")
        else:
          update_board("left")
      else:
        if swipe.y > 0:
          update_board("down")
        else:
          update_board("up")
    else:
      if swipe.x > 0:
        update_board("right")
      else:
        update_board("left")
  else:
    if abs(swipe.y) > minimum_drag:
      if swipe.y > 0:
        update_board("down")
      else:
        update_board("up")