(import

  (misc)

  (class javax.media.opengl
    GLAutoDrawable
    GL
    GL2
    GLProfile
    GLCapabilities
    GLEventListener)
  (class javax.media.opengl.glu
    GLU)
  (class com.jogamp.opengl.util
    FPSAnimator)
  (class javax.media.opengl.awt
    GLCanvas))


(define (rotMat ix1 ix2 rad)
  (let ((s (sin rad)) 
	(c (cos rad))
	(v (make-vector 9 0)))
    (vector-set! v (* 4 ix1) c)
    (vector-set! v (* 4 ix2) c)
    (vector-set! v (+ (* 3 ix1) ix2) s)
    (vector-set! v (+ (* 3 ix2) ix1) (- s))
    (vector-set! v (* 4 (- 3 ix1 ix2)) 1)
    v))

(define (drawShip gl ::GL2 pos orientation)
  (begin
    (define vr vector-ref)
    (define (mult vec mat . others)
      (let ((passMe
        (vector
	  (+ (* (vr vec 0) (vr mat 0))
	     (* (vr vec 1) (vr mat 1))
	     (* (vr vec 2) (vr mat 2)))
	  (+ (* (vr vec 0) (vr mat 3))
	     (* (vr vec 1) (vr mat 4))
	     (* (vr vec 2) (vr mat 5)))
	  (+ (* (vr vec 0) (vr mat 6))
	     (* (vr vec 1) (vr mat 7))
	     (* (vr vec 2) (vr mat 8))))))
        (if (null? others) passMe
	  (mult passMe @others))))
    (define (transform p)
      (map + pos (mult p
	(rotMat 0 1 (vr orientation 2))
	(rotMat 2 1 (vr orientation 1))
        (rotMat 0 2 (vr orientation 0)))))
    (gl:glBegin GL:GL_TRIANGLES)
    (gl:glColor3f 1.0 0 0)
    (map (lambda (a) (gl:glVertex3f @(transform a)))
      '(
        ;coordinates for the model
        #(0.5 0 0)
	#(-0.5 0 0)
	#(0 0 1)

	#(0 0 0)
	#(0 0.5 0)
	#(0 0 1)
      ))
    (gl:glEnd)
    ))

(define glp (GLProfile:getDefault))
(define glcap (GLCapabilities glp))
(define glcan ::GLCanvas (GLCanvas glcap))
(define frame ::java.awt.Frame (java.awt.Frame "Banana"))
(define glu ::GLU (GLU))
(define ship '((4 0 0) #(0.5 0 0)))
(frame:setSize 500 500)
(frame:add glcan)
(frame:setVisible #t)
(define-class myclass (GLEventListener)
  ((init d ::GLAutoDrawable) ::void ())
  ((dispose d ::GLAutoDrawable) ::void ())
  ((reshape d ::GLAutoDrawable a ::int b ::int c ::int d ::int) ::void ())
  ((display d ::GLAutoDrawable) ::void
  	(define gl ::GL2 ((d:getGL):getGL2))
	(gl:glMatrixMode gl:GL_PROJECTION)
	(gl:glLoadIdentity)
	(glu:gluPerspective 45 1 1 3)
	(gl:glMatrixMode gl:GL_MODELVIEW)
	(gl:glClear (bitwise-ior GL:GL_COLOR_BUFFER_BIT GL:GL_DEPTH_BUFFER_BIT))
	;(drawShip gl (car ship) (cadr ship))
	(gl:glBegin GL:GL_TRIANGLES)
	(gl:glColor3f 1 0 0)
	(gl:glVertex3f 0 0.5 2)
	(gl:glVertex3f 0 -0.5 2)
	(gl:glVertex3f 0.5 0 2)
	(gl:glEnd)
	))
(glcan:addGLEventListener (myclass))
((FPSAnimator glcan 30):start)
