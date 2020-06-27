#import "DeleterRootViewController.h"
#define W [UIScreen mainScreen].bounds.size.width
#define H [UIScreen mainScreen].bounds.size.height
#import "NSString+split.h"
#import <stdlib.h>
#import <NSTask.h>
#import "MenuViewController.h"

typedef enum {
    tweak,
    tool,
    icon,    
    app,
    terminal,
    library,
    theme, 
    packaging,
    data,
    key,
    graph,
    script,
    network,
    setting,
} png;

NSMutableArray *resultarr = [@[] mutableCopy];    
NSMutableArray *resultarr2 = [@[] mutableCopy];
NSMutableArray *fff = [@[] mutableCopy];
NSMutableArray *muarr = [@[] mutableCopy];
NSMutableArray *muarr2 = [@[] mutableCopy];
NSString *resulterr;
UIImage *iconimage;
UIImageView *iconimageview;


static NSArray *viewArray = 
    [NSArray arrayWithObjects:
        @"/Applications/TweakDeleter.app/tweak.png", //0
        @"/Applications/TweakDeleter.app/tool.png",
        @"/Applications/TweakDeleter.app/icon.png",
        @"/Applications/TweakDeleter.app/app.png",
        @"/Applications/TweakDeleter.app/terminal.png", 
        @"/Applications/TweakDeleter.app/library.png",
        @"/Applications/TweakDeleter.app/theme.png", 
        @"/Applications/TweakDeleter.app/packaging.png",
        @"/Applications/TweakDeleter.app/data.png", 
        @"/Applications/TweakDeleter.app/key.png" , 
        @"/Applications/TweakDeleter.app/graph.png",
        @"/Applications/TweakDeleter.app/script.png",
        @"/Applications/TweakDeleter.app/network.png", 
        @"/Applications/TweakDeleter.app/setting.png" , //13
    nil];


//enum list

//1 tweak 0
//2 tool 1
//3 icon 2
//4 app 3
//5 terminal 4
//6 library 5
//7 theme 6
//8 packaging 7
//9 data 8
//10 key 9
//11 graph 10
//12 script 11
//13 network 12
//14 setting 13

//enumend


int countt = 0;

@implementation DeleterRootViewController

@synthesize killButton;
@synthesize allkillButton;

inline NSString *substring(NSString *a,int b) {
    NSString *str2 = [a substringFromIndex:b];
    return str2;
}

- (void)loadView {
	[super loadView];

        self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
        self.view.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:50.0/255.0 alpha:
255.0/255.0];

	self.title = @"Tweak Deleter";
        self.killButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" 
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(addButtonTapped:)];

        self.allkillButton = [[UIBarButtonItem alloc] initWithTitle:@"Menu" 
                                    style:UIBarButtonItemStylePlain
                                    target:self 
                                    action:@selector(deleteButtonTapped:)];

        self.navigationItem.rightBarButtonItem = self.killButton;
	self.navigationItem.leftBarButtonItem = self.allkillButton;
}
-(void)viewDidLoad {

    static NSString *check = nil;
    NSRange range;
    NSMutableArray *fix = [NSMutableArray array];
    NSMutableArray *fix2 = [NSMutableArray array];
    NSMutableArray *fix3 = [NSMutableArray array];
    static NSString *z = nil;
    //NSMutableArray *ar = [NSMutableArray array];

    NSString *String = [[NSString alloc] initWithContentsOfFile:@"/Library/dpkg/status" encoding:NSUTF8StringEncoding error:NULL];

    NSArray *abc = [String splitNewLine2];

    for(int i=0;i<abc.count;i++) {
        check = [abc objectAtIndex:i];
        NSArray *abc2 = [check splitNewLine];
        for(int abz=0;abz<abc2.count;abz++) {
            NSString *check2 = [abc2 objectAtIndex:abz];
            range = [check2 rangeOfString:@"Package:"];
            NSRange name = [check rangeOfString:@"Name:"];
            NSRange nam = [check rangeOfString:@"Package:"];
            NSRange name2 = [check2 rangeOfString:@"Name:"];
            NSRange section = [check2 rangeOfString:@"Section:"];
            if(name.location != NSNotFound && nam.location != NSNotFound) {
                if(range.location != NSNotFound) [fix addObject:check2];
                if(name2.location != NSNotFound) {
                    NSString *sub = substring(check2,6);
                    [fix2 addObject:sub]; 
                    countt++;
                        //[fix2 addObject:check2];
                }
                if(section.location != NSNotFound) {
                    NSString *secres = substring(check2,9);
                    if([secres isEqualToString:@"Tweaks"]) {
                        [fix3 addObject:@"tweak"];
                    }else if([secres isEqualToString:@"System"]) {
                        [fix3 addObject:@"tool"];
                    }else if([secres isEqualToString:@"Utilities"]) {
                        [fix3 addObject:@"app"];
                    }else if([secres isEqualToString:@"Terminal_Support"] || [secres isEqualToString:@"Terminal Support"]) {
                        [fix3 addObject:@"terminal"];
                    }else if([secres isEqualToString:@"Development"]) {
                        [fix3 addObject:@"library"];
                    }else if([secres isEqualToString:@"Themes"]) {
                        [fix3 addObject:@"theme"];
                    }else if([secres isEqualToString:@"Packaging"]) {
                        [fix3 addObject:@"packaging"];
                    }else if([secres isEqualToString:@"Data_Storage"]) {
                        [fix3 addObject:@"data"];
                    }else if([secres isEqualToString:@"Security"]) {
                        [fix3 addObject:@"key"];
                    }else if([secres isEqualToString:@"Archiving"]) {
                    [fix3 addObject:@"graph"];
                    }else if([secres isEqualToString:@"Scripting"]) {
                        [fix3 addObject:@"script"];
                    }else if([secres isEqualToString:@"Networking"]) {
                        [fix3 addObject:@"network"];
                    }else if([secres isEqualToString:@"Administration"]) {
                        [fix3 addObject:@"setting"];
                    }else{
                        [fix3 addObject:@"icon"];
                    }//endif
                }//endif
            }//endif
        }//endfor
    }//endfor

    NSString *str = [fix componentsJoinedByString:@"\n"];

    NSArray *zzz = [str componentsSeparatedByString:@" "];

    z = [zzz componentsJoinedByString:@"\n"];

    NSArray *ab = [z splitNewLine];


    for(int a=0;a<ab.count;a++) {
        NSString *ch = [ab objectAtIndex:a];
        
        if(![ch isEqualToString:@"Package:"]){
            [resultarr addObject:ch];
        }
    }

    for(int q=0;q<fix.count;q++) {    
        NSString *ch2 = [fix2 objectAtIndex:q];
        [resultarr2 addObject:ch2];
    }

    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,W,H)];
    sv.backgroundColor =  [UIColor colorWithRed:255.0/255.0 green:153.0/255.0 blue:50.0/255.0 alpha:
255.0/255.0];
    UIView *uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, W, 60*(resultarr.count))];
   
    for(int b=0;b<resultarr.count;b++) {
        NSString *cho = [resultarr objectAtIndex:b]; 
        NSString *cho2 = [resultarr2 objectAtIndex:b];

        NSString *sectionimage = [fix3 objectAtIndex:b];
        int tweaker = 0;
        if([sectionimage isEqualToString:@"tweak"]) {
            tweaker = tweak;
        }else if([sectionimage isEqualToString:@"tool"]) {
            tweaker = tool;
        }else if([sectionimage isEqualToString:@"icon"]) {
            tweaker = icon;
        }else if([sectionimage isEqualToString:@"app"]) {
            tweaker = app;
        }else if([sectionimage isEqualToString:@"terminal"]) {
            tweaker = terminal;
        }else if([sectionimage isEqualToString:@"library"]) {
            tweaker = library;
        }else if([sectionimage isEqualToString:@"theme"]) {
            tweaker = theme;
        }else if([sectionimage isEqualToString:@"packaging"]) {
            tweaker = packaging;
        }else if([sectionimage isEqualToString:@"data"]) {
            tweaker = data;
        }else if([sectionimage isEqualToString:@"key"]) {
            tweaker = key;
        }else if([sectionimage isEqualToString:@"graph"]) {
            tweaker = graph;
        }else if([sectionimage isEqualToString:@"script"]) {
            tweaker = script;
        }else if([sectionimage isEqualToString:@"network"]) {
            tweaker = network;
        }else if([sectionimage isEqualToString:@"setting"]) {
            tweaker = setting;
        }  

        iconimage = [UIImage imageWithContentsOfFile:[viewArray objectAtIndex:tweaker]];
        iconimageview = [[UIImageView alloc] initWithImage:iconimage];
        //dockImageView.userInteractionEnabled = YES;
        iconimageview.frame = CGRectMake(0,60*b,40,40);
        [uv addSubview:iconimageview];

        UILabel *label2 = [[UILabel alloc] init];
        label2.frame = CGRectMake(0, (60*b)-15, 3*(W/4), 60);
        //label2.backgroundColor = [UIColor yellowColor];
        label2.textColor = [UIColor blueColor];
        label2.font = [UIFont fontWithName:@"AppleGothic" size:16];
        label2.text = cho2;
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [uv addSubview:label2];

        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 60*b,3*(W/4), 60);
        label.backgroundColor = [UIColor colorWithRed:10.0/255.0 green:200.0/255.0 blue:50.0/255.0 alpha:
    255.0/255.0];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"AppleGothic" size:12];
        label.text = cho;
        [sv addSubview:label];

        UISwitch *sw = [[UISwitch alloc] init];
        sw.center = CGPointMake(W-50,22+60*b);
        sw.on = NO;
        sw.tag = b+1;
        [sw addTarget:self action:@selector(hoge:) forControlEvents:UIControlEventValueChanged];
        [uv addSubview:sw];

    }

    [sv addSubview:uv];
    sv.contentSize = uv.bounds.size;
    [self.view addSubview:sv];

}
-(void)hoge:(UIButton*)sender {
       NSString *fzf = [resultarr objectAtIndex:sender.tag-1];
       NSString *abcz = [fff componentsJoinedByString:@"\n"];
       NSRange rang = [abcz rangeOfString:fzf];
       if(rang.location == NSNotFound) {
            [fff addObject:fzf];
       }else{
            [fff removeObject:fzf];
       }
}
-(void)addButtonTapped:(UIButton *)sender {
   muarr = [@[] mutableCopy];//init array
   muarr2 = [@[] mutableCopy];//init artay
    //NSString *bdh = [NSString stringWithFormat:@"%d",countt];
   NSString *abcz = [fff componentsJoinedByString:@"\n"];
   UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Do you want to delete these packages??" 
    message:abcz 
    preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"YES" 
    style:UIAlertActionStyleDefault 
    handler:^(UIAlertAction *action) {
        for(int b=0;b<fff.count;b++) {
            NSString *rem = [fff objectAtIndex:b];
            NSString *remove = [NSString stringWithFormat:@"dpkg -r %@",rem];

            NSTask *task  = [[NSTask alloc] init];
            NSPipe *pipe  = [[NSPipe alloc] init];
            NSPipe *errPipe = [NSPipe pipe];
            [task setStandardError:errPipe];
            [task setLaunchPath: @"/bin/sh"];
            [task setArguments: [NSArray arrayWithObjects:@"-c",remove,nil]];
            [task setStandardOutput:pipe];
            [task launch];
            NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
            NSData *errdata = [[errPipe fileHandleForReading] readDataToEndOfFile];

            resulterr = [[NSString alloc] initWithData:errdata
encoding:NSUTF8StringEncoding];
            NSString *result = [[NSString alloc] initWithData:data
encoding:NSUTF8StringEncoding];
            NSString *result1 = @"";
            NSString *result2 = @"";

            if(resulterr.length < 2) {
                result1 = result;
                result2 = [NSString stringWithFormat:@"%@ : Success",rem];
                [muarr addObject:result2];
                [muarr2 addObject:result1];
            }else{
                result1 = resulterr;
                result2 = [NSString stringWithFormat:@"%@ : Failed",rem];
                [muarr addObject:result2];
                [muarr2 addObject:result1];
            }
        }

        NSString *stringg = [muarr componentsJoinedByString:@"\n"];

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log" 
        message:stringg 
        preferredStyle:UIAlertControllerStyleAlert];

        [alertController addAction:[UIAlertAction actionWithTitle:@"View Log" 
        style:UIAlertActionStyleDefault 
        handler:^(UIAlertAction *action) {
            NSString *sssss = [muarr2 componentsJoinedByString:@"\n\n"];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log List" 
            message:sssss 
            preferredStyle:UIAlertControllerStyleAlert];

            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" 
            style:UIAlertActionStyleDefault 
            handler:^(UIAlertAction *action) {
            }]];

            [self presentViewController:alertController animated:YES completion:nil];

        }]];
    

        [alertController addAction:[UIAlertAction actionWithTitle:@"Respring" 
        style:UIAlertActionStyleDefault 
        handler:^(UIAlertAction *action) {
            system("killall -9 SpringBoard");
        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"UICache" 
        style:UIAlertActionStyleDefault 
        handler:^(UIAlertAction *action) {
            system("uicache -a");
        }]];

        [alertController addAction:[UIAlertAction actionWithTitle:@"Kill this app" 
        style:UIAlertActionStyleDefault 
        handler:^(UIAlertAction *action) {
            system("killall -9 TweakDeleter");
        }]];
    
        [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" 
        style:UIAlertActionStyleDefault 
        handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }]];

    [alertController addAction:[UIAlertAction actionWithTitle:@"cancel" 
    style:UIAlertActionStyleDefault 
    handler:^(UIAlertAction *action) {
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)deleteButtonTapped:(UIButton*)sender {
    MenuViewController *vc = [[MenuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
