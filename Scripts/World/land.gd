extends TileMapLayer

var map_height: int = 400
var map_width: int = 280
var water_atlas = Vector2i(3,0)
var coast_atlas = Vector2i(4,0)
var grass_atlas = Vector2i(1,0)
var field_atlas = Vector2i(2,0)
@export var noise_tex: NoiseTexture2D
var noise: Noise
@export var number: int

func _ready() -> void:
	noise = noise_tex.noise
	number = randi()
	_generate_map()
	
func _process(delta: float) -> void:
	pass

func _generate_map():
	noise.seed = number
	print(noise.seed)
	for x in range(-map_width/2, map_width/2):
		for y in range(-map_height/ 2, map_height/2):
			tile_set.custom_data_layers
			var noise_val: float = noise.get_noise_2d(x, y)
			print(noise_val)
			if noise_val <= 0.0:
				set_cell(Vector2(x, y), 1, water_atlas)
			elif noise_val <= 0.1:
				set_cell(Vector2(x, y), 1, coast_atlas)
			else:
				set_cell(Vector2(x, y), 1, grass_atlas)

func _input(event: InputEvent) -> void:
	var local_position
	
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			local_position = get_global_mouse_position()
			var hex_position = local_to_map(local_position)
			print(hex_position)
