//
//  UIView+ZLExtension.m
//
//  Created by hezhonglin on 16/8/12.
//  Copyright © 2016年 zeb. All rights reserved.
//

#import "UIView+ZLExtension.h"

@implementation UIView (ZLExtension)
//X
-(CGFloat)zl_x
{
    return self.frame.origin.x;
}
- (void)setZl_x:(CGFloat)zl_x
{
    CGRect frame = self.frame;
    frame.origin.x = zl_x;
    self.frame = frame;
}

//Y
- (CGFloat)zl_y
{
    return self.frame.origin.y;
}
- (void)setZl_y:(CGFloat)zl_y
{
    CGRect frame = self.frame;
    frame.origin.y = zl_y;
    self.frame = frame;
}

//点
- (CGPoint)zl_origin
{
    return self.frame.origin;
}
- (void)setZl_origin:(CGPoint)zl_origin
{
    CGRect frame = self.frame;
    frame.origin = zl_origin;
    self.frame = frame;
}

//宽度
- (CGFloat)zl_width
{
    return self.frame.size.width;
}
- (void)setZl_width:(CGFloat)zl_width
{
    CGRect frame = self.frame;
    frame.size.width = zl_width;
    self.frame = frame;
}

//高度
- (CGFloat)zl_height
{
    return self.frame.size.height;
}
- (void)setZl_height:(CGFloat)zl_height
{
    CGRect frame = self.frame;
    frame.size.height = zl_height;
    self.frame = frame;
}

//size
- (CGSize)zl_size
{
    return self.frame.size;
}
- (void)setZl_size:(CGSize)zl_size
{
    CGRect frame = self.frame;
    frame.size = zl_size;
    self.frame = frame;
}

//中心点X
- (CGFloat)zl_centerX
{
    return self.center.x;
}
- (void)setZl_centerX:(CGFloat)zl_centerX
{
    CGPoint center = self.center;
    center.x = zl_centerX;
    self.center = center;
}

//中心点Y
- (CGFloat)zl_centerY
{
    return self.center.y;
}
- (void)setZl_centerY:(CGFloat)zl_centerY
{
    CGPoint center = self.center;
    center.y = zl_centerY;
    self.center = center;
}

- (void)setRoundViewWithCornerRaidus:(CGFloat)cornerRadius
{
//    [self zl_addRounderCornerWithRadius:cornerRadius size:self.zl_size];
    
    self.layer.masksToBounds = YES;//self.clipsToBounds = YES;这两个是等同的
    self.layer.cornerRadius = cornerRadius;
}

- (void)setRoundView {
    [self setRoundViewWithCornerRaidus:self.zl_height/2.0];
}

- (void)setBorderWithColor:(UIColor *)color {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.masksToBounds = YES;
}


- (void)setBorderWidth:(CGFloat)width {
    self.layer.borderWidth = width;
}
/**
 *  @判断view是否显示
 */
- (BOOL)isShowingOnKeyWindow
{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

/**
 get和set view的右边线的值

 @return  view右边线的值
 */
- (CGFloat)zl_rightLine
{
//    return self.zl_x + self.zl_width;
    return CGRectGetMaxX(self.frame);
}
- (void)setZl_rightLine:(CGFloat)zl_rightLine
{
    CGRect f = self.frame;
    f.origin.x = zl_rightLine - self.zl_width;
    self.frame = f;
}

/**
 get和set view底部的线的值

 @return  view的底部线的值
 */
- (CGFloat)zl_bottmLine
{
    return CGRectGetMaxY(self.frame);
}
- (void)setZl_bottmLine:(CGFloat)zl_bottmLine
{
    CGRect f = self.frame;
    f.origin.y = zl_bottmLine - self.zl_height;
    self.frame = f;
}


#pragma mark - 高效设置圆角，这种不会触发离屏渲染,直接通过layer设置

- (void)zl_addRounderCornerWithRadius:(CGFloat)radius size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef cxt = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(cxt, self.backgroundColor.CGColor);
    CGContextSetStrokeColorWithColor(cxt, self.backgroundColor.CGColor);

    CGContextMoveToPoint(cxt, size.width, size.height-radius);
    CGContextAddArcToPoint(cxt, size.width, size.height, size.width-radius, size.height, radius);//右下角
    CGContextAddArcToPoint(cxt, 0, size.height, 0, size.height-radius, radius);//左下角
    CGContextAddArcToPoint(cxt, 0, 0, radius, 0, radius);//左上角
    CGContextAddArcToPoint(cxt, size.width, 0, size.width, radius, radius);//右上角
    CGContextClosePath(cxt);
    CGContextDrawPath(cxt, kCGPathFillStroke);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    [imageView setImage:image];
    [self insertSubview:imageView atIndex:0];
}

/// 设置顶部两角为圆角的view
/// @param cornerRadius radius
/// @param bgColor 背景颜色
- (CAShapeLayer *)zl_setTopCornerWithRadius:(CGFloat)cornerRadius bgColor:(UIColor *)bgColor {
    CAShapeLayer *layer = CAShapeLayer.layer;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    layer.path = path.CGPath;
    layer.fillColor = bgColor.CGColor;
    [self.layer insertSublayer:layer atIndex:0];
    return layer;
}

/// 设置底部两角为圆角的view
/// @param cornerRadius radius
/// @param bgColor 背景颜色
- (CAShapeLayer *)zl_setBottomCornerWithRadius:(CGFloat)cornerRadius bgColor:(UIColor *)bgColor {
    CAShapeLayer *layer = CAShapeLayer.layer;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    layer.path = path.CGPath;
    layer.fillColor = bgColor.CGColor;
    [self.layer insertSublayer:layer atIndex:0];
    return layer;
}

/// 设置底部四角为圆角的view
/// @param cornerRadius radius
/// @param bgColor 背景颜色
- (CAShapeLayer *)zl_setRoundCornerWithRadius:(CGFloat)cornerRadius bgColor:(UIColor *)bgColor {
    CAShapeLayer *layer = CAShapeLayer.layer;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
    layer.path = path.CGPath;
    layer.fillColor = bgColor.CGColor;
    [self.layer insertSublayer:layer atIndex:0];
    return layer;
}

@end
