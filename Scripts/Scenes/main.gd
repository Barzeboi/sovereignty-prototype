extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$positive_sample.hide()
	$negative_sample.hide()
	$Land.show()
	$WFC2DGenerator.start()
