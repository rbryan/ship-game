(define-syntax define-syntax-rule
  (lambda (x)
    (syntax-case x ()
		 ((_ (name . pattern) template)
		  #'(define-syntax name
		      (syntax-rules ()
				    ((_ . pattern) template))))
		 ((_ (name . pattern) docstring template)
		  (string? (syntax->datum #'docstring))
		  #'(define-syntax name
		      (syntax-rules ()
				    docstring
				    ((_ . pattern) template)))))))


(define-syntax do-times
  (syntax-rules () ((do-times var count rest ...)
    (let loop ((var 0))
      (if (< var count)
        (begin
	  rest ...
	  (loop (+ var 1)))
        #t)))))
