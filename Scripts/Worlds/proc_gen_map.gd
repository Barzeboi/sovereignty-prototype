extends TileMapLayer

@export var noise_tex: NoiseTexture2D
var map_gen_done = false
var noise: Noise
var height: int = Global.height
var width: int = Global.width
var number: int = 0
var rand_num: int
var tile_data: TileData = TileData.new()
var grass_atlas: Vector2i = Vector2i(1,0)
var fertile_atlas: Vector2i = Vector2i(2,0)
var water_atlas: Vector2i = Vector2i(3,0)
var barren_atlas: Vector2i = Vector2i(4,0)


func _ready() -> void:
	noise = noise_tex.noise
	number = randi()
	_generate_map()
	_generate_map_info()

func _generate_map():
	noise.seed = number
	print(noise.seed)
	for x in range(width):
		for y in range(height):
			var noise_val : float = noise.get_noise_2d(x,y)
			if noise_val <= 0.05:
				set_cell(Vector2i(x,y), 0, water_atlas)
			elif noise_val <= 0.08:
				set_cell(Vector2i(x,y), 0, barren_atlas)
			elif noise_val > 0.08:
				set_cell(Vector2i(x,y), 0, grass_atlas)
		


func _generate_map_info():
	for x in range(width):
		for y in range(height):
			rand_num = randi() % 15
			var surround_cells = get_surrounding_cells(Vector2i(x, y))
			var cell = get_cell_atlas_coords(Vector2i(x,y))
			var data = get_cell_tile_data(Vector2i(x,y))
			if data:
				data.set_custom_data("coordinates", Vector2i(x,y))
			if data && cell == Vector2i(1,0):
				data.set_custom_data("fertility", randi_range(25, 100))
				if data.get_custom_data("fertility") >= 100:
					set_cell(Vector2i(x,y), 0, fertile_atlas)
					if rand_num == 14:
						for cells in surround_cells:
							set_cell(cells, 0, fertile_atlas)
				#print(data.get_custom_data("fertility"))
	map_gen_done = true
	print(map_gen_done)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
			var global_clicked = get_global_mouse_position()
			var pos_clicked = local_to_map(to_local(global_clicked))
			var data = get_cell_tile_data(pos_clicked)
			var coords = data.get_custom_data("coordinates")
			print(pos_clicked)
