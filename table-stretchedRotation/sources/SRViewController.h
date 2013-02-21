// BSD License. Created by jano@jano.com.es

#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@interface SRViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) IBOutlet UITableView *tableView;
@property (nonatomic,assign) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic,assign) IBOutlet UIToolbar *toolbar;

@end
