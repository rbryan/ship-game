
(import 
	(srfi 69 basic-hash-tables) ;for hash-table->alist

  	(class java.net
	  ServerSocket
	  Socket)
	(class java.lang
	       Thread)
	(class java.io
	       BufferedReader
	       PrintWriter
	       InputStreamReader))

(define clients '())
(define world (make-hash-table))

(define (server)
  (let ((listener ::ServerSocket (ServerSocket 9001)))
    (let loop ((socket ::Socket (listener:accept)))
      (synchronized clients
	      (set! clients (append clients (list socket))))
      (loop (listener:accept)))))

(define (world->string world)
  (let ((world (hash-table->alist world))
        (output-string-port (open-output-string)))
    (write world output-string-port)
    (get-output-string output-string-port)))

(define (main)
  (let ((listener-thread (future (server))))
    (let main-loop  ((tick 0))
      (for-each (lambda (client ::Socket)
		  	(let ((world-string (world->string world))
			      (output-port ::PrintWriter (PrintWriter (client:getOutputStream)))
			      (input-port ::BufferedReader (BufferedReader (InputStreamReader (client:getInputStream)))))
			  (if (input-port:ready)
			    (begin
			      (display (input-port:readLine))
			      (newline)))
			  (output-port:println world-string)))
		clients)
      (sleep 0.5)
      (main-loop (+ 1 tick)))))

(main)
     
