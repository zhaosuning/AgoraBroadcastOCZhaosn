//
//  ZSNBroadcastViewController.m
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2022/2/23.
//

#import "ZSNBroadcastViewController.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

#define appid @"6cdc3d89980442faba23c9b3d0a95df0"

#define channelname @"zsncna"

#define token @"007eJxTYLC59H/3gaf91j/sA6Z3J1wo+FumfSt0/qvHTaIfOFe9EuRWYDBLTkk2TrGwtLQwMDExSktMSjQyTrZMMk4xSLQ0TUkzqAqdm9IQyMjAkmbCwAiELEAM4jOBSWYwyQIm2RiqivOS8xIZGADJ8CSF"

@interface ZSNBroadcastViewController ()

@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

// 定义 localView 变量
@property (nonatomic, strong) UIView *localView;
// 定义 remoteView 变量
@property (nonatomic, strong) UIView *remoteView;

@end

@implementation ZSNBroadcastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"直播页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnJoinChannel = [[UIButton alloc] init];
    btnJoinChannel.frame = CGRectMake(10, 100, 160, 50);
    [btnJoinChannel setTitle:@"点击进入频道" forState:UIControlStateNormal];
    btnJoinChannel.backgroundColor = [UIColor redColor];
    [btnJoinChannel setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    [btnJoinChannel addTarget:self action:@selector(btnJoinChannelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnJoinChannel];
    
    UIButton *btnRoleBroadcaster = [[UIButton alloc] init];
    btnRoleBroadcaster.frame = CGRectMake(180, 100, 160, 50);
    [btnRoleBroadcaster setTitle:@"变为主播" forState:UIControlStateNormal];
    btnRoleBroadcaster.backgroundColor = [UIColor redColor];
    [btnRoleBroadcaster setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnRoleBroadcaster.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    [btnRoleBroadcaster addTarget:self action:@selector(btnRoleBroadcasterClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRoleBroadcaster];
    
    
    UIButton *btnLeaveChannel = [[UIButton alloc] init];
    btnLeaveChannel.frame = CGRectMake(10, 160, 100, 40);
    [btnLeaveChannel setTitle:@"离开频道" forState:UIControlStateNormal];
    btnLeaveChannel.backgroundColor = [UIColor redColor];
    [btnLeaveChannel setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnLeaveChannel.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnLeaveChannel addTarget:self action:@selector(btnLeaveChannelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLeaveChannel];
    
    UIButton *btnRoleAudience = [[UIButton alloc] init];
    btnRoleAudience.frame = CGRectMake(180, 160, 160, 50);
    [btnRoleAudience setTitle:@"变为观众" forState:UIControlStateNormal];
    btnRoleAudience.backgroundColor = [UIColor redColor];
    [btnRoleAudience setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnRoleAudience.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    [btnRoleAudience addTarget:self action:@selector(btnRoleAudienceClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRoleAudience];
    
    
    UIButton *btnDestroy = [[UIButton alloc] init];
    btnDestroy.frame = CGRectMake(10, 220, 100, 40);
    [btnDestroy setTitle:@"销毁" forState:UIControlStateNormal];
    btnDestroy.backgroundColor = [UIColor redColor];
    [btnDestroy setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnDestroy.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnDestroy addTarget:self action:@selector(btnDestroyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDestroy];
    
    UIButton *btnStartAudioMixing = [[UIButton alloc] init];
    btnStartAudioMixing.frame = CGRectMake(180, 220, 160, 50);
    [btnStartAudioMixing setTitle:@"播放音乐" forState:UIControlStateNormal];
    btnStartAudioMixing.backgroundColor = [UIColor redColor];
    [btnStartAudioMixing setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnStartAudioMixing.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    [btnStartAudioMixing addTarget:self action:@selector(btnStartAudioMixingClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnStartAudioMixing];
    
    self.localView = [[UIView alloc] init];
    self.localView.backgroundColor = [UIColor yellowColor];
    self.localView.frame = CGRectMake(10, 280, 150, 150);
    [self.view addSubview:self.localView];
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.frame = CGRectMake(10, 440, 150, 150);
    self.remoteView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.remoteView];
    
}

//加入频道
- (void)btnJoinChannelClick:(id)sender {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = appid;
    config.areaCode = 0xFFFFFFFF;
    
    AgoraLogConfig *logConfig = [[AgoraLogConfig alloc] init];
    logConfig.level = AgoraLogLevelInfo;
    config.logConfig = logConfig;
    
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQualityStereo scenario:AgoraAudioScenarioGameStreaming];
    
    //[self.agoraKit en];
    [self.agoraKit enableLocalAudio:YES];
    AgoraClientRoleOptions *clientRoleOption = [[AgoraClientRoleOptions alloc] init];
    clientRoleOption.audienceLatencyLevel = AgoraAudienceLatencyLevelUltraLowLatency;
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    //[self.agoraKit setClientRole:AgoraClientRoleBroadcaster options:clientRoleOption];
    //[self.agoraKit setClientRole:AgoraClientRoleAudience];
    
    //[self.agoraKit enableAudio];
    //[self.agoraKit enableVideo];
    
    AgoraRtcChannelMediaOptions *mediaOption = [[AgoraRtcChannelMediaOptions alloc] init];
    NSTimeInterval t1 = [[NSDate date] timeIntervalSinceDate:[NSDate date]];
    NSInteger result = [self.agoraKit joinChannelByToken:token channelId:channelname info:nil uid:0 options:mediaOption];
    NSTimeInterval t2 = [[NSDate date] timeIntervalSinceDate:[NSDate date]];
    NSTimeInterval t3 = t2 - t1;
    if (result != 0) {
        NSLog(@"打印了 进入频道失败 %ld,time %f",(long)result,t3);
    }
    else {
        NSLog(@"打印了 进入频道返回0,time %f",t3);
    }
}
-(void) setupLocalVideo {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = 0;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.localView;
    [self.agoraKit setupLocalVideo:videoCanvas];
}

-(void)setupRemoteVideo: (NSInteger) uid {
    AgoraRtcVideoCanvas *videoCanvas = [[AgoraRtcVideoCanvas alloc] init];
    videoCanvas.uid = uid;
    videoCanvas.renderMode = AgoraVideoRenderModeHidden;
    videoCanvas.view = self.remoteView;
    [self.agoraKit setupRemoteVideo:videoCanvas];
}

//离开频道
- (void)btnLeaveChannelClick:(id)sender {
    [self.agoraKit leaveChannel:^(AgoraChannelStats * _Nonnull stat) {
        NSLog(@"打印了 离开频道 %@",stat);
    }];
}

//销毁
- (void)btnDestroyClick:(id)sender {
    [AgoraRtcEngineKit destroy];
}

-(void)btnRoleBroadcasterClick:(id)sender {
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    NSLog(@"打印了 变为主播");
}

-(void)btnRoleAudienceClick:(id)sender {
    [self.agoraKit setClientRole:AgoraClientRoleAudience];
    NSLog(@"打印了 变为观众");
}


-(void)btnStartAudioMixingClick:(id)sender {
    [self.agoraKit startAudioMixing:@"https://webdemo.agora.io/agora-web-showcase/examples/Agora-Custom-VideoSource-Web/assets/sample.mp4" loopback:NO replace:NO cycle:-1 startPos:0];
    
    //NSString * strurl = [[NSBundle mainBundle] pathForResource:@"daojiangxing" ofType:@"mp3"];
    //[self.agoraKit startAudioMixing:strurl loopback:NO replace:NO cycle:-1 startPos:0];
    NSLog(@"打印了 播放音乐");
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraWarningCode)warningCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraErrorCode)errorCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    //[self setupLocalVideo];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    //[self setupRemoteVideo:uid];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    
}

@end
