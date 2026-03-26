(setv worlds
  [{"id" "actual"      "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 0}
   {"id" "near1"       "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 1}
   {"id" "near2"       "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 1}
   {"id" "near3"       "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 1}
   {"id" "near-threat" "p" False "believes-p" True  "belief-form-same-as-actual" True  "closeness" 1} ;; The rare failure!
   {"id" "near-diff"   "p" False "believes-p" True  "belief-form-same-as-actual" False "closeness" 1} ;; Different method, ignore
   {"id" "far1"        "p" False "believes-p" False "belief-form-same-as-actual" False "closeness" 10}])

;; Find all nearby worlds where the belief is formed in the SAME WAY.
(setv relevant-nearby-worlds
  (list (gfor w worlds
              :if (<= (get w "closeness") 1)
              :if (get w "believes-p")
              :if (get w "belief-form-same-as-actual")
              w)))

;; Find the subset of those relevant worlds where the belief is TRUE (p is True)
(setv successful-worlds
  (list (gfor w relevant-nearby-worlds
              :if (get w "p")
              w)))

(setv n-relevant (len relevant-nearby-worlds))
(setv n-success (len successful-worlds))

;; Calculate the ratio of successful worlds out of all relevant nearby worlds
(setv success-ratio (if (> n-relevant 0) (/ n-success n-relevant) 1.0))

(print "Total relevant nearby worlds:" n-relevant)
(print "Successful worlds (where p is True):" n-success)
(print "Success ratio:" success-ratio)
(print "--------------------------------------------------")

;; Safety II: "most" nearby worlds (e.g., > 50%)
(setv safety-II-met? (> success-ratio 0.5))

;; Safety III: "nearly all (if not all)" nearby worlds (e.g., >= 95% or 100%)
;; For small finite models, "nearly all" is practically 1.0
(setv safety-III-met? (>= success-ratio 1.0))

(print "Safety II (ratio > 0.5) met?  :" safety-II-met?)
(print "Safety III (ratio >= 1.0) met?:" safety-III-met?)
