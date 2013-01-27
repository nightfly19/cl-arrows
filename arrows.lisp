(in-package :cl-arrows)

(defmacro -> (initial-form &rest forms)
  (let ((output-form initial-form)
        (remaining-forms forms))
    (loop while remaining-forms do
         (let ((current-form (car remaining-forms)))
           (setf output-form (cons (car current-form) (cons output-form (cdr current-form)))))
         (setf remaining-forms (cdr remaining-forms)))
    output-form))

(defmacro ->> (initial-form &rest forms)
  (let ((output-form initial-form)
        (remaining-forms forms))
    (loop while remaining-forms do
         (let ((current-form (car remaining-forms)))
           (setf output-form (cons (car current-form)
                                   (append (cdr current-form) (list output-form)))))
         (setf remaining-forms (cdr remaining-forms)))
    output-form))

