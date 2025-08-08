extends cardState

func enter() -> void:
	card_ui.state.text = "CLICKED"
	card_ui.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, cardState.State.DRAGGING)
