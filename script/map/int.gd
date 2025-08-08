extends Node2D

func _ready():
	Dialogic.signal_event.connect(DialogicSignal)
	pass
	
func DialogicSignal(argument:String):
	var plankton = get_node("npc/AudioStreamPlayer2D")
	if argument == "start_battle":
		get_tree().change_scene_to_file("res://scenes/battles/background_battle.tscn")
	if argument == "jumpscare":
		plankton.play()
		
