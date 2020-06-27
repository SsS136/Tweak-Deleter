
#import "MenuViewController.h"
#import "OthersViewController.h"
#import "DylibDisableViewController.h"
#import "TerminalViewController.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

@implementation MenuViewController


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

}

- (void)viewDidLoad
{
    [super viewDidLoad];
         self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:50.0/255.0 alpha:
255.0/255.0];

        self.dev = [[UIBarButtonItem alloc] initWithTitle:@"Others" 
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(other:)];
        self.navigationItem.rightBarButtonItem = self.dev;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(W/2, H/2, 160, 30);
    btn.center = CGPointMake(W/2,H/2);
    btn.backgroundColor = [UIColor blackColor];
    btn.layer.cornerRadius = 10;
    [btn setTitle:@"Dylib disabler (beta)" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hog:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];

    UIButton *bt = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bt.frame = CGRectMake(W/2, 2*(H/3), 160, 30);
    bt.center = CGPointMake(W/2,2*(H/3));
    bt.backgroundColor = [UIColor blackColor];
    bt.layer.cornerRadius = 10;
    [bt setTitle:@"Root Terminal" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(terminal:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bt];

}
-(void)terminal:(UIButton*)sender {
    TerminalViewController *terninal = [[TerminalViewController alloc] init];
    [self.navigationController pushViewController: terninal animated:YES];
}
-(void)hog:(UIButton*)sender {
    DylibDisableViewController *dd = [[DylibDisableViewController alloc] init];
    [self.navigationController pushViewController:dd animated:YES];
}

-(void)other:(UIButton*)sender {
    OthersViewController *vc = [[OthersViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}



@end