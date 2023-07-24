//
//  ZSNVideoImageViewController.m
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2022/5/10.
//

#import "ZSNVideoImageViewController.h"
#import <AVFoundation/AVFoundation.h>



#define appidb @""

#define channelnameb @""

#define tokenb @""

@interface ZSNVideoImageViewController ()


@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;

// 定义 localView 变量
@property (nonatomic, strong) UIView *localView;
// 定义 remoteView 变量
@property (nonatomic, strong) UIView *remoteView;

//@property (nonatomic, assign) CVPixelBufferRef bufferRef;

@property(nonatomic, copy) NSMutableArray * mutarr;
@property(nonatomic, copy) NSMutableArray * mutarr2;
@property(nonatomic, assign) NSInteger i1;

@property(nonatomic, assign) BOOL b1;

@property (strong,nonatomic) NSTimer *timer;

@end

@implementation ZSNVideoImageViewController

CVPixelBufferRef bufferRef;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"直播页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _b1 = NO;
    _mutarr = [NSMutableArray arrayWithCapacity:1];
    _mutarr2 = [NSMutableArray arrayWithCapacity:1];
    
    UIButton *btnJoinChannel = [[UIButton alloc] init];
    btnJoinChannel.frame = CGRectMake(30, 100, 160, 50);
    [btnJoinChannel setTitle:@"点击进入频道" forState:UIControlStateNormal];
    btnJoinChannel.backgroundColor = [UIColor redColor];
    [btnJoinChannel setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnJoinChannel.titleLabel.font = [UIFont systemFontOfSize:20.0];
    
    [btnJoinChannel addTarget:self action:@selector(btnJoinChannelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnJoinChannel];
    
    
    UIButton *btnLeaveChannel = [[UIButton alloc] init];
    btnLeaveChannel.frame = CGRectMake(30, 160, 100, 40);
    [btnLeaveChannel setTitle:@"离开频道" forState:UIControlStateNormal];
    btnLeaveChannel.backgroundColor = [UIColor redColor];
    [btnLeaveChannel setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnLeaveChannel.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnLeaveChannel addTarget:self action:@selector(btnLeaveChannelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLeaveChannel];
    
    
    UIButton *btnDestroy = [[UIButton alloc] init];
    btnDestroy.frame = CGRectMake(30, 220, 100, 40);
    [btnDestroy setTitle:@"销毁" forState:UIControlStateNormal];
    btnDestroy.backgroundColor = [UIColor redColor];
    [btnDestroy setTitleColor:[UIColor colorWithRed:108/255.0 green:210/255.0 blue:180/255.0 alpha:1.0] forState:UIControlStateNormal];
    btnDestroy.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [btnDestroy addTarget:self action:@selector(btnDestroyClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDestroy];
    
    self.localView = [[UIView alloc] init];
    self.localView.backgroundColor = [UIColor yellowColor];
    self.localView.frame = CGRectMake(10, 280, 150, 150);
    [self.view addSubview:self.localView];
    
    self.remoteView = [[UIView alloc] init];
    self.remoteView.frame = CGRectMake(10, 440, 150, 150);
    self.remoteView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.remoteView];
    
    [self createTimer];

}

//加入频道
- (void)btnJoinChannelClick:(id)sender {
    AgoraRtcEngineConfig * config = [[AgoraRtcEngineConfig alloc] init];
    config.appId = appidb;
    config.areaCode = 0xFFFFFFFF;
    
    AgoraLogConfig *logConfig = [[AgoraLogConfig alloc] init];
    logConfig.level = AgoraLogLevelInfo;
    config.logConfig = logConfig;
    
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config delegate:self];
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
    [self.agoraKit setAudioProfile:AgoraAudioProfileMusicHighQualityStereo scenario:AgoraAudioScenarioGameStreaming];
    
    AgoraClientRoleOptions *clientRoleOption = [[AgoraClientRoleOptions alloc] init];
    clientRoleOption.audienceLatencyLevel = AgoraAudienceLatencyLevelUltraLowLatency;
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    //[self.agoraKit setClientRole:AgoraClientRoleBroadcaster options:clientRoleOption];
    
    [self.agoraKit enableAudio];
    [self.agoraKit enableVideo];
    
    [self.agoraKit setVideoDataFrame:self];
    
    AgoraRtcChannelMediaOptions *mediaOption = [[AgoraRtcChannelMediaOptions alloc] init];
    NSInteger result = [self.agoraKit joinChannelByToken:tokenb channelId:channelnameb info:nil uid:0 options:mediaOption];
    if (result != 0) {
        NSLog(@"打印了 进入频道失败 %ld",(long)result);
    }
    else {
        NSLog(@"打印了 进入频道返回0");
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

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurWarning:(AgoraWarningCode)warningCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOccurError:(AgoraErrorCode)errorCode {
    
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinChannel:(NSString *)channel withUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    [self setupLocalVideo];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didJoinedOfUid:(NSUInteger)uid elapsed:(NSInteger)elapsed {
    [self setupRemoteVideo:uid];
}

- (void)rtcEngine:(AgoraRtcEngineKit *)engine didOfflineOfUid:(NSUInteger)uid reason:(AgoraUserOfflineReason)reason {
    
}


- (BOOL)onRenderVideoFrame:(AgoraVideoDataFrame*)videoFrame forUid:(unsigned int)uid {
    //[self yuvToUIImageWithVideoRawData:videoFrame];
    int i = 0;
    return YES;
}


- (BOOL)onCaptureVideoFrame:(AgoraVideoDataFrame*)videoFrame {
    ++ _i1;
    if (_i1 < 21) {
        [_mutarr addObject:videoFrame];
        NSLog(@"打印了 addObject");
    }
    else {
        _i1 = 21;

    }
    
    
//    int size = videoFrame.width * videoFrame.height;
//    uint8_t *tmp = (uint8_t *)malloc(size * 3/2);
//    memcpy(tmp, videoFrame.yBuffer, size);
//    memcpy(tmp + size, videoFrame.uBuffer, size >> 2);
//    memcpy(tmp+ size + videoFrame.width * videoFrame.height/4, videoFrame.vBuffer, size >> 2);
//    agora::media::ExternalVideoFrame vframe;
//    vframe.stride = frame->yStride;
//    vframe.height = frame->height;
//    vframe.timestamp = static_cast<long long>(GetHighAccuracyTickCount());
//    vframe.rotation = 0;
//    vframe.type = agora::media::ExternalVideoFrame::VIDEO_BUFFER_TYPE::VIDEO_BUFFER_RAW_DATA;
//    vframe.format = agora::media::ExternalVideoFrame::VIDEO_PIXEL_FORMAT::VIDEO_PIXEL_I420;
//    vframe.cropLeft = 0;
//    vframe.cropTop = 0;
//    vframe.cropBottom = 0;
//    vframe.cropRight = 0;
//    vframe.buffer = tmp;
//    agora::util::AutoPtr<agora::media::IMediaEngine> mediaEngine;
//    mediaEngine.queryInterface(rtcEngine_, agora::AGORA_IID_MEDIA_ENGINE);
//
//    if (mediaEngine)
//        mediaEngine->pushVideoFrame(&vframe);
//
//    free(tmp);
    
    
    
    //CVPixelBufferRef bufferRef = [self yuvToUIImageWithVideoRawData:videoFrame];
    
    //__weak typeof(self) wSelf = self;
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        //__strong typeof(wSelf) sSelf = wSelf;
//        if (_i1 < 20) {
//            CVPixelBufferRef bufferRef = [self yuvToUIImageWithVideoRawData:videoFrame];
//        }
//        ++ _i1;
//
//        //int i = 0;
//
//
//    });
    
//
//    dispatch_queue_t q = dispatch_queue_create("queue<1>", DISPATCH_QUEUE_SERIAL);
//        for (int i = 0; i < 3; i++) {
//            dispatch_async(q, ^{
//                NSLog(@"%@ i = %d",[NSThread currentThread],i);
//
//
//            });
//        }
//
//    dispatch_async(q, ^{
//        NSLog(@"%@ i = %d",[NSThread currentThread],i);
//
//        CVPixelBufferRef bufferRef = [self yuvToUIImageWithVideoRawData:videoFrame];
//
//        int i = 0;
//    });
    
    return YES;
}


// AgoraVideoDataFrame 转化成 CVPixelBufferRef
- (CVPixelBufferRef)yuvToUIImageWithVideoRawData:(AgoraVideoDataFrame *)data {
    NSLog(@"打印了yuvToUIImageWithVideoRawData");
    size_t width = data.width;
    size_t height = data.height;
    size_t yStride = data.yStride;
    size_t uvStride = data.uStride;
    
    char* yBuffer = data.yBuffer;
    char* uBuffer = data.uBuffer;
    char* vBuffer = data.vBuffer;
    
    size_t uvBufferLength = height * uvStride;
    char* uvBuffer = (char *)malloc(uvBufferLength);
    for (size_t uv = 0, u = 0; uv < uvBufferLength; uv += 2, u++) {
        // swtich the location of U、V，to NV12
        uvBuffer[uv] = uBuffer[u];
        uvBuffer[uv+1] = vBuffer[u];
        
        int aa = 0;
        
    }
    
    void * planeBaseAddress[2] = {yBuffer, uvBuffer};
    size_t planeWidth[2] = {width, width / 2};
    size_t planeHeight[2] = {height, height / 2};
    size_t planeBytesPerRow[2] = {yStride, uvStride * 2};
    
    CVPixelBufferRef pixelBuffer = NULL;
    CVReturn result = CVPixelBufferCreateWithPlanarBytes(kCFAllocatorDefault,
                                                         width, height,
                                                         kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange,
                                                         NULL, 0,
                                                         2, planeBaseAddress, planeWidth, planeHeight, planeBytesPerRow,
                                                         NULL, NULL, NULL,
                                                         &pixelBuffer);
    if (result != kCVReturnSuccess) {
        NSLog(@"Unable to create cvpixelbuffer %d", result);
    }
    
    UIImage *image = [self CVPixelBufferToImage:pixelBuffer rotation:data.rotation];
    
    CVPixelBufferRelease(pixelBuffer);
    
    if(uvBuffer != NULL) {
        free(uvBuffer);
        uvBuffer = NULL;
    }
    return pixelBuffer;
}


- (UIImage *)CVPixelBufferToImage:(CVPixelBufferRef)pixelBuffer rotation:(int)rotation {
    size_t width, height;
    CGImagePropertyOrientation orientation;
    switch (rotation) {
        case 0:
            width = CVPixelBufferGetWidth(pixelBuffer);
            height = CVPixelBufferGetHeight(pixelBuffer);
            orientation = kCGImagePropertyOrientationUp;
            break;
        case 90:
            width = CVPixelBufferGetHeight(pixelBuffer);
            height = CVPixelBufferGetWidth(pixelBuffer);
            orientation = kCGImagePropertyOrientationRight;
            break;
        case 180:
            width = CVPixelBufferGetWidth(pixelBuffer);
            height = CVPixelBufferGetHeight(pixelBuffer);
            orientation = kCGImagePropertyOrientationDown;
            break;
        case 270:
            width = CVPixelBufferGetHeight(pixelBuffer);
            height = CVPixelBufferGetWidth(pixelBuffer);
            orientation = kCGImagePropertyOrientationLeft;
            break;
        default:
            return nil;
    }
    CIImage *coreImage = [[CIImage imageWithCVPixelBuffer:pixelBuffer] imageByApplyingOrientation:orientation];
    CIContext *temporaryContext = [CIContext contextWithOptions:nil];
    CGImageRef videoImage = [temporaryContext createCGImage:coreImage
                                                   fromRect:CGRectMake(0, 0, width, height)];
    UIImage *finalImage = [[UIImage alloc] initWithCGImage:videoImage];
    CGImageRelease(videoImage);
    return finalImage;
}

//NSTimer
-(void)createTimer{
    
    //初始化
    //_timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
         //执行操作
    //}];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];
    
    //加入runloop循环池
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    //开启定时器
    [_timer fire];
}

-(void)timerStart:(NSTimer *)timer {
    //NSLog(@"%s-----%lf",__func__,timer.timeInterval);
    NSLog(@"打印了timerStart ");
    
    //销毁定时器
    //[_timer invalidate];
    //_timer = nil;
    
    if (!_b1 && _i1 == 21) {
       // _b1 = NO;
        _b1 = YES;
        [_timer invalidate];
        _timer = nil;
        
        
        //_mutarr2 = [_mutarr copy];
        
        
        for (NSInteger i = 0; i < _mutarr.count ; i++) {
            CVPixelBufferRef bufferRef = [self yuvToUIImageWithVideoRawData:_mutarr[i]];
            NSLog(@"打印了PixelBuffer  %@", bufferRef);
        }
    }
    
    
    
    
}



@end
