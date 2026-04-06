extends Resource
class_name CountryData

@export var country_id : int
@export var color : Color = Color(randf_range(0.0, 255.0),randf_range(0.0, 255.0),randf_range(0.0, 255.0),randf_range(0.0, 255.0))
@export var owned_tiles : Array
