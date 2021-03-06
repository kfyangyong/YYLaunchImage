//
//  YYLaunchView.m
//  YYLaunchImage
//
//  Created by ayong on 2016/12/29.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "YYLaunchView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation YYLaunchView

static NSInteger kSkipBtnWidth = 65;
static NSInteger kSkipBtnHeight = 30;
static NSInteger kSkipRightEdging = 20;
static NSInteger kSkipTopEdging = 40;
static NSInteger kAdImageViewHeightEdging = 100;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addlaunchImageView];
        
        [self addAdImageView];
        
        [self addSkipBtn];
    }
    
    return self;
}
- (void)addlaunchImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    _launchImageView = imageView;
}

- (void)addAdImageView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    [self addSubview:imageView];
    _adImageView = imageView;
}

- (void)addSkipBtn
{
    UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    skipBtn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    skipBtn.titleLabel.textColor = [UIColor whiteColor];
    skipBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    skipBtn.alpha = 0.92;
    skipBtn.layer.cornerRadius = 4.0;
    skipBtn.clipsToBounds = YES;
    [self addSubview:skipBtn];
    _skipBtn = skipBtn;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _launchImageView.frame = self.bounds;
    _adImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-100);
    _skipBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - kSkipBtnWidth - kSkipRightEdging, kSkipTopEdging, kSkipBtnWidth, kSkipBtnHeight);
}

@end
