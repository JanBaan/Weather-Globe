extends Node2D

var weatherHistory: Array<Dictionary>

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func readWeatherData():
	var file = FileAccess.open("res://csv/GlobalWeatherRepository.csv", FileAccess.READ)
