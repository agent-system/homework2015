# homework 20150707

roslaunch hrpsys_gazebo_tutorials gazebo_sample_robot_no_controllers.launch WORLD:=$HOME/ros/hydro/src/rtm-ros-robotics/rtmros_tutorilas/hrpsys_gazebo_tutorials/worlds/Sample2.world

rtmlaunch hrpsys_gazebo_tutorials/samplerobot_hrpsys_bringup.launch


in Shell
(roseus samplerobot-reaching2.l)
(send *ri* :calibrate-inertia-sensor)
(send *ri* :start-auto-balancer)
(send *ri* :start-st)
(send *ri* :start-impedance :arms)
(reaching-pose)
(send *ri* :go-pos 0.2 0 0)
(grasp)
(reaching-pose2)
(send *ri* :go-pos 0 0.5 0)
(send *ri* :go-pos 0 0.5 0)
(reaching-pose)


