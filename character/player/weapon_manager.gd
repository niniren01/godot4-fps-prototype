class_name WeaponManager
extends Node3D

@onready var weapons = $Weapons.get_children()

var weapons_unlocked = []
var cur_slot = 0
var cur_weapon = null 

func _ready() -> void:
	disable_all_weapons()
	for _i in range(weapons.size()):
		weapons_unlocked.append(true)

func disable_all_weapons():
	for weapon in weapons:
		if has_method("set_active"):
			weapon.set_active(false)
		else:
			weapon.hide()

func switch_to_previous_weapon():
	for i in range(weapons.size()):
		var wrapped_index = wrapi(cur_slot -1 -i, 0, weapons.size())
		if switch_to_weapon_slot(wrapped_index):
			break

func switch_to_next_weapon():
	for i in range(weapons.size()):
		var wrapped_index = wrapi(cur_slot +1 +i, 0, weapons.size())
		if switch_to_weapon_slot(wrapped_index):
			break

func switch_to_weapon_slot(slot_index: int) -> bool:
	if slot_index >= weapons.size() or slot_index < 0:
		return false
	if weapons_unlocked.size() == 0 or !weapons_unlocked[slot_index]:
		return false
	
	# success to switch
	disable_all_weapons()
	cur_slot = slot_index
	cur_weapon = weapons[cur_slot]
	if has_method("set_active"):
		cur_weapon.set_active(true)
	else:
		cur_weapon.show()
	return true

func test_weapon_attack():
	for weapon in weapons:
		weapon.get_node("Graphics/AnimationPlayer").play("attack")


func _on_timer_timeout() -> void:
	test_weapon_attack()
