//
//  YYWebViewProgressView.h
//  YYLaunchImage
//
//  Created by ayong on 2016/12/29.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYWebViewProgressView : UIView

/**
 如果未设置，则使用系统默认tintColor
 */
@property (nonatomic ,strong) UIColor *progressBarColor;
/**
 回到初始位置
 */
- (void)reset;
/**
 设置进度条位置
 @param progress 设置的进度条进度
 @param animated 是否需要动画
 */
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
