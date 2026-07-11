extends Node2D

var cityScene = preload('res://scenes/city.tscn')
var ListOfWeatherData: Array[WeatherObject]
@onready var citiesNode: Node2D = get_node("Cities")

@onready var seasonText = $Season/SeasonText
var currentSeasonInt: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	readWeatherData()
	createCities()
	
	currentSeasonInt = Enums.Season.Summer
	seasonText.text = Enums.Season.keys()[currentSeasonInt]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# reads the json file and creates a list of weather Data per city
func readWeatherData():
	var file = FileAccess.open("res://files/weatherData.json", FileAccess.READ)
	var json_text = JSON.parse_string(file.get_as_text())
	
	var capital_array = [
		"Amsterdam", 
		"Den Haag", 
		"Rotterdam", 
		"Groningen", 
		"Nijmegen", 
		"Maastricht", 
		"Zwolle", 
		"Breda", 
		"Enschede"
	]
	
	for capital in capital_array:
		for i in range(4):
			var weatherObject = WeatherObject.new()
			weatherObject.capital = capital
			weatherObject.temp = json_text[capital][i]["temp"]
			weatherObject.feel_temp = json_text[capital][i]["feel_temp"]
			weatherObject.wind_speed = json_text[capital][i]["wind_speed"]
			weatherObject.wind_degree = json_text[capital][i]["wind_degree"]
			weatherObject.wind_direction = json_text[capital][i]["wind_direction"]
			weatherObject.humidity = json_text[capital][i]["humidity"]
			weatherObject.season = json_text[capital][i]["season"]

			ListOfWeatherData.append(weatherObject)
		
	file.close()
	
# creates multiple cities and sets the name, position, and weather data per city
func createCities():
	var cityDict: Dictionary
	cityDict.set('Amsterdam', Vector2(822, 455))
	cityDict.set('Den Haag', Vector2(656, 570))
	cityDict.set('Rotterdam', Vector2(717, 620))
	cityDict.set('Groningen', Vector2(1338, 71))
	cityDict.set('Nijmegen', Vector2(1103, 641))
	cityDict.set('Maastricht', Vector2(1054, 1024))
	cityDict.set('Zwolle', Vector2(1150, 406))
	cityDict.set('Breda', Vector2(777, 754))
	cityDict.set('Enschede', Vector2(1382, 499))
	
	for cityName in cityDict.keys():
		var cityObject = cityScene.instantiate() as City
		cityObject.setName(cityName)
		
		var pos = cityDict.get(cityName)
		cityObject.setPosition(pos)
		
		var weatherData:Array[WeatherObject] = []
		
		for object in ListOfWeatherData:
			if object.capital == cityName:
				weatherData.append(object)
				
		cityObject.setWeatherData(weatherData)
		citiesNode.add_child(cityObject)
	
# changes to the next season
func _on_next_pressed() -> void:
	currentSeasonInt += 1
	
	if currentSeasonInt == 4:
		currentSeasonInt = 0
		
	seasonText.text = Enums.Season.keys()[currentSeasonInt]

# changes to the previous season
func _on_prev_pressed() -> void:
	currentSeasonInt -= 1
	
	if currentSeasonInt == -1:
		currentSeasonInt = 3
		
	seasonText.text = Enums.Season.keys()[currentSeasonInt]
