extends Node

enum Mode{ NONE, SELL, BUY }

var money;
var mode;
var selected;
var health;

func _ready():
	money = 100;
	health = 10;
	mode = Mode.NONE;
	selected = null;


	#OS.set_window_fullscreen(true)

func _process(delta):
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
