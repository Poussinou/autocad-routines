; NEED TO PUT IN ERROR HANDELS!!
(defun c:annotatelines ()
    (vl-load-com)
    (setq ol (getvar "clayer"))
    (setq oc (getvar "cmdecho"))
    (setq os (getvar "osmode"))
    (setvar "clayer" tol)
    (setvar "cmdecho" 0)
    (initget "Points Lines")
    (setq OPT (getkword "Annotate based on points or lines? "))
    (if (= OPT "Points")
        (progn
            (setq p1 (getpoint "Pick first point: ")
                  p2 (getpoint "\nPick second point: " p1)
                  a1 (vl-string-subst "%%d" "d" (angtos (angle p1 p2) 4 4))
                  d  (strcat (rtos (distance p1 p2) 2 2) "'")
                  x1 (car p1)
                  y1 (cadr p1)
                  x2 (car p2)
                  y2 (cadr p2)
                  m  (list (/ (+ x1 x2) 2) (/ (+ y1 y2) 2))
            )
            (if (and (> (angle p1 p2) 1.5707963268) (< (angle p1 p2) 4.7123889804))
                (setq a2 (angtos (- (angle p1 p2) pi) 4 6))
                (setq a2 (angtos (angle p1 p2) 4 6))
            )
            (setvar "osmode" 0)
            (command "_.text" "s" ltsty "bc" m lts a2 a1 "_.text" "" d)
            (setvar "osmode" os)
            (setq p3 (getpoint p2 "\nPick next point: "))
            (while p3
                (setq a1 (vl-string-subst "%%d" "d" (angtos (angle p2 p3) 4 4))
                      a2 (angtos (angle p2 p3) 4 6)
                      d  (strcat (rtos (distance p2 p3) 2 2) "'")
                      x1 (car p2)
                      y1 (cadr p2)
                      x2 (car p3)
                      y2 (cadr p3)
                      m  (list (/ (+ x1 x2) 2) (/ (+ y1 y2) 2))
                      s  (getvar "textsize")
                )
                (if (and (> (angle p2 p3) 1.5707963268) (< (angle p2 p3) 4.7123889804))
                    (setq a2 (angtos (- (angle p2 p3) pi) 4 6))
                    (setq a2 (angtos (angle p2 p3) 4 6))
                )
                (setvar "osmode" 0)
                (command "_.text" "bc" m s a2 a1 "_.text" "" d)
                (setvar "osmode" os)
                (setq p2 p3
                      p3 (getpoint p2 "\nPick next point: ")
                )
            )
           )
       (princ)
       )
        (progn
            (while (setq LN (car (entsel "\nPick line to annotate: "))
                         P1 (cdr (assoc 10 (entget LN)))
                         P2 (cdr (assoc 11 (entget LN)))
                         a1 (vl-string-subst "%%d" "d" (angtos (angle p1 p2) 4 4))
                         d  (strcat (rtos (distance p1 p2) 2 2) "'")
                         x1 (car p1)
                         y1 (cadr p1)
                         x2 (car p2)
                         y2 (cadr p2)
                         m  (list (/ (+ x1 x2) 2) (/ (+ y1 y2) 2))
                   )
                (if (and (> (angle p1 p2) 1.5707963268) (< (angle p1 p2) 4.7123889804))
                    (setq a2 (angtos (- (angle p1 p2) pi) 4 6))
                    (setq a2 (angtos (angle p1 p2) 4 6))
                )
                (setvar "osmode" 0)
                (command "_.text" "bc" m lts a2 a1 "_.text" "" d)
                (setvar "osmode" os)
            )
        )       
    (setvar "clayer" ol)
    (setvar "cmdecho" oc)
    (princ)
)