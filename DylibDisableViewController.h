#import "DeleterAppDelegate.h"
#import "DeleterRootViewController.h"

@interface DylibDisableViewController : UIViewController
@property (nonatomic, retain) UIBarButtonItem *apply;
-(void)other:(UIButton *)sender;
-(NSArray *)getFileList:(NSString *)extension num:(int)num place:(NSString*)place;

@end