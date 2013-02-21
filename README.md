This is the source for

    WWDC 2012 Session 240 - Polishing Your Interface Rotations
                            25:43 Snapshot Rotations by Josh Shaffer

It explains how the animation in the mail application works.  
The WWDC Source download doesn't include it, so I typed the code from the video.

This is a normal rotation:

![Normal rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/normal-rotation.gif)

As we see, the text changes suddenly before a rotation. This happens because 

  - the cells implement `drawRect:` internally,
  - the model tree is instantly updated before an animation starts,
  - therefore, the cells show the model tree before the animation has a chance to start.

Here is the fixed version:

![Stretched rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/stretched-rotation.gif)

Smooth. The code is rendering the model tree to an UIImage before the model tree changes,
then it inserts that image, and stretches only the red area (see below) during the animation.

![Snapshot rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/snapshot-rotation.png)

This is all hard to see unless you pay attention or click Toggle Slow Animations in the simulator.  
For more explanations see WWDC 2012 Session 240.
