#import "DeleterAppDelegate.h"
#import "DeleterRootViewController.h"
#import "OthersViewController.h"
@interface TerminalViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, retain) UIBarButtonItem *dev;

-(void)other:(UIButton *)sender;
-(void)launch:(UIButton*)sender;

@end