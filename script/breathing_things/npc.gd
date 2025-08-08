extends CharacterBody2D

var player_in_area = false
var working = "working"
var is_chatting = false

func _ready() -> void:
	play_anim(0)
	
func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("Interact"):
			run_dialogue("Stroudowtimeline")

func run_dialogue(dialogue_string):
	is_chatting = true
	
	Dialogic.start(dialogue_string)

func play_anim(movement):
	$AnimatedSprite2D.play("stroudow_idle")

func _on_start_battle_chat_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = true


func _on_start_battle_chat_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = false
		
