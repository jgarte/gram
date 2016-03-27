(use-modules (ggspec lib)
             (gram lib render)
             (gram support test-setup))

;;; testing these two even though they are private because the
;;; behavior is slightly more complex.
;;;
;;; they may be moved to a different location and made public in the
;;; future if I find use for them in different modules.

(define remove-keys (@@ (gram lib render) remove-keys))

(suite "remove-keys"
       ("should remove all keywords from the input"
        (assert-false (> 0 (length (remove-keys '(#:a #:b))))))
       ("should remove all key/value pairs from the input"
        (assert-false (> 0 (length (remove-keys '(#:a 1 #:b 2))))))
       ("should not remove any value that is not a keyword and not paired with a keyword"
        (assert-equal '(2 3 4 5) (remove-keys '(#:a 1 2 3 #:b 2 4 5 #:c)))))

(define flatten-once (@@ (gram lib render) flatten-once))

(suite "flatten-once"
       ("should flatten a list by exactly one level"
        (assert-equal '(a (b (c d)) e f g) (flatten-once '(a ((b (c d)) e f) g)))))

;; (define (assert-map-all ls assertion)
;;   (apply assert-all (map assertion ls)))

;; (suite "make-renderable"
;;        ("should return an rview given a view"
;;         (let ((rv (make-renderable 'test-view 'out
;;                                    '(0 . 0) '(100 . 100))))
;;           (assert-all
;;            (assert-true (rview? rv))
;;            (assert-equal (rview-view rv) 'test-view)
;;            (assert-equal (rview-output rv) 'out))))
;;        ("should return a list of rviews given a layout procedure"
;;         (let ((rvs (make-renderable (lambda (dims out)
;;                                       (list
;;                                        (make-rview 'a out '(0 . 0) '(100 . 100))
;;                                        (make-rview 'b out '(100 . 0) '(100 . 100))))
;;                                     'out '(10 . 10) '(100 . 100))))
;;           (assert-map-all rvs rview?))))
