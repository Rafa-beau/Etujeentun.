extends Node2D
#@export var card: Card
#
#enum Element { FIRE, PLANT, WATER, ROCK, THUNDER }
## Constants for deck construction
#const ELEMENTS = [Element.FIRE, Element.PLANT, Element.WATER, Element.ROCK, Element.THUNDER]
#var NUMBERS = range(0, 10)
#const TYPE_NORMAL = Card.Type.REGULAR
#const TYPE_MIRROR = Card.Type.MIRROR
#const TYPE_SHIELD = Card.Type.SHIELD
#
## The deck and hand arrays
#var deck: Array = []
#var hand: Array = []
#
## Reference to your Card resource/class (adjust path/class_name as needed)
## class_name Card should be in card.gd
## @icon("res://path_to_icon.png")
#
#func _ready():
	#create_full_deck()
	#shuffle_deck()
	#draw_hand(5)  # Draw 5 cards as an example
#
#func create_full_deck():
	#deck.clear()
	## Add normal cards (numbers 0-9 of each element)
	#for element in ELEMENTS:
		#for number in NUMBERS:
			#var card = Card.new()
			#card.element = element
			#card.number = number
			#card.type = TYPE_NORMAL
			#deck.append(card)
	## Add one Mirror and one Shield of each element
	#for element in ELEMENTS:
		#var mirror = Card.new()
		#mirror.element = element
		#mirror.number = -1 # Use -1 for Mirror cards (no number)
		#mirror.type = TYPE_MIRROR
		#deck.append(mirror)
#
		#var shield = Card.new()
		#shield.element = element
		#shield.number = -1 # Use -1 for Shield cards (no number)
		#shield.type = TYPE_SHIELD
		#deck.append(shield)
	#print("Full deck size: ", deck.size())
#
#func shuffle_deck():
	#deck.shuffle()
#
#func draw_hand(hand_size: int):
	#hand.clear()
	#for i in range(hand_size):
		#if deck.is_empty():
			#print("Deck is empty!")
			#break
		#var card = deck.pop_back()
		#hand.append(card)
	#print("Hand: ", hand)
