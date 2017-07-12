//
//  UIImage+Edit.m
//  ImageEdit
//
//  Created by youyang on 2017/7/7.
//  Copyright © 2017年 youyang. All rights reserved.
//

#import "UIImage+Edit.h"

@implementation UIImage (Edit)

- (UIImage *)graphicsOrientationUp
{
    if (self.imageOrientation == UIImageOrientationUp)
    {
        return self;
    }
    CGAffineTransform transform = CGAffineTransformIdentity;
    switch (self.imageOrientation)
    {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    switch (self.imageOrientation)
    {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

- (UIImage *)graphicsCompressionWithNewSize:(CGSize)newSize
{
    if (newSize.width <= 0)
    {
        NSLog(@"宽度0裁剪没意义");
        return self;
    }
    if (newSize.height <= 0)
    {
        NSLog(@"高度0裁剪没意义");
        return self;
    }
    UIImage *sourceImage = [self copy];
    if (CGSizeEqualToSize(sourceImage.size, newSize))
    {
        NSLog(@"和原图尺寸一样不需要裁剪");
        return self;
    }
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(!newImage)
    {
        NSLog(@"裁剪出错");
        return self;
    }
    return newImage ;
}

- (UIImage *)graphicsCompressionWithMinWidth:(CGFloat)minWidth
{
    if (minWidth <= 0)
    {
        NSLog(@"宽度0裁剪没意义");
        return self;
    }
    if (self.size.width <= minWidth)
    {
        NSLog(@"宽度小于最小宽度不用裁剪");
        return self;
    }
    // 1.根据比例求新高度
    CGFloat bili = self.size.width / minWidth;
    CGFloat minHeight = (self.size.height / bili);
    minHeight = [[NSString stringWithFormat:@"%.2f",minHeight] floatValue];
    CGSize newSize = CGSizeMake(minWidth, minHeight);
    // 开始准备渲染
    UIImage *newImage = [self graphicsCompressionWithNewSize:newSize];
    return newImage;
}

- (UIImage *)graphicsCompressionWithScale:(CGFloat)scale
{
    if (scale < 0.0f || scale > 1.0f)
    {
        NSLog(@"超过设置范围");
        return self;
    }
    CGFloat newWidth = self.size.width * scale;
    CGFloat newHeight = self.size.height * scale;
    UIImage *newImage = [self graphicsCompressionWithNewSize:CGSizeMake(newWidth, newHeight)];
    return newImage;
}

- (NSData *)graphicsPNGImage
{
    NSData *imgData = UIImagePNGRepresentation(self);
    return imgData;
}

- (NSData *)graphicsJPEGImageWithScale:(CGFloat)scale
{
    if (scale <= 0 ||scale > 1)
    {
        scale = 0.9;// 和png压缩是一个质量
    }
    NSData *imgData = UIImageJPEGRepresentation(self, scale);
    return imgData;
}

@end
