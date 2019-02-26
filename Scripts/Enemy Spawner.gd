extends Spatial

# class member variables go here, for example:
var Root_Node
var Board_Node
var Enemy_Timer
var Enemy

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	Root_Node = get_tree().get_root().get_node("Root")
	Board_Node = Root_Node.get_node("Board")
	Enemy_Timer = Root_Node.get_node("EnemyTimer")
	Enemy = load("res://Scenes/Enemy.tscn")

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func Spawn():
	var Clone = Enemy.instance()
	Root_Node.add_child(Clone)
	Clone.global_transform = self.global_transform
	Board_Node.ignore_list.append(Clone.get_node("Area"))

func _on_EnemyTimer_timeout():
	self.Spawn()