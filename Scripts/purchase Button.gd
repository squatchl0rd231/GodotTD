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
	
