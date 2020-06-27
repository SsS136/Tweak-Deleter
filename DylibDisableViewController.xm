#import "DylibDisableViewController.h"
#import "OthersViewController.h"
#import "DylibDisableViewController.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height

NSArray *extension = @[ ];
NSArray *extension2 = @[ ];
NSArray *extension3 = @[ ];
NSArray *extension4 = @[ ];

NSMutableArray *swarr = [@[] mutableCopy];
NSMutableArray *swarr2 = [@[] mutableCopy];

@implementation DylibDisableViewController

inline NSString *substring(NSString *a,int b) {
    NSString *str2 = [a substringFromIndex:b];
    return str2;
}

@synthesize apply;

-(NSArray *)getFileList:(NSString *)extension num:(int)num place:(NSString*)place {
    NSMutableArray *array = [[NSMutableArray alloc] init];

    NSFileManager* fileManager = [[NSFileManager alloc] init];
    NSString *path = place;
    for(NSString *content in [fileManager contentsOfDirectoryAtPath:path error:nil]) {

        if ([content hasSuffix:extension]) {
            NSString *content2 = [content stringByDeletingPathExtension];
          NSLog(@"%@", content2);
            if(num == 1) {
                [array addObject:content];
            }else{
                [array addObject:content2];
            }
        }
    }
    return array;
}

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

        self.apply = [[UIBarButtonItem alloc] initWithTitle:@"Apply" 
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(other:)];
        self.navigationItem.rightBarButtonItem = self.apply;
    

        extension = [self getFileList:@".dylib" num:1 place:@"/Library/MobileSubstrate/DynamicLibraries"];//dylib
        extension2 = [self getFileList:@".dylib" num:2 place:@"/Library/MobileSubstrate/DynamicLibraries"];//not extension
        extension3 = [self getFileList:@".dylib" num:2 place:@"/Applications/TweakDeleter.app/Topath"];
        extension4 = [self getFileList:@".dylib" num:1 place:@"/Applications/TweakDeleter.app/Topath"];

        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,W,H)];
        UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W,(extension.count)*50+(extension3.count)*50)];
        [sv addSubview:uv];
        sv.contentSize = uv.bounds.size;
        [self.view addSubview:sv];
        int i=0;        
        int a=0;
        for(a=0;a<extension3.count;a++) {

            NSString *check2 = [extension3 objectAtIndex:a];
            UILabel *labell = [[UILabel alloc] init];
            labell.frame = CGRectMake(0,50*a,2*(W/3),50);
            labell.backgroundColor = [UIColor redColor];
            labell.textColor = [UIColor blueColor];
            labell.font = [UIFont fontWithName:@"AppleGothic" size:16];
            labell.textAlignment = NSTextAlignmentCenter;
            labell.text = check2;
            [uv addSubview:labell];

            UISwitch *sw2 = [[UISwitch alloc] init];
            sw2.center = CGPointMake(W-70, 25+50*a);
            sw2.on = NO;
            sw2.tag = a+1000;
            [sw2 addTarget:self action:@selector(movedylib:) forControlEvents:UIControlEventValueChanged];
            [sv addSubview:sw2];

        }
        for(i=0;i<extension2.count;i++) {
            NSString *check = [extension2 objectAtIndex:i];
            UILabel *label = [[UILabel alloc] init];
            label.frame = CGRectMake(0,50*a+50*i,2*(W/3),50);
            label.backgroundColor = [UIColor greenColor];
            label.textColor = [UIColor blueColor];
            label.font = [UIFont fontWithName:@"AppleGothic" size:16];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = check;
            [uv addSubview:label];

            UISwitch *sw = [[UISwitch alloc] init];
            sw.center = CGPointMake(W-70, 25+50*a+50*i);
            NSString *topath = @"/Applications/TweakDeleter.app/Topath/";
            NSString *filee = [extension objectAtIndex:i];
            NSString *path = [NSString stringWithFormat:@"%@%@", topath,filee];
           
            if (![[NSFileManager defaultManager] fileExistsAtPath:path]) 
            {
                sw.on = YES;
            } else {
                sw.on = NO;
            }
           
            sw.tag = i+1;
            [sw addTarget:self action:@selector(dylib:) forControlEvents:UIControlEventValueChanged];
            [sv addSubview:sw];
        }
}

-(void)movedylib:(UIButton*)sender {
       NSString *fzf = [extension4 objectAtIndex:sender.tag-1000];
       NSString *abcz = [swarr2 componentsJoinedByString:@"\n"];
       NSRange rang = [abcz rangeOfString:fzf];
       NSString *retstr1_1 = [fzf substringWithRange:NSMakeRange(0, 1)];
       if([retstr1_1 isEqualToString:@" "]) {
            fzf = substring(fzf,1);
       }
       if(rang.location == NSNotFound) {
            [swarr2 addObject:fzf];
       }else{
            [swarr2 removeObject:fzf];
       }
}
-(void)dylib:(UIButton*)sender {
       NSString *fzf = [extension objectAtIndex:sender.tag-1];
       NSString *abcz = [swarr componentsJoinedByString:@"\n"];
       NSRange rang = [abcz rangeOfString:fzf];
       NSString *retstr1_1 = [fzf substringWithRange:NSMakeRange(0, 1)];
       if([retstr1_1 isEqualToString:@" "]) {
            fzf = substring(fzf,1);
       }

       if(rang.location == NSNotFound) {
            [swarr addObject:fzf];
       }else{
            [swarr removeObject:fzf];
       }
}
-(void)other:(UIButton*)sender {
    NSString *str = [swarr componentsJoinedByString:@"\n"];
    NSString *strr = [swarr2 componentsJoinedByString:@"\n"];
    NSString *strrr = [NSString stringWithFormat:@"%@%@", str, strr];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Do you want to disable these tweaks??" 
    message:strrr 
    preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"YES" 
    style:UIAlertActionStyleDefault 
    handler:^(UIAlertAction *action) {
        for(int i=0;i<swarr.count;i++) {
            NSString *fzf = [swarr objectAtIndex:i];
            NSString *at = @"/Library/MobileSubstrate/DynamicLibraries/";
            NSString *topath = @"/Applications/TweakDeleter.app/Topath";
            NSString *atpath = [NSString stringWithFormat:@"mv %@%@ %@",at,fzf,topath];
            system((char *) [atpath UTF8String]);
       }
            //NSString *str2 = [swarr componentsJoinedByString:@"\n"];
        for(int c=0;c<swarr2.count;c++) {
            
            NSString *swa = [swarr2 objectAtIndex:c];
            NSString *retstr1_1 = [swa substringWithRange:NSMakeRange(0, 1)];
            if([retstr1_1 isEqualToString:@" "]) {
                swa = substring(swa,1);
            }
            NSString *atm = @"/Library/MobileSubstrate/DynamicLibraries";
            NSString *topat = @"/Applications/TweakDeleter.app/Topath/";
            NSString *atpat = [NSString stringWithFormat:@"mv %@%@ %@",topat,swa,atm];
            system((char *) [atpat UTF8String]);

        }

        swarr = [@[] mutableCopy];
        swarr2 = [@[] mutableCopy];
        [super viewDidLoad];
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" 
    style:UIAlertActionStyleDefault 
    handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end