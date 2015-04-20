#!/usr/bin/env roseus
;; listener.l
;; Author: Yuki Furuta <furushchev@jsk.imi.i.u-tokyo.ac.jp>

(ros::roseus "listener")

(ros::roseus-add-msgs "std_msgs")

(defun callback (msg)
  (print (send msg :data)))

(ros::rate 1)
(ros::subscribe "chatter" std_msgs::String #'callback)

(ros::spin)

#|
(do-until-key
 (ros::spin-once)
 (ros::sleep))
|#

