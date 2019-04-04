extends Spatial
signal intruder

var BULLET
var MAGIC
var PHYSICAL
var NEUTRAL

enum Tower {NEUT,PHYS,MAG}

export onready var price = 10 
var type = null

var damage = 10
var fireRange = 3
var fireRate = 1
var interval = fireRate
var canFire = true
var upgradeLevel = 0
var bottomTower = false

var Stack = []
var targs = []

func _ready():
	preload("res://Scripts/Bullet.gd")
	BULLET = preload("res://Scenes/Bullet.tscn")
	MAGIC = preload("res://Scenes/magicTower.tscn")
	PHYSICAL = preload("res://Scenes/physTower.tscn")
	NEUTRAL = preload("res://Scenes/baseTower.tscn")
	$Area.connect("area_entered", self, "_on_Area_area_entered")
	$Area.connect("area_exited", self, "_on_Area_area_exited")
	Stack.append(self)
	
func attack(enemy):
	if canFire:
		self.get_node("AudioStreamPlayer").play()
		var bullet = BULLET.instance()
		bullet.set_name("myBullet")
		bullet.set_translation(self.get_translation())
		bullet.targ = weakref(enemy)
		bullet.dir = enemy.get_global_transform().origin - self.get_global_transform().origin  
		bullet.dir.y = 0
		bullet.dir = bullet.dir.normalized()
		bullet.damage = damage
		self.add_child(bullet)
		var root_node = get_tree().get_root().get_node("Root")
		var board_node = root_node.get_node("Board")
		canFire = false

func setType(type):
	self.type = type
	if type == NEUT:		
		pass
	elif self.type == MAG:
		fireRange = 4.5
		fireRate = 1.3
	elif self.type == PHYS:
		damage = 13
		fireRange = 2.5
		
func _process(delta):
	if !canFire:
		interval -= delta
		if interval <= 0:
			interval = fireRate
			canFire = true
	for i in range(len(targs)):
		if targs[i].get_parent().is_in_group("ENEMY"):
			attack(targs[i].get_parent())
			break

func _on_Area_area_entered(badGuy):
	if badGuy.get_parent().is_in_group("ENEMY"):
		targs.append(badGuy)
		
func _on_Area_area_exited(badGuy):
	if badGuy.get_parent().is_in_group("ENEMY"):
		targs.remove(targs.find(badGuy))
	
func upgrade(num):
	price += 10
	if upgradeLevel < 2:
		var tower
		if num == 1:
			#Neutral Tower
			tower = NEUTRAL.instance()
			tower.setType(NEUT)
		if num == 2:
			#Neutral Tower
			tower = PHYSICAL.instance()
			tower.setType(PHYS)
		if num == 3:
			#Magic Tower
			tower = MAGIC.instance()
			tower.setType(MAG)
		
			
		tower.set_translation(self.get_node("UpgradePoint").get_translation())
		tower.translate(Vector3(0, 1.3, 0) * upgradeLevel)
		self.add_child(tower)
		Stack.append(tower)
		var root_node = get_tree().get_root().get_node("Root")
		var board_node = root_node.get_node("Board")
		
		for i in range(0, Stack.size()):
			if num == 1:
				Stack[i].damage *= 1.1
				Stack[i].fireRange += 0.2
				Stack[i].fireRate -= 0.2
			if num == 2:
				Stack[i].damage *= 1.3
				Stack[i].fireRange -= 0.5
			if num == 3:
				Stack[i].fireRange += 0.5
				Stack[i].fireRate += 0.3
			Stack[i].interval = Stack[i].fireRate
			Stack[i].get_node("Area").get_node("CollisionShape").scale = Vector3(fireRange, fireRange, 1)
		upgradeLevel += 1
	if upgradeLevel == 2:
		if checkStack()[0] == 3:
				#Neutral Stack
				for i in range(0, Stack.size()):
					Stack[i].fireRate = 0.2
					Stack[i].damage = 2
					Stack[i].interval = Stack[i].fireRate
		else: if checkStack()[1] == 3:
				#Physical Stack
				for i in range(0, Stack.size()):
					Stack[i].fireRate = 1.5
					Stack[i].damage = 33
					Stack[i].fireRange = 1
					Stack[i].interval = Stack[i].fireRate
					Stack[i].get_node("Area").get_node("CollisionShape").scale = Vector3(fireRange, fireRange, 1)
		else: if checkStack()[2] == 3:
				#Magical Stack
				for i in range(0, Stack.size()):
					Stack[i].fireRate = 2
					Stack[i].fireRange = 10
					Stack[i].interval = Stack[i].fireRate
					Stack[i].get_node("Area").get_node("CollisionShape").scale = Vector3(fireRange, fireRange, 1)
		else: if checkStack()[0] == 1 && checkStack()[1] == 1 && checkStack()[2] == 1:
				#Everyone Stack
				for i in range(0, Stack.size()):
					Stack[i].fireRate = 0.5
					Stack[i].damage = 15
					Stack[i].fireRange = 5
					Stack[i].interval = Stack[i].fireRate
					Stack[i].get_node("Area").get_node("CollisionShape").scale = Vector3(fireRange, fireRange, 1)
func checkStack():
	var N = 0
	var P = 0
	var M = 0
	for i in range(0, Stack.size()):
		if Stack[i].type == NEUT:
			N += 1
		if Stack[i].type == MAG:
			M += 1
		if Stack[i].type == PHYS:
			P += 1
	return [N, P, M]