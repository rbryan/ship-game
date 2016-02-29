(export client?
	make-client
	client-socket-set!
	client-socket)

(define-record-type client
		    (make-client socket) 
		    client?
		    (socket client-socket client-socket-set!))
