@tool
# Este recurso define a estrutura de dados e a lógica para uma única carta no jogo.
extends Resource
class_name Card

# --- ENUMS E CONSTANTES ---

# O modo de uma carta, que pode afetar suas interações.
enum Mode { NORMAL, LIGHT, DARK }

# O elemento da carta, usado para determinar fraquezas e resistências.
enum Element { FIRE, PLANT, WATER, ROCK, THUNDER }

# Define os valores mínimos e máximos para o atributo de força.
const STRENGTH_MIN := 0
const STRENGTH_MAX := 9


# Define os valores mínimos e máximos para o atributo de vida.
const LIFE_MIN := 0
const LIFE_MAX := 9

# O tipo da carta, que determina sua função (ataque, defesa, especial).
enum Type { REGULAR, MIRROR, SHIELD, PLUS2 }

# --- FUNÇÕES DE VERIFICAÇÃO DE TIPO ---

# Retorna verdadeiro se a carta for do tipo MIRROR.
func is_mirror() -> bool:
	return type == Type.MIRROR

# Retorna verdadeiro se a carta for do tipo SHIELD.
func is_shield() -> bool:
	return type == Type.SHIELD

# Retorna verdadeiro se a carta for do tipo PLUS2.
func is_plus2() -> bool:
	return type == Type.PLUS2

# --- LÓGICA ELEMENTAL ---

# Dicionário que define qual elemento vence qual. (Ex: FOGO vence PLANTA)
const ELEMENT_BEATS := {
	Element.FIRE: Element.PLANT,
	Element.PLANT: Element.ROCK,
	Element.ROCK: Element.THUNDER,
	Element.THUNDER: Element.WATER,
	Element.WATER: Element.FIRE
}

# Dicionário que define qual elemento fortalece qual. (Ex: FOGO é fortalecido por ÁGUA)
# Nota: A lógica de fortalecimento não parece estar totalmente implementada.
const ELEMENT_STR := {
	Element.FIRE: Element.WATER,
	Element.WATER: Element.THUNDER,
	Element.THUNDER: Element.ROCK,
	Element.ROCK: Element.PLANT,
	Element.PLANT: Element.FIRE
}

# --- PROPRIEDADES DA CARTA ---
# As propriedades a seguir são exportadas para serem editáveis no inspetor do Godot.

@export var mode: int = Mode.NORMAL
@export var element: int = Element.FIRE
@export var strength: int = 0
@export var life: int = 0
@export var type: int = Type.REGULAR

# Flags para indicar se a carta recebeu um bônus especial de força ou vida.
@export var special_strength := false
@export var special_life := false

# --- FUNÇÕES ---

# Construtor: Cria e inicializa uma nova instância da carta com os valores fornecidos.
func _init(_mode: int = Mode.NORMAL, _element: int = Element.FIRE, _strength: int = 0, _life: int = 0, _type: int = Type.REGULAR):
	mode = _mode
	element = _element
	# Garante que a força e a vida permaneçam dentro dos limites definidos.
	strength = clamp(_strength, STRENGTH_MIN, STRENGTH_MAX)
	life = clamp(_life, LIFE_MIN, LIFE_MAX)
	type = _type

# Verifica se esta carta tem vantagem elemental sobre outra carta.
func is_stronger_than(other: Card) -> bool:
	return ELEMENT_BEATS.get(self.element, -1) == other.element
	
# Verifica se esta carta tem desvantagem elemental em relação a outra carta.
func is_weaker_than(other: Card) -> bool:
	return ELEMENT_BEATS.get(other.element, -1) == self.element

# Aplica um bônus (ou penalidade) com base na interação elemental.
# ATENÇÃO: A lógica aqui parece ter um bug. `is_stronger_than(self_card)` compara a carta com ela mesma.
func apply_elemental_bonus(self_card: Card, other_card: Card):
	var effective_strength = self_card.strength
	var effective_life = self_card.life
	
	# BUG: Esta condição sempre será falsa, a menos que a intenção fosse comparar com `other_card`.
	if self_card.is_stronger_than(self_card):
		effective_strength -= 2
		effective_life -= 2
		
		
		return { "strength": effective_strength, "life": effective_life }
		
	if self_card.is_weaker_than(other_card):
		effective_strength -= 2
		effective_life -= 2
		
		
		return { "strength": effective_strength, "life": effective_life }

# Ajusta as propriedades da carta com base em seu tipo.
# Cartas de ação (não REGULAR) não devem ter estatísticas de combate.
func check_type(target_card: Card):
	if target_card.type != Type.REGULAR:
		target_card.strength = -1
		target_card.life = -1
	# Se a carta não for NORMAL e for do tipo PLUS2, seu elemento é zerado.
	if target_card.mode != Mode.NORMAL:
		if target_card.type == Type.PLUS2:
			target_card.element = -1

# Aplica o efeito da carta PLUS2 no modo LIGHT a uma carta alvo.
func apply_light_plus2(target_card: Card):
	if target_card.type == Type.REGULAR:
		target_card.mode = Mode.LIGHT
		target_card.life -=2
		# Se a vida ficar muito baixa, ativa o status especial de vida.
		if target_card.life <= 2:
			target_card.special_life = true

# Aplica o efeito da carta PLUS2 no modo DARK a uma carta alvo.
func apply_dark_plus2(target_card: Card):
	if target_card.type == Type.REGULAR:
		target_card.mode = Mode.DARK
		target_card.strength -= 2
		# Se a força ficar muito baixa, ativa o status especial de força.
		if target_card.strength <= 2:
			target_card.special_strength = true
