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
	_generate_map_fertility()

func _generate_map():
	noise.seed = number
	print(noise.seed)
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val : float = noise.get_noise_2d(x,y)
			if noise_val <= 0.05:
				set_cell(Vector2i(x,y), 0, water_atlas)
			elif noise_val <= 0.14:
				set_cell(Vector2i(x,y), 0, barren_atlas)
			elif noise_val > 0.14:
				set_cell(Vector2i(x,y), 0, grass_atlas)
		
	map_gen_done = true
	print(map_gen_done)

func _generate_map_fertility():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			rand_num = randi() % 15
			var surround_cells = get_surrounding_cells(Vector2i(x, y))
			var cell = get_cell_atlas_coords(Vector2i(x,y))
			var data = get_cell_tile_data(Vector2i(x,y))
			if data && cell == Vector2i(1,0):
				data.set_custom_data("fertility", randi_range(25, 100))
				if data.get_custom_data("fertility") >= 100:
					set_cell(Vector2i(x,y), 0, fertile_atlas)
					if rand_num == 14:
						for cells in surround_cells:
							set_cell(cells, 0, fertile_atlas)
				#print(data.get_custom_data("fertility"))
				print(rand_num)
