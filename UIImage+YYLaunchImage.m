//
//  UIImage+YYLaunchImage.m
//  YYLaunchImage
//
//  Created by ayong on 2016/12/29.
//  Copyright © 2016年 ayong. All rights reserved.
//

#import "UIImage+YYLaunchImage.h"

@implementation UIImage (YYLaunchImage)

+ (UIImage *)getImage{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    UIImageView * imageView=viewController.view.subviews[0];
    return imageView.image;
}

@end
