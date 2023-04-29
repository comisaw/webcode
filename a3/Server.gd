extends Control

var _server=null
var connect_ids=[]

func _ready():
	_server=WebSocketServer.new()
	_server.connect("client_close_request",self,"_client_close_request")
	_server.connect("client_connected",self,"_client_connected")
	_server.connect("client_disconnected",self,"_client_disconnected")
	_server.connect("data_received",self,"_data_received")
	
	var err=_server.listen(20033)
	if err!=OK:
		set_process(false)
	pass

func _process(delta):
	_server.poll()
	pass
	
func _exit_tree():
	_server.stop()
	pass

func removeConnestId(id):
	if connect_ids.find(id)!=-1:
		connect_ids.remove(connect_ids.find(id))
	pass

func _client_close_request(id:int,code:int,reason:String):
	removeConnestId(id)
	pass
	
func _client_connected(id:int,protocol:String):
	print(id)
	connect_ids.append(id)
	pass
	
func _client_disconnected(id:int,was_clean_close:bool):
	removeConnestId(id)
	pass

func _data_received(id:int):
	var receiveData=_server.get_peer(id).get_var()
	print(id,receiveData)
	for cid in connect_ids:
		_server.get_peer(cid).put_var(receiveData)
	pass
