;; -*- lisp -*-

;; This file is part of cl-parametric-types.
;; Copyright (c) 2016 Massimiliano Ghilardi
;;
;; This library is free software: you can redistribute it and/or
;; modify it under the terms of the Lisp Lesser General Public License
;; (http://opensource.franz.com/preamble.html), known as the LLGPL.
;;
;; This library is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty
;; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the Lisp Lesser General Public License for more details.

#|

EVAL and EVAL!

|#


(in-package :cl-parametric-types.lang)

(defun eval-in-env (form &optional env)
  "evaluate FORM with optional environment ENV."
  (let ((form `(let ((*compile-verbose* ,*compile-verbose*)) ,form)))
    (unless env
      (return-from eval-in-env (eval (macroexpand form))))
    #+clisp (ext:eval-env form env)
    #+cmucl (eval:internal-eval form t env)
    #+sbcl  (sb-eval:eval-in-environment form env)
    #-(or clisp cmucl sbcl)
    (eval (macroexpand form env))))

(defmacro eval! (form &environment env)
  "evaluate FORM at compile time."
  (eval-in-env form env))
