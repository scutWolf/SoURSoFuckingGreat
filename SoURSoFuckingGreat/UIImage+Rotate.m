//
//  UIImage+Rotate.m
//  emoticonMaker
//
//  Created by Wolf on 15/3/26.
//  Copyright (c) 2015年 Wolf. All rights reserved.
//

#import "UIImage+Rotate.h"

@implementation UIImage (Rotate)

-(UIImage *)rotateImageWithRadian:(CGFloat)radian{

    CGSize imgSize = CGSizeMake(self.size.width * self.scale, self.size.height * self.scale);
    CGRect rect = CGRectMake(0, 0, imgSize.width, imgSize.height);
    rect = CGRectApplyAffineTransform(rect, CGAffineTransformMakeRotation(radian));
    CGSize outputSize = CGSizeMake(CGRectGetWidth(rect), CGRectGetHeight(rect));

    UIGraphicsBeginImageContext(outputSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, outputSize.width / 2, outputSize.height / 2);
    CGContextRotateCTM(context, radian);
    CGContextTranslateCTM(context, -imgSize.width / 2, -imgSize.height / 2);
    
    [self drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;

}

@end
