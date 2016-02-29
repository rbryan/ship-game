
(import (class java.net
	  ServerSocket
	  Socket))

(define clients '())

(define (server)
  (let ((listener ::ServerSocket (ServerSocket 9001)))
    (let loop ((socket ::Socket (listener:accept)))
      (synchronized clients
	      (set! clients (append clients (list socket))))
      (loop (listener:accept)))))

(define (main)
  (let ((listener-thread (future (server))))
    (let main-loop  ((tick 0))
      (display tick)
      (newline)
      (synchronized clients
	      (display clients))
      (newline)
      (sleep 0.5)
      (main-loop (+ 1 tick)))))

(main)
     
