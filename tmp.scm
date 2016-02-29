(import
  (class javax.media.opengl
    GLAutoDrawable
    GL
    GL2
    GLProfile
    GLCapabilities
    GLEventListener)
  (class javax.media.opengl.glu
    GLU)
  (class javax.media.opengl.awt
    GLCanvas))
(load "misc.scm")

(define (rotMat ix1 ix2 rad)
  (let ((s (sin rad)) (c (cos rad)))
    (define v (make-vector 9))
    (do-times i 9 (vector-set! v i 0))
    (vector-set! v (* 4 ix1) c)
    (vector-set! v (* 4 ix2) c)
    (vector-set! v (+ (* 3 ix1) ix2) s)
    (vector-set! v (+ (* 3 ix2) ix1) (- s))
    (vector-set! v (* 4 (- 3 ix1 ix2)) 1)
    v))

(define (drawShip gl ::GL2 pos orientation)
  (begin
    (gl:glBegin GL:GL_TRIANGLES)
    (gl:glColor3f 1.0 0 0)))

(define glp (GLProfile:getDefault))
(define glcap (GLCapabilities glp))
(define glcan ::GLCanvas (GLCanvas glcap))
(define frame ::java.awt.Frame (java.awt.Frame "Banana"))
(define glu ::GLU (GLU))
(frame:setSize 500 500)
(frame:add glcan)
(frame:setVisible #t)
(define-class myclass (GLEventListener)
  ((init d ::GLAutoDrawable) ::void ())
  ((dispose d ::GLAutoDrawable) ::void ())
  ((reshape d ::GLAutoDrawable a ::int b ::int c ::int d ::int) ::void ())
  ((display d ::GLAutoDrawable) ::void
  	(define gl ::GL2 ((d:getGL):getGL2))
	(glu:gluPerspective 90 1 1 100)
	(gl:glClear GL:GL_COLOR_BUFFER_BIT)))
(glcan:addGLEventListener (myclass))
(sleep 2)
(frame:dispose)
