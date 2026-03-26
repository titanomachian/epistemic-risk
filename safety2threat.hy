(setv worlds
  [{"id" "actual" "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 0}
   {"id" "near1"  "p" True  "believes-p" True  "belief-form-same-as-actual" True  "closeness" 1}
   {"id" "near2"  "p" False "believes-p" True  "belief-form-same-as-actual" False "closeness" 1} ;; Uh oh, a lucky true belief!
   {"id" "far1"   "p" False "believes-p" False "belief-form-same-as-actual" False "closeness" 10}])

(defn threatens-safety? [world]
  ;; A world threatens the safety of our actual belief IF:
  ;; 1. It is a nearby world
  ;; 2. The agent forms the belief
  ;; 3. The agent forms the belief IN THE SAME WAY as the actual world
  ;; 4. But the belief turns out to be FALSE (p is False)
  (and (<= (get world "closeness") 1)
       (= (get world "believes-p") True)
       (= (get world "belief-form-same-as-actual") True)
       (= (get world "p") False)))

(setv unsafe-nearby-worlds
  (list
    (gfor w worlds
          :if (threatens-safety? w)
          (get w "id"))))

;; The actual belief is safe if there are NO nearby worlds that threaten it.
(setv actual-belief-safe? (= (len unsafe-nearby-worlds) 0))

(print "Unsafe nearby worlds that threaten actual belief:" unsafe-nearby-worlds)
(print "Is the actual belief safe?:" actual-belief-safe?)
