#!/usr/bin/env roseus
;; turtlesim-teleop.l
;; Author: Yuki Furuta <furushchev@jsk.imi.i.u-tokyo.ac.jp>

(ros::roseus "turtlesim_teleop")

(require :kbhit "kbhit.l")
(defconstant *key-up* 65)
(defconstant *key-down* 66)
(defconstant *key-right* 67)
(defconstant *key-left* 68)

(ros::roseus-add-msgs "geometry_msgs")

(ros::rate 100)

(ros::advertise "cmd_vel" geometry_msgs::Twist)

(while (ros::ok)
  (setq *msg* (instance geometry_msgs::Twist :init))
  (setq c (kbhit))
  (cond
    ((eq c *key-up*)
     (send *msg* :linear :x 1.2))
    ((eq c *key-down*)
     (send *msg* :linear :x -1.2))
    ((eq c *key-right*)
     (send *msg* :angular :z (deg2rad -30)))
    ((eq c *key-left*)
     (send *msg* :angular :z (deg2rad 30)))
    ((eq c #\q)
     (format nil "abort!~%")
     (return)))
  (ros::ros-info "published" (print-ros-msg *msg*))
  (ros::publish "cmd_vel" *msg*))
