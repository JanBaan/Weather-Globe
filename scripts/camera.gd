extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
		
func _physics_process(delta):
	drag()
	zoom()
	
# this controls the zoom of the camera
func zoom():
	if Input.is_action_just_released('wheel down') and get_zoom().x >= 1.5:
		set_zoom(get_zoom() - Vector2(0.5, 0.5))
	if Input.is_action_just_released('wheel up'):
		set_zoom(get_zoom() + Vector2(0.5, 0.5))
		
func drag():
	pass
