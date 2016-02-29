(export client?
	make-client
	client-socket-set!
	client-socket)

(import (class java.net
	       Socket))

(define-record-type client
		    (make-client socket) 
		    client?
		    (socket client-socket client-socket-set!))
