//
//  LYViewController.m
//  LTAlertView
//
//  Created by yjpal on 10/13/2016.
//  Copyright (c) 2016 yjpal. All rights reserved.
//

#import "LYViewController.h"
#import "LTAlertView.h"

@interface LYViewController ()<LTAlertViewDelegate>{

    LTAlertView *alert;
}

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"UIScreen=%@",NSStringFromCGRect([UIScreen mainScreen].bounds));
    NSLog(@"window=%@",NSStringFromCGRect(self.view.window.bounds));
    
//    if (!alert) {
    
        alert = [LTAlertView LT_showAlertViewWithTitle:@"标题"
                                               message:@"weqwq3"
                                      clickButtonBlock:^(LTAlertView * _Nonnull alertView, NSString * _Nonnull buttonTitle) {
                                          
                                          NSLog(@"buttonTitle=%@",buttonTitle);
                                      }
                                          buttonTitles:@"1",@"2", nil];
//    }
    
    NSString *measage = @"weqwq34w";
    
    measage = [NSString stringWithFormat:@"%@--%@",alert.message,measage];
    alert.message = measage;
//    [alert lt_show];
//    [alert lt_addButtonWithTitle:@"13213213"];
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    LYViewController *vc =[sb instantiateViewControllerWithIdentifier:@"LYViewController"];
//    [self presentViewController:vc animated:YES completion:nil];
    
//    LTAlertView *view = [LTAlertView alertViewWithTitle:@"这是一个标题" message:@"这是内容吗？\n这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？这是内容吗？"];
//    LTAlertView *view = [LTAlertView alertViewWithTitle:@"这是一个标题" message:@"这是内容吗？\n这是"];
//    LTAlertView *view = [[LTAlertView alloc]init];
//    view.title = @"121243232";
//    view.message = @"这是内容吗？这是内容吗？这是内容吗？这是内容";
////    view.neverHide = YES;
//    [view lt_addButtonWithTitle:@"23213213213"];
////    [view lt_addButtonWithTitle:@"222"];
////    [view lt_addButtonWithTitle:@"3333"];
//    [view lt_addButtonWithConfigurationHandler:^(UIButton * _Nonnull button) {
//        
//        [button setTitle:@"111" forState:UIControlStateNormal];
//    }];
////    [view lt_addButtonWithConfigurationHandler:^(UIButton * _Nonnull button) {
////        
////        [button setTitle:@"222" forState:UIControlStateNormal];
////    }];
////    [view lt_addButtonWithConfigurationHandler:^(UIButton * _Nonnull button) {
////        
////        [button setTitle:@"333" forState:UIControlStateNormal];
////    }];
////    [view lt_addButtonWithTitle:@"222=="];
//    
//    view.delegate = self;
//    [view setClickButtonBlock:^(LTAlertView * _Nonnull alertView, NSString * _Nonnull title) {
//        
//        NSLog(@"title=%@",title);
//    }];
//    [view lt_show];
//    
//    [self adddtitle:view];
    
    static NSInteger i = 0;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (i < 10) {
            
            [self touchesBegan:touches withEvent:event];
            i++;
        }
    });
}

- (void)adddtitle:(LTAlertView *)view{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        view.message = [NSString stringWithFormat:@"%@,%@",view.message,view.message];
        [self adddtitle:view];
    });
}

-(void)ltAlertView:(LTAlertView *)alertView clickButtonTitle:(NSString *)buttonTitle{

    NSLog(@"buttonTitle=%@",buttonTitle);
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationPortrait|
    UIInterfaceOrientationPortraitUpsideDown|
    UIInterfaceOrientationLandscapeLeft
    |UIInterfaceOrientationLandscapeRight;
}

@end
