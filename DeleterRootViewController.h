@interface DeleterRootViewController : UIViewController

@property (nonatomic, retain) UIBarButtonItem *killButton;
@property (nonatomic, retain) UIBarButtonItem *allkillButton;
    - (void)addButtonTapped:(UIButton *)sender;
    - (void)deleteButtonTapped:(UIButton *)sender;

@end
