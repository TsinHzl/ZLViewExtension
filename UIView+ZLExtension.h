//
//  UIView+ZLExtension.h
//
//  Created by hezhonglin on 16/8/12.
//  Copyright © 2016年 zeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZLExtension)

@property(nonatomic, assign)CGFloat zl_x;
@property(nonatomic, assign)CGFloat zl_y;
@property(nonatomic, assign)CGPoint zl_origin;

@property(nonatomic, assign)CGFloat zl_width;
@property(nonatomic, assign)CGFloat zl_height;
@property(nonatomic, assign)CGSize zl_size;

@property(nonatomic, assign)CGFloat zl_centerX;
@property(nonatomic, assign)CGFloat zl_centerY;

@property(nonatomic, assign)CGFloat zl_rightLine;
@property(nonatomic, assign)CGFloat zl_bottmLine;

- (void)setRoundViewWithCornerRaidus:(CGFloat)cornerRadius;
- (void)setRoundView;

#pragma mark - 高效设置圆角，这种不会触发离屏渲染,直接通过layer设置

/// 设置顶部两角为圆角的view
/// @param cornerRadius radius
/// @param bgColor 背景颜色
- (CAShapeLayer *)zl_setTopCornerWithRadius:(CGFloat)cornerRadius bgColor:(UIColor *)bgColor;

/// 设置底部两角为圆角的view
/// @param cornerRadius radius
/// @param bgColor 背景颜色
- (CAShapeLayer *)zl_setBottomCornerWithRadius:(CGFloat)cornerRadius bgColor:(UIColor *)bgColor;

/// 设置底部四角为圆角的view
/// @param cornerRadius radius
/// @param bgColor 背景颜色
- (CAShapeLayer *)zl_setRoundCornerWithRadius:(CGFloat)cornerRadius bgColor:(UIColor *)bgColor;

- (void)setBorderWithColor:(UIColor *)color;
- (void)setBorderWidth:(CGFloat)width;
/**
 *  @判断view是否显示
 */
- (BOOL)isShowingOnKeyWindow;



@end
