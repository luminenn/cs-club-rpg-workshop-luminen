# Use the @tool tag to allow the user to change the player sprite while in-editor
@tool
class_name CharacterSprite extends Sprite2D

enum Character {
	NAKED,
	BOY,
	GIRL,
	SKELLY,
	SLIMEY,
	BAT,
	SPOOKSTER,
	BITSY_ITSY
}

enum Dir {
	DOWN,
	LEFT,
	RIGHT,
	UP,
}

@export var dir: Dir :
	set(value):
		dir = value
		reset_frame_coords()

@export_range(0,2) var anim_frame : int :
	set(value):
		anim_frame = value
		reset_frame_coords()
@export var character: Character :
	set(value):
		character = value
		reset_frame_coords()

func reset_frame_coords() -> void:
	frame_coords = get_character_origin()
	frame_coords.x += anim_frame
	frame_coords.y += dir

		
func get_character_origin() -> Vector2i:
	return Vector2i((character % 4) * 3, (character / 4) * 4)
