extends CanvasLayer

onready var spelllabel:Label = $SpellLabel
onready var icon1:Sprite = $Spell_Icons/Spell_Icon1
onready var icon2:Sprite = $Spell_Icons/Spell_Icon2
onready var icon3:Sprite = $Spell_Icons/Spell_Icon3
var spell := {"FIRE":0, "COLD":0, "WATER":0, "SHOCK":0, "HEAL":0, "PROTECT":0, "EARTH":0, "AIR":0}
var summoned_elements := 0
signal summoned_element
signal update_spell(spell)

func _on_Main_word_changed(word):
	spelllabel.text = word
	if word == "FIRE" or word == "COLD" or word == "EARTH" or word == "WATER" or word == "HEAL" or word == "AIR" or word == "PROTECT" or word == "SHOCK":
		if summoned_elements < 3:
			spell[word] += 1
			summoned_elements += 1
			var mod := Color(0,0,0,0)
			if word == "FIRE":
				mod = Color(1,0,0,1)
			if word == "WATER":
				mod = Color(0,0,1,1)
			if word == "AIR":
				mod = Color(0.75,0.75,0.75,1)
			if word == "SHOCK":
				mod = Color(1,0,1,1)
			if word == "COLD":
				mod = Color(0,1,1,1)
			if word == "HEAL":
				mod = Color(0,1,0,1)
			if word == "PROTECT":
				mod = Color(1,0.84,0,1)
			if word == "EARTH":
				mod = Color(0.55,0.27,0.07,1)
			if icon1.modulate == Color(1,1,1,1) and icon2.modulate == Color(1,1,1,1):
				icon1.modulate = mod
			elif icon1.modulate != Color(1,1,1,1) and icon2.modulate == Color(1,1,1,1):
				icon2.modulate = mod
			elif icon2.modulate != Color(1,1,1,1) and icon3.modulate == Color(1,1,1,1):
				icon3.modulate = mod
			if spell["FIRE"] > 0 and spell["WATER"] > 0:
				spell["FIRE"] -= 1
				spell["WATER"] -= 1
				summoned_elements -= 2
				if icon1.modulate == Color(1,0,0,1) or icon1.modulate == Color(0,0,1,1):
					icon1.modulate = Color(1,1,1,1)
				if icon2.modulate == Color(1,0,0,1) or icon2.modulate == Color(0,0,1,1):
					icon2.modulate = Color(1,1,1,1)
				if icon3.modulate == Color(1,0,0,1) or icon3.modulate == Color(0,0,1,1):
					icon3.modulate = Color(1,1,1,1)
			if spell["EARTH"] > 0 and spell["AIR"] > 0:
				spell["EARTH"] -= 1
				spell["AIR"] -= 1
				summoned_elements -= 2
				if icon1.modulate == Color(0.55,0.27,0.07,1) or icon1.modulate == Color(0.75,0.75,0.75,1):
					icon1.modulate = Color(1,1,1,1)
				if icon2.modulate == Color(0.55,0.27,0.07,1) or icon2.modulate == Color(0.75,0.75,0.75,1):
					icon2.modulate = Color(1,1,1,1)
				if icon3.modulate == Color(0.55,0.27,0.07,1) or icon3.modulate == Color(0.75,0.75,0.75,1):
					icon3.modulate = Color(1,1,1,1)
			emit_signal("summoned_element")
			emit_signal("update_spell", spell)
			spelllabel.text = ""
