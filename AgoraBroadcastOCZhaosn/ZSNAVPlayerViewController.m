//
//  ZSNAVPlayerViewController.m
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2022/11/21.
//

#import "ZSNAVPlayerViewController.h"
#import <AVKit/AVKit.h>

@interface ZSNAVPlayerViewController ()

@end

@implementation ZSNAVPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
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
    
    NSURL *url = [NSURL URLWithString:@"https://sud-static-a-cf.sudden.ltd/game/ludo/sounds/throw.mp3"];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        
    playerLayer.frame = CGRectMake(10, 250, self.view.frame.size.width, 200);
    [self.view.layer addSublayer:playerLayer];
    
    [player play];
    
    
    
}

- (void)btnClickActionb:(id)sender {
    
}

@end
