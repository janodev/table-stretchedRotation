This is the source for

	WWDC 2012 Session 240 - Polishing Your Interface Rotations
                                25:43 Snapshot Rotations by Josh Shaffer

The WWDC Source download doesn't include it, so I typed the code from the video.

This is a normal rotation:

![Normal rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/normal-rotation.gif)

If you animate a view that implements `drawRect:`, it redraws itself for its new `contentSize` at the beginning of the animation. 
This is the reason the text changes suddenly before the animation starts.

Here is the fixed version:

![Stretched rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/stretched-rotation.gif)

The code is rendering the model tree to an UIImage before the animation starts. 
Then it stretches only the red area shown in this image:

![Snapshot rotation](https://raw.github.com/j4n0/table-stretchedRotation/master/pages/snapshot-rotation.png)

This is all hard to see unless you pay attention or click Toggle Slow Animations in the simulator.
For more explanations see WWDC 2012 Session 240.
