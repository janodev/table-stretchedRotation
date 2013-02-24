This is the source for

    WWDC 2012 Session 240 - Polishing Your Interface Rotations
                            25:43 Snapshot Rotations by Josh Shaffer

It explains how the animation in the mail application works.  
The WWDC Source download doesn't include it, so I typed the code from the video.

This is a normal rotation:

![Normal rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/normal-rotation.gif)

As we see, the text changes suddenly before a rotation. This happens because any view implementing `drawRect:` 
redraws itself before an animation starts, therefore showing instantly the changes in the model tree.

Here is the fixed version:

![Stretched rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/stretched-rotation.gif)

The code is rendering the model tree to an UIImage before there is any change in the model tree,
then it inserts that image, and crossfades with the final state. 
The only area stretched is the red column shown in the image below.

![Snapshot rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/snapshot-rotation.png)

The effect is hard to see unless you pay attention or click Toggle Slow Animations in the simulator.  
All the code is in `SRViewController.m`. For more explanations see WWDC 2012 Session 240.
