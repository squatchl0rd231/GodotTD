extends Label

var root_node
var board_node

func _ready():
	root_node = get_tree().get_root().get_node("Root")
	board_node = root_node.get_node("Board")

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	if board_node.selected_tile != null:
		if board_node.selected_tile.tower != null:
			self.text = "100"
		else:
			self.text = ""
	else:
		self.text = ""
	pass