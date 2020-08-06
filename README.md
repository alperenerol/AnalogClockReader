# AnalogClockReader

In edgecenters.m , I wrote this function to detect lines and edges and longest lines on clock image. This function converts image to gray, get edges using sobel and get boundaries to get estimated center.

In findarrows.m function , I wrote this function to detect lines and edges on clock image and longest lines. I used for these purpose Hough Transform. After convert image to gray, this function get hough lines, get more exact center point and optimise center point with more accurately even in different images. Also, this function provide lines one endpoint to stay on the center point so this make programme more accurate.

final2.m is the main code of this question. When debugShow is true programme shows lines, hour hand, minutehand , boundaries, center as shown example in above. When debugShow is false then programme only shows time as output.
After my function executed in programme if it can not detect any line then take the center information from the info data of image. I used struct to save detected lines. After that according to length values of detected lines programme determine which line is hour hand or  which line is minute hand. After programme determines them, calculates angles between hour hand and minute hand. Since clock is a circular thing it has 360 degree finds final angles in degree unit. To determine hour and minute I wrote an equation with my mathematical knowledge.
Programme worked and detected lines, boundaries perfectly and find correct time for all clock images. Accuracy of programme for given images are %100.
