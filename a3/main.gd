extends Control


func _ready():
	if "--server" in OS.get_cmdline_args():
		get_tree().change_scene("res://Server.tscn")
	pass


func _on_Button_button_up():
	get_tree().change_scene("res://Server.tscn")
	pass # Replace with function body.


func _on_Button2_button_up():
	Auto.url=$Panel2/TextEdit.text
	get_tree().change_scene("res://Client.tscn")
	pass # Replace with function body.


func _on_Button3_button_up():
	$Panel.hide()
	pass # Replace with function body.


func _on_Button4_button_up():
	get_tree().change_scene("res://main.tscn")
	pass # Replace with function body.
