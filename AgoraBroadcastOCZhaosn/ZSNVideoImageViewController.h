//
//  ZSNVideoImageViewController.h
//  AgoraBroadcastOCZhaosn
//
//  Created by zhaosuning on 2022/5/10.
//

#import <UIKit/UIKit.h>
#import <AgoraRtcKit/AgoraRtcEngineKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZSNVideoImageViewController : UIViewController <AgoraRtcEngineDelegate , AgoraVideoDataFrameProtocol>

@end

NS_ASSUME_NONNULL_END
