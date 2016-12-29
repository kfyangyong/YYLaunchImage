//
//  YYLaunchViewManager.h
//  YYLaunchImage
//
//  Created by ayong on 2016/12/29.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYAdModel;
@interface YYLaunchViewManager : UIView

@property (nonatomic , strong) YYAdModel *adModel;

+ (instancetype)shareManager; //初始化

- (void)showView:(UIView *)view; //调用
@end
