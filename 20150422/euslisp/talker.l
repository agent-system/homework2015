#!/usr/bin/env roseus
;; talker.l
;; Author: Yuki Furuta <furushchev@jsk.imi.i.u-tokyo.ac.jp>

(ros::roseus "talker")

(ros::roseus-add-msgs "std_msgs")

(ros::advertise "chatter" std_msgs::String 1)

(ros::rate 1)

(do-until-key
  (setq msg (instance std_msgs::String :init))
  (send msg :data (format nil "hello world ~A"
                          (send (ros::time-now) :sec-nsec)))
  (ros::ros-info "msg [~A]" (send msg :data))
  (ros::publish "chatter" msg)
  (ros::sleep))
