#import "OthersViewController.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

UIView *uv;

@implementation OthersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
 
- (void)viewDidLoad
{
    [super viewDidLoad];
        self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:50.0/255.0 alpha:
255.0/255.0];

    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,W,H)];
    uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W,H)];
    [sv addSubview:uv];
    sv.contentSize = uv.bounds.size;
    [self.view addSubview:sv];

   UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(W/2, H/4, 100, 50);
    label.center = CGPointMake(W/2,H/4);
    //label.backgroundColor = [UIColor yellowColor];
    label.textColor = [UIColor blueColor];
    label.font = [UIFont fontWithName:@"AppleGothic" size:18];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.text = @"Developer";
    label.alpha = 0.0;
    label.userInteractionEnabled = YES;
    label.tag = 10;
    [uv addSubview:label];
    
    UIImage *twitter = [UIImage imageWithContentsOfFile:@"/Applications/TweakDeleter.app/twitter.png"];
    UIImageView *twitterView = [[UIImageView alloc] initWithImage:twitter];
    twitterView.frame = CGRectMake(W/2,H/3,70,70);
    twitterView.center = CGPointMake(W/2,H/3);
    twitterView.layer.masksToBounds = YES;
    twitterView.layer.cornerRadius = 35;
    twitterView.alpha = 0.0;
    twitterView.userInteractionEnabled = YES;
    twitterView.tag = 10;
    [uv addSubview:twitterView];

   UILabel *labe = [[UILabel alloc] init];
    labe.frame = CGRectMake(W/2, H/3+60,80, 50);
    labe.center = CGPointMake(W/2,H/3+60);
    labe.textColor = [UIColor grayColor];
    labe.font = [UIFont fontWithName:@"AppleGothic" size:18];
    labe.textAlignment = NSTextAlignmentCenter;
    labe.alpha = 0.0;
    labe.text = @"SsS136";    
    labe.userInteractionEnabled = YES;
    labe.tag = 10;
    [uv addSubview: labe];

   UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(W/2, H/3+100,80, 50);
    label2.center = CGPointMake(W/2,H/3+100);
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont fontWithName:@"AppleGothic" size:12];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.alpha = 0.0;
    label2.userInteractionEnabled = YES;
    label2.tag = 10;
    label2.text = @"@DevTweak";
    [uv addSubview: label2];

    UITapGestureRecognizer *tapGesture =
[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];

    UITapGestureRecognizer *tapGesture2 =
[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];

    UITapGestureRecognizer *tapGesture3 =
[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];

    [twitterView addGestureRecognizer:tapGesture];
    [labe addGestureRecognizer:tapGesture2];
    [label2 addGestureRecognizer:tapGesture3];

    UIButton *github = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    github.frame = CGRectMake(W/2, H/2+80, 130, 35);
    github.center = CGPointMake(W/2,H/2+80);
    [github setTitle:@"GitHub" forState:UIControlStateNormal];
    [github addTarget:self action:@selector(github)  forControlEvents:UIControlEventTouchUpInside];
    github.tintColor = [UIColor greenColor];
    github.backgroundColor = [UIColor blackColor];
    github.layer.cornerRadius = 10;
    github.alpha = 0.0;
    [uv addSubview:github];

    UIButton *cydia = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cydia.frame = CGRectMake(W/2, H/2+140, 130, 35);
    cydia.center = CGPointMake(W/2,H/2+140);
    [cydia setTitle:@"Add to Cydia" forState:UIControlStateNormal];
    [cydia addTarget:self action:@selector(cydia)  forControlEvents:UIControlEventTouchUpInside];
    cydia.tintColor = [UIColor greenColor];
    cydia.backgroundColor = [UIColor blackColor];
    cydia.layer.cornerRadius = 10;
    cydia.alpha = 0.0;
    [uv addSubview:cydia];

        [UIView animateWithDuration:1.3f
        delay:0.0f
        options:UIViewAnimationOptionCurveEaseIn
        animations:^{
            label.alpha = 1.0;
            twitterView.alpha = 1.0;
            label2.alpha = 1.0;
            labe.alpha = 1.0;
            github.alpha = 1.0;
            cydia.alpha = 1.0;
        } completion:^(BOOL finished) {

        }];
}

- (void)tapped {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://mobile.twitter.com/DevTweak"]];
}

-(void) github {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/SsS136"]];
}
-(void)cydia {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"cydia://url/https://cydia.saurik.com/api/share#?source=https://SsS136.github.io/"]];
}
@end