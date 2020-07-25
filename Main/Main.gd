extends Spatial

onready var _player = $Player
var casting := false
var current_word := ""
signal word_changed(word)

func _process(_delta):
	if Input.is_action_just_pressed("Cast_mode"):
		casting = !casting
	if casting:
		if Input.is_action_just_pressed("A"):
			current_word += "A"
		if Input.is_action_just_pressed("B"):
			current_word += "B"
		if Input.is_action_just_pressed("C"):
			current_word += "C"
		if Input.is_action_just_pressed("D"):
			current_word += "D"
		if Input.is_action_just_pressed("E"):
			current_word += "E"
		if Input.is_action_just_pressed("F"):
			current_word += "F"
		if Input.is_action_just_pressed("G"):
			current_word += "G"
		if Input.is_action_just_pressed("H"):
			current_word += "H"
		if Input.is_action_just_pressed("I"):
			current_word += "I"
		if Input.is_action_just_pressed("J"):
			current_word += "J"
		if Input.is_action_just_pressed("K"):
			current_word += "K"
		if Input.is_action_just_pressed("L"):
			current_word += "L"
		if Input.is_action_just_pressed("M"):
			current_word += "M"
		if Input.is_action_just_pressed("N"):
			current_word += "N"
		if Input.is_action_just_pressed("O"):
			current_word += "O"
		if Input.is_action_just_pressed("P"):
			current_word += "P"
		if Input.is_action_just_pressed("Q"):
			current_word += "Q"
		if Input.is_action_just_pressed("R"):
			current_word += "R"
		if Input.is_action_just_pressed("S"):
			current_word += "S"
		if Input.is_action_just_pressed("T"):
			current_word += "T"
		if Input.is_action_just_pressed("U"):
			current_word += "U"
		if Input.is_action_just_pressed("V"):
			current_word += "V"
		if Input.is_action_just_pressed("W"):
			current_word += "W"
		if Input.is_action_just_pressed("X"):
			current_word += "X"
		if Input.is_action_just_pressed("Y"):
			current_word += "Y"
		if Input.is_action_just_pressed("Z"):
			current_word += "Z"
		if Input.is_action_just_pressed("Backspace"):
			current_word.erase(current_word.length()-1,1)
		emit_signal("word_changed", current_word)


func _on_HUD_summoned_element():
	current_word = ""
