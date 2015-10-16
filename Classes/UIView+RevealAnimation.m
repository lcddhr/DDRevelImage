//
//  UIView+RevealAnimation.m
//  DDRevealImageDemo
//
//  Created by lovelydd on 15/10/16.
//  Copyright (c) 2015年 xiaomutou. All rights reserved.
//

#import "UIView+RevealAnimation.h"

static CAShapeLayer *circleLayer;
static NSTimeInterval kRevealAnimationTimeInterval = 2.0f;

static CGFloat kRadius = 90;
//CAShapeLayer *circleLayer;
@implementation UIView (RevealAnimation)


- (void)dd_outLineAnimation; {
    
    [self startOutLineAnimation];
}

- (void)dd_revealAnimation {
    
    [self startRevealAnimation];
}

//执行动画
- (void)startOutLineAnimation {
    
    [circleLayer removeFromSuperlayer];
    //创建外圆的layer
    circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 1.0f;
    circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.path = [self drawOutLine].CGPath;
    [self.layer addSublayer:circleLayer];
    
    //执行外圆layer的动画
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.duration = kRevealAnimationTimeInterval;
    circleAnimation.fromValue = @(0.0f);
    circleAnimation.toValue = @(1.0f);
    circleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [circleLayer addAnimation:circleAnimation forKey:@"outlineAnimation"];
}

- (void)startRevealAnimation {
    
    self.hidden = YES;
    CAShapeLayer *revealLayer = [CAShapeLayer layer];
    revealLayer.bounds = self.bounds;
    revealLayer.fillColor = [UIColor blackColor].CGColor;
   
    //开始的路径
    CGFloat fromRadius = 1.0f;
    CGFloat fromRectWidth = fromRadius * 2;
    CGFloat fromRectHeight = fromRadius * 2;
    CGRect fromRect = CGRectMake(CGRectGetMidX(self.bounds) - fromRadius,
                                 CGRectGetMidY(self.bounds) - fromRadius,
                                 fromRectWidth,
                                 fromRectHeight);
    
    UIBezierPath *fromPath = [self drawRevealPath:fromRect cornerRadius:fromRadius];
    
    //结束的路径
    CGFloat endRadius = self.bounds.size.width / 2;
    UIBezierPath *endPath = [self drawRevealPath:self.bounds cornerRadius:endRadius];
    
    
    revealLayer.path = endPath.CGPath;
    revealLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
     self.layer.mask = revealLayer;

    //    开始动画
    CABasicAnimation *revealAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    revealAnimation.fromValue = (__bridge id)(fromPath.CGPath);
    revealAnimation.toValue = (__bridge id)(endPath.CGPath);
    revealAnimation.duration = kRevealAnimationTimeInterval / 2;
    revealAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    revealAnimation.beginTime = CACurrentMediaTime() + kRevealAnimationTimeInterval / 2;
    revealAnimation.repeatCount = 1.0f;
    revealAnimation.fillMode = kCAFillModeForwards;
    
    dispatch_time_t timeToShow = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kRevealAnimationTimeInterval/2.0f * NSEC_PER_SEC));
    dispatch_after(timeToShow, dispatch_get_main_queue(), ^{

        self.hidden = NO;
    });
    [revealLayer addAnimation:revealAnimation forKey:@"revealAnimation"];
    
}


- (void)dd_slowRevealAnimation {
    
    circleLayer = [CAShapeLayer layer];
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.strokeColor = [UIColor yellowColor].CGColor;
    circleLayer.path = [self pathWithRadius:kRadius].CGPath;
    self.layer.mask = circleLayer;
    
    //NSStringFromSelector(@selector(lineWidth)
    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    lineWidthAnimation.toValue = @(kRadius);
    lineWidthAnimation.duration = 2.0;
    lineWidthAnimation.delegate = self;
    lineWidthAnimation.removedOnCompletion = NO;
    lineWidthAnimation.fillMode = kCAFillModeForwards;
    [circleLayer addAnimation:lineWidthAnimation forKey:@"slowRevealAnimation"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.layer.mask = nil;
}



- (UIBezierPath *)pathWithRadius:(CGFloat)radius {
    //根据矩形框,画个内切圆
    return [UIBezierPath bezierPathWithOvalInRect:CGRectMake((CGRectGetWidth(self.bounds) - radius) / 2,
                                                             (CGRectGetHeight(self.bounds) - radius) / 2,
                                                             radius ,
                                                             radius)];
}

- (UIBezierPath *)drawOutLine {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width / 2];
    return path;
}

- (UIBezierPath *)drawRevealPath:(CGRect)roundRect cornerRadius:(CGFloat)radius{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:roundRect cornerRadius:radius];
    return path;
}

@end
