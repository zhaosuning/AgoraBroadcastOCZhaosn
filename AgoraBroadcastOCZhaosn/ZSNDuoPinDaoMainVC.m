//
//  ZSNDuoPinDaoMainVC.m
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2023/4/14.
//

#import "ZSNDuoPinDaoMainVC.h"
#import "ZSNDuoPinDaoZhuPinDaoVC.h"
#import "ZSNDuoPinDaoChooseVC.h"

@interface ZSNDuoPinDaoMainVC ()

@end

@implementation ZSNDuoPinDaoMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    UILabel * lblTopTitle = [[UILabel alloc] init];
    lblTopTitle.frame = CGRectMake([[UIScreen mainScreen] bounds].size.width / 2.0 - 50, 45, 100, 40);
    lblTopTitle.text = @"首页";
    lblTopTitle.textColor = [UIColor blueColor];
    lblTopTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lblTopTitle];
    
    
    
    UIButton *btnComBigChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnComBigChannel.frame = CGRectMake(20, 200, 270, 40);
    [btnComBigChannel.layer setCornerRadius:20];
    [btnComBigChannel.layer setMasksToBounds:YES];
    [btnComBigChannel setTitle:@"进入公共大房间" forState:UIControlStateNormal];
    [btnComBigChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnComBigChannel.backgroundColor = [UIColor greenColor];
    btnComBigChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnComBigChannel addTarget:self action:@selector(btnComBigChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnComBigChannel];
    
    UIButton *btnDuoChannel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDuoChannel.frame = CGRectMake(20, 340, 270, 40);
    [btnDuoChannel.layer setCornerRadius:20];
    [btnDuoChannel.layer setMasksToBounds:YES];
    [btnDuoChannel setTitle:@"进入多房间" forState:UIControlStateNormal];
    [btnDuoChannel setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    btnDuoChannel.backgroundColor = [UIColor greenColor];
    btnDuoChannel.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btnDuoChannel addTarget:self action:@selector(btnDuoChannelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDuoChannel];
}

-(void)btnComBigChannelAction:(UIButton *) button {
    NSLog(@"打印了 点击btnComBigChannelAction进入公共大房间");
    ZSNDuoPinDaoZhuPinDaoVC *vc = [[ZSNDuoPinDaoZhuPinDaoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)btnDuoChannelAction:(UIButton *) button {
    NSLog(@"打印了 点击btnDuoChannelAction进入多房间");
    
    ZSNDuoPinDaoChooseVC *vc = [[ZSNDuoPinDaoChooseVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
