//
//  UIImage+Edit.h
//  ImageEdit
//
//  Created by youyang on 2017/7/7.
//  Copyright © 2017年 youyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Edit)

/**
 将图片方面变成 UIImageOrientationUp 注意先改方向再剪切和压缩

 @return 头朝上图片
 */
- (UIImage *)graphicsOrientationUp;

/**
 根据新尺寸裁剪图片

 @param newSize 传入尺寸
 @return 返回新图片
 */
- (UIImage *)graphicsCompressionWithNewSize:(CGSize)newSize;

/**
 *  根据最小宽度裁剪图片
 *
 *  @param minWidth 传入指定宽度 、 高度会按比例计算
 *
 *  @return 返回新图片
 */
- (UIImage *)graphicsCompressionWithMinWidth:(CGFloat)minWidth;

/**
 *  根据比例裁剪图片 尺寸
 *
 *  @param scale 传入0~1之间的数
 *
 *  @return 返回新的照片
 */
- (UIImage *)graphicsCompressionWithScale:(CGFloat)scale;

/**
 *  获取原图的数据流
 *
 *  @return PNG格式的图片流
 */
- (NSData *)graphicsPNGImage;

/**
 *  获取压缩图的数据流：此压缩仅仅压缩图片质量不压缩图片尺寸
 *
 *  @param scale 质量比例
 *
 *  @return JPEG格式的图片流
 */
- (NSData *)graphicsJPEGImageWithScale:(CGFloat)scale;

@end
