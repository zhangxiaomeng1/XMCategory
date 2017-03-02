//
//  UIView+ITTAdditions.h
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TSJ)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Return the width in portrait or the height in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationWidth;

/**
 * Return the height in portrait or the width in landscape.
 */
@property (nonatomic, readonly) CGFloat orientationHeight;

/**
 * Finds the first descendant view (including this view) that is a member of a particular class.
 */
- (UIView*)descendantOrSelfWithClass:(Class)cls;

/**
 * Finds the first ancestor view (including this view) that is a member of a particular class.
 */
- (UIView*)ancestorOrSelfWithClass:(Class)cls;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

/**
 * Calculates the offset of this view from another view in screen coordinates.
 *
 * otherView should be a parent view of this view.
 */
- (CGPoint)offsetFromView:(UIView*)otherView;

- (id)findFirstResponder;

- (void)pushMasterViewController:(UIViewController*)controller;
+ (void)pushMasterViewController:(UIViewController*)controller;

- (void)pushViewController:(UIViewController*)controller;
+ (void)pushViewController:(UIViewController*)controller;

- (void)popViewController;
+ (void)popViewController;

+ (void)popToRootViewController;

- (void)popMasterViewController;
+ (void)popMasterViewController;

+ (void)popMasterToRootViewController;

- (void)setupBorderWidth:(UIEdgeInsets)widthEdge
                topColor:(UIColor *)topColor
               leftColor:(UIColor *)leftColor
             bottomColor:(UIColor *)bottomColor
              rightColor:(UIColor *)rightColor;

- (void)setupBorderWidth:(UIEdgeInsets)widthEdge
                allColor:(UIColor *)allColor;


/**
 *  取消阴影
 */
- (void)hideShadow;

/**
 *  设置阴影
 *
 *  @param color   颜色
 *  @param offset  位移
 *  @param radius  大小
 *  @param opacity 透明度
 */
- (void)shadowColor:(UIColor*)color shadowOffset:(CGSize)offset shadowRadius:(CGFloat)radius shadowOpacity:(CGFloat)opacity;

/**
 *  设置圆角、边框
 *
 *  @param radius 圆角大小
 *  @param width  边框大小
 *  @param color  边框颜色
 */
- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color;

/**
 *  设置阴影、圆角、边框
 *
 *  @param shadowColor 阴影颜色
 *  @param offset      阴影位移
 *  @param sradius     阴影大小
 *  @param opacity     阴影透明度
 *  @param cradius     圆角大小
 *  @param width       边框大小
 *  @param borderColor 边框颜色
 */
- (void)shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset shadowRadius:(CGFloat)sradius shadowOpacity:(CGFloat)opacity
       cornerRadius:(CGFloat)cradius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;

- (void)shake;

/**
 *  截取当前 view 的截图
 *
 *  @return
 */
- (UIImage *)viewToImage;

- (void) makeRoundCorner;

- (void) makeRound;
@end
