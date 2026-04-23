extends TileMapLayer

@export var noise_tex: NoiseTexture2D
@onready var proc_gen_map: TileMapLayer = $'../ProcGenMap'
var height: int = Global.height
var width: int = Global.width

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_generate_locations()


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore('unused_parameter')
func _process(delta: float) -> void:
	pass


func _generate_locations():
	for x in range(width):
		for y in range(height):
			var surround_cells = get_surrounding_cells(Vector2i(x,y))
			var cell = get_cell_atlas_coords(Vector2i(x,y))
			var data = get_cell_tile_data(Vector2i(x,y))
			if proc_gen_map.cell == Vector2i(1,0):
				set_cell(Vector2i(x,y),0,Vector2i(0,0),1)
