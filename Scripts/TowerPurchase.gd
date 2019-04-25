extends Button

var root_node
var board_node
var NEUTRAL
var PHYSICAL
var MAGIC

func _ready():
	root_node = get_tree().get_root().get_node("Root")
	board_node = root_node.get_node("Board")
	NEUTRAL = preload("res://Scenes/baseTower.tscn")
	PHYSICAL = preload("res://Scenes/physTower.tscn")
	MAGIC = preload("res://Scenes/magicTower.tscn")

func upgrade(num):
	if board_node.selected_tile != null:
		var tower = board_node.selected_tile.tower
		if tower != null && root_node.money >= tower.price + 10 && tower.upgradeLevel < 2:
			board_node.selected_tile.tower.upgrade(num)
			root_node.money -= board_node.selected_tile.tower.price
			
func purchase(type):
	if(board_node.selected_tile != null):
		var tile = board_node.selected_tile
		var tile_scale = tile.get_scale()
		var new_tower

		# Replace this with a switch?
		if(type == "NEUTRAL"):
			new_tower = NEUTRAL.instance()
			new_tower.setType(new_tower.NEUT)
			new_tower.stackName = "Neutral"
		if(type == "PHYSICAL"):
			new_tower = PHYSICAL.instance()
			new_tower.setType(new_tower.PHYS)
			new_tower.stackName = "Physical"
		if(type == "MAGIC"):
			new_tower = MAGIC.instance()
			new_tower.setType(new_tower.MAG)
			new_tower.stackName = "Magical"
		
		if(tile.tower == null && root_node.money >= 10):
			new_tower.bottomTower = true
			new_tower.set_scale(Vector3(1, 1 / tile_scale.y, 1))
			tile.add_child(new_tower)
			tile.tower = new_tower
			root_node.money -= board_node.selected_tile.tower.price
			board_node.as.remove_point(tile.astar_node_id)
			get_tree().call_group("ENEMY", "move_to", Vector3(33, 0, 10))
