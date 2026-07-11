extends Sprite2D
class_name City

var _weatherData: Array[WeatherObject]
@onready var panel: Sprite2D = get_node("Panel")
var seasonText: Label

func _ready() -> void:
	panel.visible = false

# sets position of city
func setPosition(pos: Vector2):
	position = pos
	
# sets name of city
func setName(cityName: String):
	name = cityName
	
func setWeatherData(weatherData: Array):
	_weatherData = weatherData
	
# city scale increase on mouse hover
func _on_area_2d_mouse_entered() -> void:
	scale.x += 1
	scale.y += 1

# city scale decrease on mouse exit
func _on_area_2d_mouse_exited() -> void:
	scale.x -= 1
	scale.y -= 1
	
	panel.visible = false

#opens panel that contains weather data per season
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		seasonText = $"../../Season/SeasonText"
		
		for data in _weatherData:
			if data.season == seasonText.text:
				$Panel/temp.text = str(data.temp) + " °C"
				$Panel/feel_temp.text = "Real feel: " + str(data.feel_temp) + " °C"
				$Panel/wind.text = "Wind: " + str(data.wind_degree) + str(data.wind_direction)+ " " + str(data.wind_speed) + "km/h"
				$Panel/humidity.text = "Humidity: " + str(data.humidity) + "%"
				
		panel.visible = true	
