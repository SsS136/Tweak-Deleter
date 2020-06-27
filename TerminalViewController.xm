#import "TerminalViewController.h"

#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import <NSTask.h>
UITextView *tv;

@implementation TerminalViewController

@synthesize dev;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
-(void)loadView {
    [super loadView];

         self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:50.0/255.0 alpha:
255.0/255.0];

        self.dev = [[UIBarButtonItem alloc] initWithTitle:@"Others" 
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(other:)];
        self.navigationItem.rightBarButtonItem = self.dev;

}

- (void)viewDidLoad
{
    [super viewDidLoad];

    CGRect rect = CGRectMake(0, 0, W-40, H-100);
    tv = [[UITextView alloc] initWithFrame:rect];
    tv.center = CGPointMake(W/2,H/2);
    tv.editable = YES;
    tv.text = @"Please delete all logs after outputting.  Delete this message as well, and then type the command.";
    tv.backgroundColor = [UIColor blackColor];
    tv.textColor = [UIColor whiteColor];
    [self.view addSubview:tv];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(W/4, H-30, 100, 30);
    btn.center = CGPointMake(W/4,H-30);
    btn.backgroundColor = [UIColor blackColor];
    btn.layer.cornerRadius = 10;
    [btn setTitle:@"launch" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(launch:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    

    UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame = CGRectMake(3*W/4, H-30, 100, 30);
    bt.center = CGPointMake(3*W/4,H-30);
    bt.backgroundColor = [UIColor blackColor];
    bt.layer.cornerRadius = 10;
    [bt setTitle:@"Clear Log" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(clear:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bt];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    tv.isFirstResponder ? [tv resignFirstResponder] : [tv becomeFirstResponder];
}

-(void)other:(UIButton*)sender {

    OthersViewController *vc = [[OthersViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)clear:(UIButton*)sender {
    tv.text = @"";
}
-(void)launch:(UIButton*)sender {
    NSTask *task  = [[NSTask alloc] init];
    NSPipe *pipe  = [[NSPipe alloc] init];
    NSPipe *errPipe = [NSPipe pipe];
    [task setStandardError:errPipe];
    [task setLaunchPath: @"/bin/sh"];
    [task setArguments: [NSArray arrayWithObjects:@"-c",tv.text,nil]];
    [task setStandardOutput:pipe];
    [task launch];
    NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
    NSData *errdata = [[errPipe fileHandleForReading] readDataToEndOfFile];
    NSString *resulterr = [[NSString alloc] initWithData:errdata
encoding:NSUTF8StringEncoding];
    NSString *result = [[NSString alloc] initWithData:data
encoding:NSUTF8StringEncoding];
    if(resulterr.length < 2) {
        tv.text = result;
    }else{
        tv.text = resulterr;
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [tv scrollRangeToVisible:NSMakeRange(tv.text.length, 0)];
    });

}
@end