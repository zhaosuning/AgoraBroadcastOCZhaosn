//
//  ZSNFirstViewController.m
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2022/2/23.
//

#import "ZSNFirstViewController.h"
#import "ZSNBroadcastViewController.h"
#import "ZSNComViewController.h"
#import "ZSNVideoImageViewController.h"

@interface ZSNFirstViewController ()

@end

@implementation ZSNFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *clickBtn = [[UIButton alloc] init];
    clickBtn.frame = CGRectMake(10, 90, 100, 40);
    //[clickBtn setImage:[UIImage imageNamed:@"img1"] forState:UIControlStateNormal];
    //[clickBtn setImage:[UIImage imageNamed:@"img2"] forState:UIControlStateHighlighted];
    //[clickBtn setBackgroundImage:[UIImage imageNamed:@"img3"] forState:UIControlStateNormal];
    [clickBtn setTitle:@"点击" forState:UIControlStateNormal];
    clickBtn.backgroundColor = [UIColor redColor];
    [clickBtn setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    clickBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    //[clickBtn addTarget:self action:@selector(btnClickActiona) forControlEvents:UIControlEventTouchUpInside];
    [clickBtn addTarget:self action:@selector(btnClickActionb:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickBtn];
    
    
}

- (void)btnClickActionb:(id)sender {
    ZSNBroadcastViewController *vc = [[ZSNBroadcastViewController alloc] init];
    //ZSNVideoImageViewController * vc = [[ZSNVideoImageViewController alloc] init];
    //ZSNComViewController *vc = [[ZSNComViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)btnClickActiona {
    ZSNBroadcastViewController *vc = [[ZSNBroadcastViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
