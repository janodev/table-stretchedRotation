
This is the source for

	Session 240 - Polishing Your Interface Rotations
	25:43 Snapshot Rotations by Josh Shaffer

WWDC Source download doesn't include it, so I typed the code from the video.

This is a normal rotation:

![Normal rotation](https://github.com/j4n0/table-stretchedRotation/raw/master/table-stretchedRotation/pages/normal-rotation.gif)

If you animate a view that implements drawRect:, it redraws itself for its new contentSize at the beginning of the animation. 
In this case, it results in a sudden change before the animation starts.

This is a rotation with a stretching effect:

![Stretched rotation](https://github.com/j4n0/table-stretchedRotation/raw/master/table-stretchedRotation/pages/stretched-rotation.gif)

The difference is that the text is not so jumpy because only this red area is stretching:

![Snapshot rotation](https://github.com/j4n0/table-stretchedRotation/raw/master/table-stretchedRotation/pages/snapshot-rotation.gif)

This is all hard to see unless you pay attention or click Toggle Slow Animations in the simulator.
