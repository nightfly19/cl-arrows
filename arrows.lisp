(in-package :cl-arrows)

(defun simple-inserter (insert-fun)
  (lambda (acc next)
    (if (listp next)
        (funcall insert-fun acc next)
        (list next acc))))

(defmacro -> (initial-form &rest forms)
  (reduce (simple-inserter #'insert-first)
          forms
          :initial-value initial-form))

(defmacro ->> (initial-form &rest forms)
  (reduce (simple-inserter #'insert-last)
          forms
          :initial-value initial-form))

(defun diamond-inserter (insert-fun)
  (simple-inserter (lambda (acc next)
                     (if (find-if #'<>p next)
                         (substitute-if acc #'<>p next)
                         (funcall insert-fun acc next)))))

(defmacro -<> (initial-form &rest forms)
  (reduce (diamond-inserter #'insert-first)
          forms
          :initial-value initial-form))

(defmacro -<>> (initial-form &rest forms)
  (reduce (diamond-inserter #'insert-last)
          forms
          :initial-value initial-form))

(defun <>p (form)
  (and (symbolp form)
       (string= form "<>")))

(defun insert-first (arg surround)
  (cons (car surround)
        (append arg (cdr surround))))

(defun insert-last (arg surround)
  (cons (car surround)
        (append (cdr surround) arg)))
