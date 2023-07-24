//
//  ZSNComViewController.m
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2022/2/23.
//

#import "ZSNComViewController.h"


@interface ZSNComViewController ()

@end

@implementation ZSNComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播com";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *joinBtn = [[UIButton alloc] init];
    joinBtn.frame = CGRectMake(10, 90, 100, 40);
    [joinBtn setTitle:@"加入频道" forState:UIControlStateNormal];
    joinBtn.backgroundColor = [UIColor redColor];
    [joinBtn setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    joinBtn.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [joinBtn addTarget:self action:@selector(joinBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinBtn];
}

- (void)joinBtnAction:(id)sender {
    
}


@end
