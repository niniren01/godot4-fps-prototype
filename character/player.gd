extends CharacterBody3D

@onready var camera_3d: Camera3D = $Camera3D

@export var mouse_sensitivity_h = 0.15
@export var mouse_sensitivity_y = 0.15

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity_h
		camera_3d.rotation_degrees.x -= event.relative.y * mouse_sensitivity_y
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -90, 90)
	
	if event.is_action_pressed("quit"):
		get_tree().quit()
