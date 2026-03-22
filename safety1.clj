(ns safety1
  (:refer-clojure :exclude [==])
  (:require [clojure.core.logic :refer [all == fresh membero project run* fail]]))


;; Define some worlds as data
(def worlds 
  [{:id :actual :p true  :believes-p true  :closeness 0}
   {:id :near1  :p true  :believes-p true  :closeness 1}
   {:id :near2  :p false :believes-p true  :closeness 1} ;; Uh oh, a lucky true belief!
   {:id :far1   :p false :believes-p false :closeness 10}])

;; Defining what a safe world looks like
(defn safe-worldo [world]
  (all
    (== (:believes-p world) true)
    (== (:p world) true)))

;; Running the query: Find all safe nearby worlds
(run* [q]
  (fresh [w]
    (membero w worlds)          ;; Pick a world from the list
    (project [w]                ;; Look inside the data
      (if (<= (:closeness w) 1) ;; Only look at 'nearby' worlds
        (all
          (safe-worldo w)       ;; Apply safety logic
          (== q (:id w)))       ;; If it passes, return the world ID
        fail))))                ;; If too far, this path fails
