extends Node

var money
var health
var wave_num
var board_node
var button1
var button2
var button3
var button4
var button5

func _ready():
	money = 50
	health = 25
	wave_num = 0
	
	board_node = self.get_node("Board")
	button1 = self.get_node("MainPanel/UpgradeSelect1")
	button2 = self.get_node("MainPanel/UpgradeSelect2")
	button3 = self.get_node("MainPanel/UpgradeSelect3")
	button4 = self.get_node("MainPanel/SellButton")
	button5 = self.get_node("MainPanel/SpawnButton")

func _process(delta):
	Global.Wave_Count = wave_num
	if(Input.is_key_pressed(KEY_ESCAPE)):
		get_tree().quit()
	if(Input.is_action_just_pressed("UPGRADE1")):
		button1._pressed()
	if(Input.is_action_just_pressed("UPGRADE2")):
		button2._pressed()
	if(Input.is_action_just_pressed("UPGRADE3")):
		button3._pressed()
	if(Input.is_action_just_pressed("SELL")):
		button4._pressed()
	if(Input.is_action_just_pressed("SPAWN")):
		button5._pressed()
	if(health <= 0):
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	if(wave_num == 40):
		get_tree().change_scene("res://Scenes/GameVictory.tscn")