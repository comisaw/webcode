extends Control

var _client=null

func _ready():
	$TextEdit2.text=Auto.url
	$RichTextLabel.text="SERVER:"+Auto.url+"\n"
	_client=WebSocketClient.new()
	_client.connect("connection_closed",self,"_connection_failed")
	_client.connect("connection_error",self,"_connection_failed")
	_client.connect("connection_established",self,"_connection_established")
	_client.connect("data_received",self,"_data_received")
	connect_server()
	pass

func connect_server():
	var err=_client.connect_to_url(Auto.url)
	if err!=OK:
		set_process(false)
	else:
		set_process(true)
	pass

func _process(delta):
	_client.poll()
	pass
	
func _exit_tree():
	_client.disconnect_from_host()

func _connection_failed(was_clean_close:bool):
	connect_server()
	pass
	
func _connection_established(protocol:String):
	_client.get_peer(1).put_var("一名玩家成功登录!")
	pass

func _data_received():
	var receiveData=_client.get_peer(1).get_var()
	$RichTextLabel.text+=receiveData+"\n"
	pass


func _on_Button_button_up():
	_client.get_peer(1).put_var($TextEdit.text)
	pass # Replace with function body.


func _on_Button2_button_up():
	Auto.url=$TextEdit2.text
	get_tree().change_scene("res://Client.tscn")
	pass # Replace with function body.
