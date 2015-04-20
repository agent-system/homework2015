#|
#ifndef TCSANOW
#define TCSANOW TCSETA
#endif
#ifndef TCSADRAIN
#define TCSADRAIN TCSETAW
#endif
#ifndef TCSAFLUSH
#define TCSAFLUSH TCSETAF
#endif
|#

;; copy from jsk/sericom.l
(defcstruct termios
  (c_iflag      :integer)
  (c_oflag      :integer)
  (c_cflag      :integer)
  (c_lflag      :integer)
  (c_line       :char)
  (c_cc         :char 18)
  (c_ispeed     :integer)
  (c_ospeed     :integer))

(defconstant TCSANOW 0)
(defconstant TCSADRAIN 1)
(defconstant TCSAFLUSH 2)
(defconstant ICANON	#0x0002)
(defun kbhit nil
  (let ((attr-orig (unix::tcgetattr 0))
        (buf "0")
        attr ret)
    (setq attr (copy-list attr-orig))
    ;; 1000 1010 0011 1011
    (setf (termios-c_lflag attr) (logand (termios-c_lflag attr) (lognot ICANON)))
    (unix::tcsetattr 0 TCSANOW attr)
    (when (= (unix::select-read-fd 1 0.0) 1)
      (unix::uread 0 buf 1)
      (setq ret (elt buf 0)))
    (unix::tcsetattr 0 TCSANOW attr-orig)
    ret))
(format t ";; (kbhit)")
#|
(dotimes (i 10)
  (setq c (kbhit))
  (if c (format t "~c(~d)~%" c c))
  (unix::sleep 1))
|#

(provide :kbhit)
