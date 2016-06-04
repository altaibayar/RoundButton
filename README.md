# RoundButton
Round icon looking buttons created for the purpose of one of my projects. 
RoundButton.swift inherits from UIButton, so you can be be easily add listeners for it's events

![screenshot]
(img.PNG)

Round supports 
* Camera
* Picture
* OK
* Rectangle
* Line
* Add
* Remove
* CameraNotAvailable
* PictureNotAvailable 
states.

Each state is defined by array of array of coordinates (CGPoint) in 5x5 field. Each array describes on connected line. If array contains only 1 coordinate then 0.25 unit of circle is drawn using the point as it's center. 