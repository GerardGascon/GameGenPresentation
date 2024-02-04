extends Control

var index_active: = 0

var slide_current
var slide_nodes: = []

func _ready():
	for slide in get_children():
		slide.hide()
		slide_nodes.append(slide)
		remove_child(slide)
	
	enable_slide(slide_nodes[0])


func _unhandled_input(event: InputEvent):
	var valid_event: bool = (
		event.is_action("ui_left") or
		event.is_action("ui_right")
	)
	if not valid_event:
		return
		
	disable_current_slide()
	
	if event.is_action_pressed('ui_right'):
		index_active = clamp(index_active + 1, 0, slide_nodes.size() - 1)
	elif event.is_action_pressed('ui_left'):
		index_active = clamp(index_active - 1, 0, slide_nodes.size() - 1)
	
	enable_slide_index()

func enable_slide(slide):
	slide_current = slide
	add_child(slide_current)
	slide_current.show()

func enable_slide_index():
	enable_slide(slide_nodes[index_active])

func disable_current_slide():
	var slide = slide_nodes[index_active]
	slide.hide()
	remove_child(slide)
