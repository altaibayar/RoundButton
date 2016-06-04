# RoundButton
Round icon looking buttons implemented in Swift created for the purpose of one of my projects. 

RoundButton.swift inherits from UIButton, so you can be be easily add listeners for it's events

######Round supports following states (looks): 
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

######RoundButton has public properties: 
* lineColor: UIColor - Color of the inner lines. 
* roundColor: UIColor - Color of the border circle
* roundLineWidth: CGFloat - Width of the circle border
* innerLineWidth: CGFloat - Width of the lines in the circle

Each state is defined by array of array of coordinates (CGPoint) in 5x5 field. Each array describes one connected line. If array contains only 1 coordinate then 0.25 unit of circle is drawn using the point as it's center. 

![screenshot]
(img.PNG)

