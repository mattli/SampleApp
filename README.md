# SampleApp

Trying to debug the following:

Issue: I have a confetti animation that runs in a custom UIView that I add as a subview on button tap. I also have a tableview whose cells I would like to be re-orderable by drag and drop. To do this, I have implemented various UITableViewDragDelegate and UITableViewDropDelegate methods.

Individually, both of these features are working as expected.

However, one unforeseen side-effect I have encountered is that after a tableview cell is re-ordered, the confetti animation stops appearing until the app is closed and reloaded. This is true whether or not the confetti animation view is added on the same or different view controller.

Some observations:
* The confetti animation view is being added in the appropriate place in the view hierarchy and appears in the view hierarchy debugger.
* The confetti animation is being run on the main thread. I have checked that Thread.isMainThread returns True when it is being called.
* When itemsForBeginning runs, the animation still works as expected. By the time dropSessionDidUpdate runs, the animation stops appearing.
