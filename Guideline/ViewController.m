 

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userDefaults = [NSUserDefaults standardUserDefaults];
     
}

- (IBAction)case1:(UIButton *)sender {
    
    NSString *string = @"case1";
       [userDefaults setObject:string forKey:@"case"];
    
    
    
}
- (IBAction)case2:(UIButton *)sender {
    NSString *string = @"case2";
       [userDefaults setObject:string forKey:@"case"];
    
    
    
}

- (IBAction)case3:(UIButton *)sender {
    NSString *string = @"case3";
       [userDefaults setObject:string forKey:@"case"];
     
    
}

@end
