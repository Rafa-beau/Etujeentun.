class_name hand
extends HBoxContainer


func _ready() -> void:
	for child in get_children():
		var card_ui := child as CardUI
		card_ui.reparent_request.connect(_on_card_ui_reparent_requested)

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.reparent(self)
