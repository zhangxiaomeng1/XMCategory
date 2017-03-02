//
//  UIView+ITTAdditions.m
//  iTotemFrame
//
//  Created by jack 廉洁 on 3/15/12.
//  Copyright (c) 2012 iTotemStudio. All rights reserved.
//

#import "UIView+TSJ.h"
#import "AppDelegate.h"
UIInterfaceOrientation ITTInterfaceOrientation() {
    UIInterfaceOrientation orient = [UIApplication sharedApplication].statusBarOrientation;
    return orient;
}

CGRect ITTScreenBounds() {
    CGRect bounds = [UIScreen mainScreen].bounds;
    if (UIInterfaceOrientationIsLandscape(ITTInterfaceOrientation())) {
        CGFloat width = bounds.size.width;
        bounds.size.width = bounds.size.height;
        bounds.size.height = width;
    }
    return bounds;
}
@implementation UIView (ITTAdditions)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationWidth {
    return UIInterfaceOrientationIsLandscape(ITTInterfaceOrientation())
    ? self.height : self.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)orientationHeight {
    return UIInterfaceOrientationIsLandscape(ITTInterfaceOrientation())
    ? self.width : self.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
    CGFloat x = 0, y = 0;
    for (UIView* view = self; view && view != otherView; view = view.superview) {
        x += view.left;
        y += view.top;
    }
    return CGPointMake(x, y);
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)findFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        id responder = [subView findFirstResponder];
        if (responder) return responder;
    }
    return nil;
}

- (void)pushMasterViewController:(UIViewController*)controller{
    [UIView pushMasterViewController:controller];
}

+ (void)pushMasterViewController:(UIViewController*)controller
{
    UINavigationController *naviC = [((AppDelegate*)([UIApplication sharedApplication].delegate)) masterNavigationController];
    
    
    [naviC pushViewController:controller animated:YES];
}

+ (void)popMasterViewController
{
    UINavigationController *naviC = [((AppDelegate*)([UIApplication sharedApplication].delegate)) masterNavigationController];
    [naviC popViewControllerAnimated:YES];
}

- (void)popMasterViewController{
    [UIView popMasterViewController];
}

+ (void)popViewController
{
    UINavigationController *naviC = [((AppDelegate*)([UIApplication sharedApplication].delegate)) currentNavigationController];
    [naviC popViewControllerAnimated:YES];
}

- (void)popViewController
{
    [UIView popViewController];
}

+ (void)popToRootViewController
{
    UINavigationController *naviC = [((AppDelegate*)([UIApplication sharedApplication].delegate)) currentNavigationController];
    [naviC popToRootViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController*)controller{
    [UIView pushMasterViewController:controller];
}

+ (void)pushViewController:(UIViewController*)controller{
    UINavigationController *naviC = [((AppDelegate*)([UIApplication sharedApplication].delegate)) currentNavigationController];
    [naviC pushViewController:controller animated:YES];
}

+ (void)popMasterToRootViewController
{
    UINavigationController *naviC = [((AppDelegate*)([UIApplication sharedApplication].delegate)) masterNavigationController];
    [naviC popToRootViewControllerAnimated:YES];
}

- (void)setupBorderWidth:(UIEdgeInsets)widthEdge
                topColor:(UIColor *)topColor
               leftColor:(UIColor *)leftColor
             bottomColor:(UIColor *)bottomColor
              rightColor:(UIColor *)rightColor
{
    if (widthEdge.top == widthEdge.left && widthEdge.top == widthEdge.bottom && widthEdge.top == widthEdge.right &&
        topColor == leftColor && topColor == bottomColor && topColor == rightColor)
    {
        self.layer.borderWidth = widthEdge.top;
        self.layer.borderColor = topColor.CGColor;
    }else
    {
        if (widthEdge.top>0) {
            CALayer *topLayer = [[CALayer alloc] init];
            topLayer.frame = CGRectMake(0, 0, self.width, widthEdge.top);
            [self.layer addSublayer:topLayer];
            topLayer.backgroundColor = topColor.CGColor;
        }
        
        if (widthEdge.left>0) {
            CALayer *leftLayer = [[CALayer alloc] init];
            leftLayer.frame = CGRectMake(0, 0, widthEdge.left, self.height);
            [self.layer addSublayer:leftLayer];
            leftLayer.backgroundColor = leftColor.CGColor;
        }
        
        if (widthEdge.bottom>0) {
            CALayer *bottomLayer = [[CALayer alloc] init];
            bottomLayer.frame = CGRectMake(0, self.height-widthEdge.bottom, self.width, widthEdge.bottom);
            [self.layer addSublayer:bottomLayer];
            bottomLayer.backgroundColor = bottomColor.CGColor;
        }
        
        if (widthEdge.right>0) {
            CALayer *rightLayer = [[CALayer alloc] init];
            rightLayer.frame = CGRectMake(self.width-widthEdge.right, 0, widthEdge.right, self.height);
            [self.layer addSublayer:rightLayer];
            rightLayer.backgroundColor = rightColor.CGColor;
        }
    }
    
    
    
}

- (void)setupBorderWidth:(UIEdgeInsets)widthEdge
                allColor:(UIColor *)allColor
{
    [self setupBorderWidth:widthEdge topColor:allColor leftColor:allColor bottomColor:allColor rightColor:allColor];
}

- (void)hideShadow {
    self.layer.shadowColor = [UIColor clearColor].CGColor;
}

- (void)shadowColor:(UIColor*)color shadowOffset:(CGSize)offset shadowRadius:(CGFloat)radius shadowOpacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
}

- (void)cornerRadius:(CGFloat)radius borderWidth:(CGFloat)width borderColor:(UIColor *)color {
    CALayer *layer = [self layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:radius];
    [layer setBorderWidth:width];
    [layer setBorderColor:color.CGColor];
}

- (void)shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)offset shadowRadius:(CGFloat)sradius shadowOpacity:(CGFloat)opacity
       cornerRadius:(CGFloat)cradius borderWidth:(CGFloat)width borderColor:(UIColor *)borderColor {
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = sradius;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.layer.bounds].CGPath;
    self.layer.cornerRadius = cradius;
    self.layer.borderWidth = width;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.masksToBounds = YES;
}

- (void)shake {
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setDuration:0.5f];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x-5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x+5, self.center.y)],
                      [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y)],
                      nil];
    [keyAn setValues:array];
    NSArray *times = [[NSArray alloc] initWithObjects:
                      [NSNumber numberWithFloat:0.1f],
                      [NSNumber numberWithFloat:0.2f],
                      [NSNumber numberWithFloat:0.3f],
                      [NSNumber numberWithFloat:0.4f],
                      [NSNumber numberWithFloat:0.5f],
                      [NSNumber numberWithFloat:0.6f],
                      [NSNumber numberWithFloat:0.7f],
                      [NSNumber numberWithFloat:0.8f],
                      [NSNumber numberWithFloat:0.9f],
                      [NSNumber numberWithFloat:1.0f],
                      nil];
    [keyAn setKeyTimes:times];
    [self.layer addAnimation:keyAn forKey:@"TextAnim"];
}

- (UIImage *)viewToImage{
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    
    //    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
    
    //        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    //    } else {
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    }
    
    UIImage * viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return viewImage;
}

- (void)makeRoundCorner {
    self.layer.cornerRadius = 2.0;
}

- (void)makeRound {
    self.layer.cornerRadius = self.bounds.size.width/2;
    self.clipsToBounds = YES;
}

@end


