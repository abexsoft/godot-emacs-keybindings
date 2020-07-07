tool
extends EditorPlugin

enum {GLOBAL_MODE, CONTROL_X_MODE, CONTROL_C_MODE, ESC_MODE}


var cur_key_mode = KeyMode.new()
var cur_map
var maps

var recursive_input_stopper = false

var base
var script_editor
var tab_container

class EmacsFunction extends EditorPlugin:
	var base
	
	func _init():
		base = get_editor_interface().get_base_control()
		
	func previous_line(event, key_mode):
		if key_mode.selection_active:
			event.shift = true			
			event.control = false
			event.alt = false
			event.scancode = KEY_DOWN
			event.pressed = true
		else:
			event.control = false
			event.alt = false
			event.scancode = KEY_DOWN
			event.pressed = true
		return key_mode
		
	func next_line(event, key_mode):
		if key_mode.selection_active:
			event.control = false
			event.shift = true
			event.alt = false			
			event.scancode = KEY_UP
			event.pressed = true
		else:
			event.control = false
			event.alt = false			
			event.scancode = KEY_UP
			event.pressed = true
		return key_mode
		
	func backward_char(event, key_mode):
		if key_mode.selection_active:
			event.control = false
			event.shift = true
			event.alt = false			
			event.scancode = KEY_LEFT
			event.pressed = true
		else:
			event.control = false
			event.alt = false			
			event.scancode = KEY_LEFT
			event.pressed = true
		return key_mode
		
	func forward_char(event, key_mode):
		if key_mode.selection_active:
			event.control = false
			event.shift = true
			event.alt = false			
			event.scancode = KEY_RIGHT
			event.pressed = true
		else:
			event.control = false
			event.alt = false			
			event.scancode = KEY_RIGHT
			event.pressed = true
		return key_mode

	func scroll_down_command(event, key_mode):
		if key_mode.selection_active:
			event.control = false
			event.shift = true
			event.alt = false			
			event.scancode = KEY_PAGEUP
			event.pressed = true
		else:
			event.control = false
			event.alt = false			
			event.scancode = KEY_PAGEUP
			event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode
		
	func scroll_up_command(event, key_mode):
		if key_mode.selection_active:
			event.control = false
			event.shift = true
			event.alt = false			
			event.scancode = KEY_PAGEDOWN
			event.pressed = true
		else:
			event.control = false
			event.alt = false			
			event.scancode = KEY_PAGEDOWN
			event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode
	
	func recenter_top_bottom(event, key_mode):
		event.pressed =false
		var editor = base.get_focus_owner()
		editor.center_viewport_to_cursor()
		return key_mode

	func cancel(event, key_mode):
		event.scancode = KEY_ESCAPE
		key_mode.mode = GLOBAL_MODE
		key_mode.selection_active = false
		var editor = base.get_focus_owner()
		editor.deselect()
		return key_mode
		
	func delete_backward_char(event, key_mode):
		event.control = false
		event.alt = false		
		event.scancode = KEY_BACKSPACE
		event.pressed = true
		return key_mode
		
	func delete_char(event, key_mode):
		event.control = false
		event.alt = false				
		event.scancode = KEY_DELETE
		event.pressed = true
		return key_mode
		
	func tab(event, key_mode):
		event.control = false
		event.alt = false				
		event.scancode = KEY_TAB
		event.pressed = true
		return key_mode
		
	func enter(event, key_mode):
		event.control = false
		event.alt = false				
		event.scancode = KEY_ENTER
		event.pressed = true
		return key_mode
		
	func comment(event, key_mode):
		event.control = true
		event.alt = false				
		event.scancode = KEY_K
		event.pressed = true
		return key_mode
		
	func move_begginning_of_line(event, key_mode):
		if key_mode.selection_active:
			#var editor = base.get_focus_owner()		
			#editor.cursor_set_column(0, false)
			#event.pressed = false
			event.shift = true
			event.control = false
			event.alt = false							
			event.scancode = KEY_HOME
			event.pressed = true
		else:
			#var editor = base.get_focus_owner()		
			#editor.cursor_set_column(0, false)
			#event.pressed = false
			event.shift = false			
			event.control = false
			event.alt = false			
			event.scancode = KEY_HOME
			event.pressed = true
		return key_mode
		
	func move_end_of_line(event, key_mode):
		if key_mode.selection_active:
			event.shift = true			
			event.control = false
			event.alt = false			
			event.scancode = KEY_END
			event.pressed = true
		else:
			event.control = false
			event.alt = false					
			event.scancode = KEY_END
			event.pressed = true
		return key_mode
		
	func kill_line(event, key_mode):
		event.pressed = false
		var new_event = InputEventKey.new()
		new_event.shift = true
		new_event.alt = false				
		new_event.scancode = KEY_END
		new_event.pressed = true
		Input.parse_input_event(new_event)
		new_event = InputEventKey.new()
		new_event.control = true
		new_event.alt = false				
		new_event.scancode = KEY_X
		new_event.pressed = true
		Input.parse_input_event(new_event)
		return key_mode
		
	func kill_region(event, key_mode):
		event.pressed = false
		var editor = base.get_focus_owner()
		editor.cut()
		key_mode.selection_active = false
		key_mode.mode = GLOBAL_MODE
		return key_mode
		
	func yank(event, key_mode):
		event.pressed = false
		var editor = base.get_focus_owner()
		editor.paste()
		return key_mode
		
	func set_mark_command(event, key_mode):
		event.pressed = false
		key_mode.selection_active = true
		return key_mode

	func undo(event, key_mode):
		event.pressed = false
		var editor = base.get_focus_owner()
		editor.undo()
		key_mode.mode = GLOBAL_MODE
		return key_mode

	func search(event, key_mode):
		event.control = true
		event.alt = false
		event.scancode = KEY_F
		return key_mode

	func save_buffer(event, key_mode):
		event.shift = false
		event.control = true
		event.alt = true
		event.scancode = KEY_S
		event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode
		
	func save_some_buffers(event, key_mode):
		event.shift = true
		event.control = false
		event.alt = true
		event.scancode = KEY_S
		event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode

	func kill_ring_save(event, key_mode):
		event.pressed = false
		var editor = base.get_focus_owner()
		editor.copy()
		editor.deselect()
		key_mode.mode = GLOBAL_MODE
		key_mode.selection_active = false
		return key_mode

	func beginning_of_buffer(event, key_mode):
		event.control = true
		event.shift = false
		event.alt = false						
		event.scancode = KEY_HOME
		event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode

	func mark_whole_buffer(event, key_mode):
		event.shift = false
		event.control = true
		event.alt = false						
		event.scancode = KEY_A
		event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode

	func end_of_buffer(event, key_mode):
		event.shift = false
		event.control = true
		event.alt = false				
		event.scancode = KEY_END
		event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode

	func goto(event, key_mode):
		event.shift = false
		event.control = true
		event.alt = false		
		event.scancode = KEY_L
		event.pressed = true
		key_mode.mode = GLOBAL_MODE
		return key_mode
		
	func escape_prefix(event, key_mode):
		event.control = false
		event.shift = false
		event.alt = false
		event.pressed = false
		key_mode.mode = ESC_MODE
		return key_mode

	func ctrl_x_prefix(event, key_mode):
		event.control = false
		event.shift = false
		event.alt = false	
		event.pressed = false
		key_mode.mode = CONTROL_X_MODE
		return key_mode
		
	func ctrl_c_prefix(event, key_mode):
		event.control = false
		event.shift = false
		event.alt = false				
		event.pressed = false
		key_mode.mode = CONTROL_C_MODE
		return key_mode

class KeyMode:
	var mode setget set_mode, get_mode
	var selection_active setget  set_selection_active, get_selection_active
	var status_bar 
	
	func _init():
		mode = GLOBAL_MODE
		selection_active = false
		
	func set_mode(a_mode):
		mode = a_mode
		
	func get_mode():
		return mode
		
	func set_selection_active(a_bool):
		selection_active = a_bool
		
	func get_selection_active():
		return selection_active

class KeyMap:
	var emacs_func

	func _init():
		emacs_func = EmacsFunction.new()
		
	func check_key_event(event, shift, control, alt, scancode):
		if event.shift == shift and event.control == control:
			if event.alt == alt and event.scancode == scancode:
				return true
		return false

	func check_key_event_unicode(event, shift, control, alt, unicode):
		if event.shift == shift and event.control == control:
			if event.alt == alt and event.unicode == unicode:
				return true
		return false

class GlobalMap extends KeyMap:
	var mode setget ,get_mode

	func _init():
		mode = GLOBAL_MODE
		
	func get_mode():
		return mode
	
	func input(event, key_mode):
		#print("Global" + str(event.scancode))
		#print("Global" + str(event.unicode))

		key_mode.status_bar.text = ""
		
		if check_key_event(event, false, true, false, KEY_G):
			key_mode = emacs_func.cancel(event, key_mode)
			key_mode.status_bar.text = "Quit"
		elif check_key_event(event, false, true, false, KEY_N):
			key_mode = emacs_func.previous_line(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_P):
			key_mode = emacs_func.next_line(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_B):
			key_mode = emacs_func.backward_char(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_F):
			key_mode = emacs_func.forward_char(event, key_mode)
		elif check_key_event(event, false, false, true, KEY_V):
			key_mode = emacs_func.scroll_down_command(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_V):
			key_mode = emacs_func.scroll_up_command(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_L):
			key_mode = emacs_func.recenter_top_bottom(event, key_mode)
		elif check_key_event(event, false, false, true, KEY_W):
			key_mode = emacs_func.kill_ring_save(event, key_mode)
		elif check_key_event(event, false, false, true, KEY_G):
			key_mode = emacs_func.goto(event, key_mode)
		elif check_key_event_unicode(event, true, false, true, KEY_LESS):
			key_mode = emacs_func.beginning_of_buffer(event, key_mode)
		elif check_key_event_unicode(event, true, false, true, KEY_GREATER):
			key_mode = emacs_func.end_of_buffer(event, key_mode)			
		elif check_key_event(event, false, true, false, KEY_H):
			key_mode = emacs_func.delete_backward_char(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_D):
			key_mode = emacs_func.delete_char(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_I):
			key_mode = emacs_func.tab(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_J):
			key_mode = emacs_func.enter(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_M):
			key_mode = emacs_func.enter(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_SEMICOLON):
			key_mode = emacs_func.comment(event, key_mode)			
		elif check_key_event(event, false, true, false, KEY_A):
			key_mode = emacs_func.move_begginning_of_line(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_E):
			key_mode = emacs_func.move_end_of_line(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_K):
			key_mode = emacs_func.kill_line(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_W):
			key_mode = emacs_func.kill_region(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_Y):
			key_mode = emacs_func.yank(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_SPACE):
			key_mode = emacs_func.set_mark_command(event, key_mode)
		elif check_key_event_unicode(event, true, true, false, KEY_UNDERSCORE):
			key_mode = emacs_func.undo(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_SLASH):
			key_mode = emacs_func.undo(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_S):
			key_mode = emacs_func.search(event, key_mode)
		elif check_key_event(event, false, false, false, KEY_ESCAPE):
			key_mode = emacs_func.escape_prefix(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_X):
			key_mode = emacs_func.ctrl_x_prefix(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_C):
			key_mode = emacs_func.ctrl_c_prefix(event, key_mode)
		else:
			key_mode.mode = GLOBAL_MODE
			key_mode.selection_active = false
		return key_mode
		
class EscMap  extends KeyMap:
	var mode setget , get_mode
	
	func _init():
		mode = ESC_MODE
		
	func get_mode():
		return mode
	
	func input(event, key_mode):
		#print("Esc" + str(event.unicode))

		if check_key_event(event, false, true, false, KEY_G):
			key_mode = emacs_func.cancel(event, key_mode)
		elif check_key_event(event, false, false, false, KEY_W):
			key_mode = emacs_func.kill_ring_save(event, key_mode)
		elif check_key_event(event, false, false, false, KEY_V):
			key_mode = emacs_func.scroll_down_command(event, key_mode)			
		elif check_key_event(event, false, false, false, KEY_G):
			key_mode = emacs_func.goto(event, key_mode)
		elif check_key_event_unicode(event, true, false, false, KEY_LESS):
			key_mode = emacs_func.beginning_of_buffer(event, key_mode)
		elif check_key_event_unicode(event, true, false, false, KEY_GREATER):
			key_mode = emacs_func.end_of_buffer(event, key_mode)
		else:
			key_mode.status_bar.text = "ESC-" + char(event.unicode) + " is undefined."
			event.pressed = false
			key_mode.mode = GLOBAL_MODE
			key_mode.selection_active = false
			
		return key_mode

class ControlXMap extends KeyMap:
	var mode setget , get_mode
	
	func _init():
		mode = CONTROL_X_MODE

	func get_mode():
		return mode

	func input(event, key_mode):
		#print("CtrlX" + str(event.unicode))

		if check_key_event(event, false, true, false, KEY_G):
			key_mode = emacs_func.cancel(event, key_mode)
		elif check_key_event(event, false, true, false, KEY_S):
			key_mode = emacs_func.save_buffer(event, key_mode)
		elif check_key_event(event, false, false, false, KEY_S):
			key_mode = emacs_func.save_some_buffers(event, key_mode)
		elif check_key_event(event, false, false, false, KEY_H):
			key_mode = emacs_func.mark_whole_buffer(event, key_mode)
		elif check_key_event(event, false, false, false, KEY_U):
			key_mode = emacs_func.undo(event, key_mode)
		else:
			key_mode.status_bar.text = "C-x-" + char(event.unicode) + " is undefined."
			event.pressed = false
			key_mode.mode = GLOBAL_MODE
			key_mode.selection_active = false
			
		return key_mode

class ControlCMap extends KeyMap:
	var mode setget , get_mode
	
	func _init():
		mode = CONTROL_C_MODE

	func get_mode():
		return mode

	func input(event, key_mode):
		#print("CtrlC" + str(event.unicode))
		key_mode.mode = GLOBAL_MODE
		key_mode.selection_active = false
			
		return key_mode
		
func _enter_tree():
	pass
	
func _exit_tree():
	free_status_bar()

func _ready():
	base = get_editor_interface().get_base_control()
	script_editor = get_editor_interface().get_script_editor()
	var main = script_editor.get_child(0)
	var script_split = main.get_child(1)
	tab_container = script_split.get_child(1)
	tab_container.connect("tab_changed", self, "tab_changed")
	set_status_bar()
	var global_map = GlobalMap.new()
	var esc_map = EscMap.new()
	var ctrlx_map = ControlXMap.new()
	var ctrlc_map = ControlCMap.new()
	maps = [global_map, esc_map, ctrlx_map, ctrlc_map]
	cur_map = global_map	


func set_status_bar():
	free_status_bar()
	cur_key_mode.status_bar = Label.new()
	cur_key_mode.status_bar.text = ""	
	var se = tab_container.get_current_tab_control()
	if se != null:
		se.add_child(cur_key_mode.status_bar)



# It's difficult to add into editor's status_bar, 
# because there are differences between editor's types.
#	var editor_box = se.get_child(0)
#	var code_editor = editor_box.get_child(0)
#	var status_bar = code_editor.get_child(2)

func free_status_bar():
	if cur_key_mode.status_bar != null:
		cur_key_mode.status_bar.free()

func tab_changed(id):
	set_status_bar()

	
func set_cur_map(next_key_mode):
	if cur_map.mode != next_key_mode.mode:
		for map in maps:
			if map.mode == next_key_mode.mode:
				cur_map = map
				match cur_map.mode:
					GLOBAL_MODE:
						pass
					ESC_MODE:
						cur_key_mode.status_bar.text = "ESC-"
					CONTROL_X_MODE:
						cur_key_mode.status_bar.text = "C-x-"
					CONTROL_C_MODE:
						cur_key_mode.status_bar.text = "C-c-"

func is_focus_text_editor():
	var owner = base.get_focus_owner()
	if owner is TextEdit:
		return true
	else:
		return false

func _input(event):
	if !is_focus_text_editor():
		return
	if recursive_input_stopper:
		return
	if !(event is InputEventKey) or !event.pressed:
		return
	if event.scancode == KEY_CONTROL or event.scancode == KEY_SHIFT or event.scancode == KEY_ALT:
		return
				
#	set_mode_label()
	recursive_input_stopper = true
	cur_key_mode = cur_map.input(event, cur_key_mode)
	set_cur_map(cur_key_mode)
	recursive_input_stopper = false
