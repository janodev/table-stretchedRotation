
/* Code from the demo
 *
 *   WWDC 2012 Session 240 - Polishing Your Interface Rotations
 *                           25:43 Snapshot Rotations by Josh Shaffer
 */

#import "SRViewController.h"


@implementation SRViewController {
    CGRect _frameBeforeRotation;
    CGRect _frameAfterRotation;
    UIImageView *_snapshotBeforeRotation;
    UIImageView *_snapshotAfterRotation;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 25;
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"identifier";
    UITableViewCell *cell = [aTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    [[cell textLabel] setText:@"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut"];
    [[cell textLabel] setNumberOfLines:2];
    [[cell textLabel] setFont:[UIFont systemFontOfSize:12]];

    return cell;
}

#pragma mark - Orientation

- (BOOL)shouldAutorotate {
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}


#pragma mark - Stretched Rotation

static UIImageView *CaptureSnapshotOfView(UIView *targetView)
{
    UIGraphicsBeginImageContextWithOptions([targetView bounds].size,
                                           YES, // opaque, no transparency needed
                                           0);  // 0 to use scale of the main screen
    // shift by the amount scrolled by
	CGContextTranslateCTM(UIGraphicsGetCurrentContext(), -[targetView bounds].origin.x, -[targetView bounds].origin.y);
    
	[[targetView layer] renderInContext:UIGraphicsGetCurrentContext()]; // render the model tree
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
	UIImageView *snapshotView = [[UIImageView alloc] initWithImage:image];
	[snapshotView setFrame:[targetView frame]];
	return snapshotView;
}


// Called before any of the changes have been applied.
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	_frameBeforeRotation = [_tableView frame];
    
	_snapshotBeforeRotation = CaptureSnapshotOfView(_tableView);
	[[self view] insertSubview:_snapshotBeforeRotation aboveSubview:_tableView];
	
    // This following results in shorter bars when in landscape...
    
    // The intrinsic content size is different for landscape,
    // so we invalidate it for autolayout to pick the changes.
    // UINavigationController already does this, but we are not using one here.
	[_navigationBar invalidateIntrinsicContentSize];
	[_toolbar invalidateIntrinsicContentSize];
}


// Called after all views in the model tree hierarchy have already been resized for the new orientation.
// This method stretches the red area between the text and the chevrons.
-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval) duration {
	
	_frameAfterRotation = [_tableView frame];
	
	[UIView setAnimationsEnabled:NO];
	
	_snapshotAfterRotation = CaptureSnapshotOfView(_tableView);
    
    {
        // [snapshotAfterRotation setFramePreservingHeight:frameBeforeRotation];
        CGFloat height = _snapshotAfterRotation.frame.size.height;
        CGRect rect = _frameBeforeRotation;
        rect.size.height = height;
        [_snapshotAfterRotation setFrame:rect];
    }
    
	UIEdgeInsets unstretchedArea = [self unstretchedInsetsForTableView:_tableView];
	
	UIImage *imageBeforeRotation = [_snapshotBeforeRotation image];
	UIImage *imageAfterRotation  = [_snapshotAfterRotation  image];
	
	imageBeforeRotation = [imageBeforeRotation resizableImageWithCapInsets:unstretchedArea resizingMode:UIImageResizingModeStretch];
	imageAfterRotation  = [imageAfterRotation  resizableImageWithCapInsets:unstretchedArea resizingMode:UIImageResizingModeStretch];
	
	[_snapshotBeforeRotation setImage:imageBeforeRotation];
	[_snapshotAfterRotation  setImage:imageAfterRotation];
	
	[UIView setAnimationsEnabled:YES];
	
	// pick the shorter image. fade it in or out
	if ([imageAfterRotation size].height < [imageBeforeRotation size].height) {
		[_snapshotAfterRotation setAlpha:0.0];
		[[self view] insertSubview:_snapshotAfterRotation
                      aboveSubview:_snapshotBeforeRotation];
		[_snapshotAfterRotation setAlpha:1.0];
	} else {
		[[self view] insertSubview:_snapshotAfterRotation belowSubview:_snapshotBeforeRotation];
		[_snapshotBeforeRotation setAlpha:0.0];
	}
	
    [_snapshotAfterRotation setFrame:_frameAfterRotation];
    {
        // [snapshotBeforeRotation setFramePreservingHeight:frameAfterRotation];
        CGFloat height = _snapshotBeforeRotation.frame.size.height;
        CGRect rect = _frameAfterRotation;
        rect.size.height = height;
        [_snapshotBeforeRotation setFrame:rect];
    }
    
    // no need to render the table at this point because it's covered
	[_tableView setHidden:YES];
}


-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // remove the snapshots and hide the table
	[_snapshotBeforeRotation removeFromSuperview];
	[_snapshotAfterRotation removeFromSuperview];
	_snapshotBeforeRotation = nil;
	_snapshotAfterRotation = nil;
	[_tableView setHidden:NO];
}


// This tells UIKit to snapshot the toolbar and do a crossfade.
// Otherwise the buttons in the toolbar are animated from side to side.
-(UIView*)rotatingFooterView
{
	return _toolbar;
}


#pragma mark - Utilities


-(UIEdgeInsets)unstretchedInsetsForTableView:(UITableView*)targetView {
	UIEdgeInsets result = UIEdgeInsetsZero;
	
	// find the right edge of the content view in the coordinate space of the UITableView
	UIView *contentView = [[[targetView visibleCells] objectAtIndex:0] contentView];
	CGFloat contentViewRightEdge = [targetView convertPoint:CGPointMake([contentView bounds].size.width,0) fromView:contentView].x;
	CGFloat rightFixedWidth = [targetView bounds].size.width - contentViewRightEdge;
	CGFloat leftFixedWidth = MIN(_frameAfterRotation.size.width, _frameBeforeRotation.size.width) - rightFixedWidth - 1;
	result = UIEdgeInsetsMake(0, leftFixedWidth, 0, rightFixedWidth);
    
	return result;
}

@end

