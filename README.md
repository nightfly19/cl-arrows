# CL-Arrows

Implements the `->` and `->>` threading macros in Clojure, as well as `-<>` and `-<>>`
from the [swiss-arrows](https://github.com/rplevy/swiss-arrows) library.

This is an ASDF system providing the package `cl-arrows`.

## Documentation

[macro]  
`->` initial-form _&rest_ forms => results

Inserts INITIAL-FORM as first argument into the first of FORMS, the result into
the next, etc., before evaluation.  FORMS are treated as list designators.


[macro]  
`->>` initial-form _&rest_ forms => results

Like `->`, but the forms are inserted as last argument instead of first.

[macro]  
`-<>` initial-form _&rest_ forms => results

Like `->`, but if a form in FORMS has one or more symbols named `<>` as
top-level element, each such symbol is substituted by the primary result of the
form accumulated so far, instead of it being inserted as first argument.  Also
known as diamond wand.

[macro]  
`-<>>` initial-form _&rest_ forms => results

Like `-<>`, but if a form in FORMS has no symbols named `<>` as top-level element,
insertion is done like in `->>`.  Also known as diamond spear.

## Examples

    (-> 3
        /)  ; insert into designated list (/)
    => 1/3

    (-> 3
        (expt 2))  ; insert as first argument
    => 9
    
    (->> 3
         (expt 2))  ; insert as last argument
    => 8

    (-<>> (list 1 2 3)
          (remove-if #'oddp <> :count 1 :from-end t) ; substitute <>
          (reduce #'+)                               ; insert last
          /)                                         ; list designator
    => 1/3

    (let ((x 3))
      (-<> (incf x)     ; (let ((r (incf x)))
           (+ <> <>)))  ;   (+ r r))
    => 8

## Todo 

Future versions _might_ include further ideas from rplevy's
[swiss-arrows](https://github.com/rplevy/swiss-arrows).
