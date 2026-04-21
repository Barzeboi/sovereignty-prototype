extends TileMapLayer

@onready var proc_gen_map: TileMapLayer = $'../ProcGenMap'
var height: int = Global.height
var width: int = Global.width

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _generate_locations():
	for x in range(width):
		for y in range(height):
			pass
