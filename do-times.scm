(define-syntax do-times
  (syntax-rules () ((do-times var count rest ...)
    (let loop ((var 0))
      (if (< var count)
        (begin
	  rest ...
	  (loop (+ var 1)))
        #t)))))
