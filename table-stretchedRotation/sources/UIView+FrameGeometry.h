/*
 Mostly from
     Erica Sadun, http://ericasadun.com
     iPhone Developer's Cookbook, 6.x Edition
     BSD License, Use at your own risk
*/

#import <UIKit/UIKit.h>

@interface UIView(FrameGeometry)

@property CGPoint origin;
@property CGFloat originX;
@property CGFloat originY;

@property CGSize  size;
@property CGFloat sizeHeight;
@property CGFloat sizeWidth;

// Corner points.
@property (readonly) CGPoint topLeft; // always 0,0
@property (readonly) CGPoint topRight;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;

// Scale up or down to fit in the given size.
- (void) fitInSize: (CGSize) size;

// Scale by the given amount.
- (void) scaleBy: (CGFloat) scaleFactor;

// Set every attribute except the width/height.
- (void) setFramePreservingWidth:  (CGRect) rect;
- (void) setFramePreservingHeight: (CGRect) rect;

@end
