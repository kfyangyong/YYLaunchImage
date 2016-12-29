//
//  YYLaunchViewManager.m
//  YYLaunchImage
//
//  Created by ayong on 2016/12/29.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYLaunchViewManager.h"
#import "YYLaunchView.h"
#import "YYAdModel.h"
#import "UIImage+YYLaunchImage.h"
#import "UIImageView+WebCache.h"
#import "YYAdvertisementVC.h"

@interface YYLaunchViewManager ()

@property (nonatomic, weak) YYLaunchView *launchView;
@property (nonatomic, strong) dispatch_source_t timer;

@end
@implementation YYLaunchViewManager

static int timeLong = 3; //时长

+ (instancetype)shareManager{
    return [[[self class] alloc] init];
}

- (void)showView:(UIView *)view{
    self.frame=view.bounds;
    [view addSubview:self];
    [self addADLaunchView];
    [self loadData];
}

- (void)addADLaunchView
{
    YYLaunchView *adLaunchView = [[YYLaunchView alloc]init];
    adLaunchView.skipBtn.hidden = YES;
    adLaunchView.launchImageView.image = [UIImage getImage]; //获取Launchimage
    adLaunchView.frame=self.bounds;
    [adLaunchView.skipBtn addTarget:self action:@selector(skipADAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:adLaunchView];
    _launchView = adLaunchView;
}

- (void)loadData{
    if (self.adModel.launchUrl && self.adModel.launchUrl.length > 0) {
        [self showADImageWithUrl:self.adModel.launchUrl];
        UITapGestureRecognizer * tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushAdController)];
        [self.launchView addGestureRecognizer:tap];
    }else{
        [self dismiss];
    }
}

- (void)showADImageWithUrl:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    __weak typeof(self) weakSelf = self;
    [self.launchView.adImageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [weakSelf scheduledGCDTimer];
    }];
}

- (void)scheduledGCDTimer
{
    [self cancleGCDTimer];
    __block int timeLeave = timeLong; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    __typeof (self) __weak weakSelf = self;
    dispatch_source_set_event_handler(_timer, ^{
        if(timeLeave <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(weakSelf.timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self dismiss]; //关闭界面
            });
        }else{
            int curTimeLeave = timeLeave;
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf showSkipBtnTitleTime:curTimeLeave];
            });
            --timeLeave;
        }
    });
    dispatch_resume(_timer);
}

- (void)cancleGCDTimer
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}


- (void)showSkipBtnTitleTime:(int)timeLeave
{
    NSString *timeLeaveStr = [NSString stringWithFormat:@"跳过 %ds",timeLeave];
    [_launchView.skipBtn setTitle:timeLeaveStr forState:UIControlStateNormal];
    _launchView.skipBtn.hidden = NO;
}

#pragma mark - action
- (void)skipADAction
{
    [self dismiss];
}

-(void)pushAdController{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
        YYAdvertisementVC * adVc=[[YYAdvertisementVC alloc]init];
        adVc.adModel=self.adModel;
        adVc.hidesBottomBarWhenPushed=YES;  //隐藏tabbarItem
        [[UIApplication sharedApplication].keyWindow.rootViewController.childViewControllers[0] pushViewController:adVc animated:YES];
    });
    
}
- (void)dismiss{
    [self cancleGCDTimer];
    //消失动画
    [UIView animateWithDuration:0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformMakeScale(1, 1);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)dealloc
{
    [self cancleGCDTimer];
}

-(void)show
{
    [self addADLaunchView];
    [self loadData];
}

@end
