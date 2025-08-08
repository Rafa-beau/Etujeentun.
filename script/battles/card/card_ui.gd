extends Control
class_name CardUI

@export var card: Card

const SPRITESHEET = preload("res://assets/Images/elements_types.png")
const ICON_SIZE = Vector2i(62, 92)

signal reparent_request(which_card_ui: CardUI)

@onready var state: Label = $State
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine
@onready var drop_point_detector: Area2D = $dropPoint
@onready var targets: Array[Node] = []

func _ready() -> void:
	if card != null:
		_update_all()
	card_state_machine.init(self)

func _update_all():
	update_element_image()
	update_strenght_label()
	update_life_label()

func set_card(new_card: Card):
	card = new_card
	_update_all()

func update_element_image():
	if card == null or card.element < 0:
		return
	var image_node = $Sprite2D
	image_node.texture = SPRITESHEET
	image_node.region_enabled = true
	image_node.region_rect = Rect2i(
		Vector2i(card.element * ICON_SIZE.x, 0),
		ICON_SIZE
	)
	image_node.queue_redraw() # Optional: ensure update happens visually


const Strength = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
func update_strenght_label():
	if card == null:
		return
	var label_node = $Strength
	var strength_index = card.strength
	var strength_name = Strength[strength_index] if strength_index < Strength.size() else "Unknown"
	label_node.text = strength_name

const Life = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
func update_life_label():
	if card == null:
		return
	var label_node = $Life
	var life_index = card.life
	var life_name = Life[life_index] if life_index < Life.size() else "Unknown"
	label_node.text = life_name

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not targets.has(area):
		targets.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	targets.erase(area)
