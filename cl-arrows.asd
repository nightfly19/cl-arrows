(asdf:defsystem #:cl-arrows
  :name "cl-arrows"
  :version "0.0.1"
  :author "Sage Imel"
  :description "Implements the -> and ->> from clojure, and -<> and -<>> from swiss-arrows."
  :serial t
  :components ((:file "packages")
               (:file "arrows"))
  :in-order-to ((asdf:test-op (asdf:test-op #:cl-arrows-test))))

(asdf:defsystem #:cl-arrows-test
  :depends-on (#:cl-arrows #:hu.dwim.stefil)
  :serial t
  :components ((:file "test"))
  :perform (asdf:test-op (c v) (uiop:symbol-call '#:cl-arrows-test
                                                 '#:test-cl-arrows)))
