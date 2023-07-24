//
//  AppDelegate.m
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2022/2/23.
//

#import "AppDelegate.h"
#import "ZSNFirstViewController.h"
#import "ZSNDuoPinDaoMainVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //给出默认背景颜色，如果此处不给背景颜色，其他页面巧合也没给背景颜色，则进入到页面中时显示黑色
    self.window.backgroundColor = [UIColor whiteColor];
    
    //不带xib的UIViewController
    ZSNFirstViewController *vc = [[ZSNFirstViewController alloc] init];
    
    //带xib的UIViewController
    //SecondViewController *vcs = [[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    
    
    //ZSNDuoPinDaoMainVC *vc = [[ZSNDuoPinDaoMainVC alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    self.window.rootViewController = navi;
    [self.window makeKeyAndVisible];
    
    return YES;
}



@end
