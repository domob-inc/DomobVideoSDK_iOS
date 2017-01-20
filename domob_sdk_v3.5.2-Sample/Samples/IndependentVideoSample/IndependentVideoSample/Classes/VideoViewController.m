//
//  ViewController.m
//  AssetZoneVideoSample
//
//  Created by wangxijin on 8/11/14.
//  Copyright (c) 2014 domob. All rights reserved.
//

#import "VideoViewController.h"
#import "IndependentVideoManager.h"

@interface VideoViewController () <IndependentVideoManagerDelegate>{
    
    IndependentVideoManager *_manager;

}

@property (retain, nonatomic) IBOutlet UILabel *label;
@property (retain, nonatomic) IBOutlet UIButton *playButton;
@end

@implementation VideoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"视频"];
    
    _playButton.enabled = NO;
        
    //初始化方法 96ZJ2RsQzeNxTwTCsB 96ZJ36PAzfhNjwTPP6
    _manager = [[IndependentVideoManager alloc] initWithPublisherID:@"96ZJ0jAwzfkVnwTPKY" andUserID:nil];
    //设置代理
    _manager.delegate = self;
    
    //是否禁用提示框,默认为NO
    _manager.disableShowAlert = NO;
    
}

#pragma mark - UIResponder
- (IBAction)showVideo{
    
    [_manager presentIndependentVideo];
}

- (IBAction)playVideo {
    
    [_manager presentIndependentVideo];
    
}

- (IBAction)checkVideoAvailable {
    [_manager checkVideoAvailable];

}

#pragma mark - Manager Delegate
// 开始加载视频
- (void)ivManagerDidStartLoad:(IndependentVideoManager *)manager {
    
    NSLog(@"<demo>VideoDidStartLoad");
}

// 在有视频的情况下是否加载完成。
- (void)ivManagerDidFinishLoad:(IndependentVideoManager *)manager finished:(BOOL)isFinished
{
    NSLog(@"<demo>VideoDidFinishLoad--%d",isFinished);
    if (isFinished) {
        //加载完让按钮可用
        _playButton.enabled = YES;
    }else {
        _playButton.enabled = NO;
    }
}

// 视频加载失败。可能的原因由error部分提供，例如网络连接失败、被禁用等。
- (void)ivManager:(IndependentVideoManager *)manager
failedLoadWithError:(NSError *)error {
    
    NSLog(@"<demo>VideoFailedLoadWithError:%@",error);
}

// 当视频要被呈现出来时，回调该方法
- (void)ivManagerWillPresent:(IndependentVideoManager *)manager {
    _playButton.enabled = NO;
    NSLog(@"<demo>VideoWillPresent");
}

// 当视频被关闭。
- (void)ivManagerDidClosed:(IndependentVideoManager *)manager {
    
    NSLog(@"<demo>VideoDidClosed");
    _playButton.enabled = NO;
    _label.text = @"";
    [manager checkVideoAvailable];
}
// 视频播放完成
- (void)ivManagerCompletePlayVideo:(IndependentVideoManager *)manager{
    
    NSLog(@"<demo>VideoCompletePlay");

}

// 播放视频失败
- (void)ivManagerPlayIndependentVideo:(IndependentVideoManager *)manager
                            withError:(NSError *)error {
    NSLog(@"PlayVideoWithError:%@",error);
}

// 检查服务端是否有视频可下载
- (void)ivManager:(IndependentVideoManager *)manager
isIndependentVideoAvailable:(BOOL)available {
      
    if (available) {
        _label.text = [NSString stringWithFormat:@"有视频"];
        NSLog(@"有视频");
    }
    else {
        _label.text = [NSString stringWithFormat:@"暂无视频"];
        NSLog(@"无视频");
    }
}

@end
