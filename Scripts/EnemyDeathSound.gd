extends AudioStreamPlayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.play();

func _process(delta):
	if(self.playing == false):
		queue_free()