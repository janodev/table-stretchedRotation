/*
 Mostly from
     Erica Sadun, http://ericasadun.com
     iPhone Developer's Cookbook, 6.x Edition
     BSD License, Use at your own risk
*/

#import "UIView+FrameGeometry.h"

@implementation UIView(FrameGeometry)


- (void) scaleBy: (CGFloat) scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}


- (void) fitInSize: (CGSize) size
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > size.height)) {
        // scale to fit height
        scale = size.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= size.width)) {
        // scale to fit width
        scale = size.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}


- (void) setFramePreservingHeight:(CGRect)rect
{
    CGFloat height = self.frame.size.height;
    rect.size.height = height;
    self.frame = rect;
}

- (void) setFramePreservingWidth:(CGRect)rect
{
    CGFloat width = self.frame.size.width;
    rect.size.width = width;
    self.frame = rect;
}

#pragma mark - origin

- (CGPoint) origin {
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) origin {
    CGRect f = self.frame;
    f.origin = origin;
    self.frame = f;
}

- (CGFloat) originX {
    return self.frame.origin.x;
}

- (void) setOriginX: (CGFloat) originX {
    CGRect rect = self.frame;
    rect.origin.x = originX;
    self.frame = rect;
}

- (CGFloat) originY {
    return self.frame.origin.y;
}

- (void) setOriginY: (CGFloat) originY {
    CGRect rect = self.frame;
    rect.origin.y = originY;
    self.frame = rect;
}

#pragma mark - size

- (CGSize) size {
    return self.frame.size;
}

- (void) setSize: (CGSize) size {
    CGRect f = self.frame;
    f.size = size;
    self.frame = f;
}

- (CGFloat) sizeHeight {
    return self.frame.size.height;
}

- (void) setSizeHeight: (CGFloat) height {
    CGRect f = self.frame;
    f.size.height = height;
    self.frame = f;
}

- (CGFloat) sizeWidth {
    return self.frame.size.width;
}

- (void) setSizeWidth: (CGFloat) width {
    CGRect f = self.frame;
    f.size.width = width;
    self.frame = f;
}

#pragma mark - corner points 

- (CGPoint) topLeft {
    return CGPointMake(0, 0);
}

- (CGPoint) topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

- (CGPoint) bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

@end
