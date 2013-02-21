
/* Code from the demo
 *
 *   WWDC 2012 Session 240 - Polishing Your Interface Rotations
 *                           25:43 Snapshot Rotations by Josh Shaffer
 */

#import <QuartzCore/QuartzCore.h>

@interface SRViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) IBOutlet UITableView *tableView;
@property (nonatomic,assign) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic,assign) IBOutlet UIToolbar *toolbar;

@end
