//
//  UIView+NextHint.m
//  Categories
//
//  Created by Conroy, William | Liam | SDTD on 13/03/06.
//  Copyright (c) 2013年 Conroy, William | Liam | SDTD. All rights reserved.
//

#import "UIView+NextHint.h"
#import <QuartzCore/QuartzCore.h>

#define HINT_VIEW 1

@implementation UIView (NextHint)

NSTimer * timer;
int countToEnd;

- (void)setViewToPulse:(UIView *)view
         fromIntensity:(CGFloat)fromInt
           toIntensity:(CGFloat)toInt
               repeats:(int)repCount
                 speed:(CGFloat)speed
{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(fromInt);
    animation.toValue = @(toInt);
    animation.repeatCount = repCount;
    animation.duration = speed;
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    timer = [NSTimer scheduledTimerWithTimeInterval:speed*2 target:self selector:@selector(animLoop) userInfo:nil repeats:YES];
    
    [view.layer addAnimation:animation forKey:@"pulse"];
}

- (void)animLoop
{
    NSLog(@"animloop");
    
    countToEnd--;
    
    if(countToEnd == 0)
    {
        [timer invalidate];
        
        UIView * hintView = [self.superview viewWithTag:HINT_VIEW];
        
        [hintView.layer removeAllAnimations];
        [hintView removeFromSuperview];
    }
}

// HUGE_VAL for looping
- (void)startHintWithColor:(UIColor*)color
                    radius:(CGFloat)radius
             fromIntensity:(CGFloat)fInt
               toIntensity:(CGFloat)tInt
                   repeats:(int)numTimes
                     speed:(CGFloat)speed
{
    countToEnd = numTimes;
    
    UIView* hintView = [[UIView alloc] initWithFrame:self.frame];
    hintView.tag = HINT_VIEW;
    hintView.backgroundColor = [UIColor clearColor];
    hintView.center = self.center;
    [self.superview insertSubview:hintView belowSubview:self];
    
    hintView.layer.shadowColor = color.CGColor;
    hintView.layer.shadowRadius = radius;
    hintView.layer.shadowPath = CGPathCreateWithRect(CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), NULL);
    hintView.layer.shadowOpacity = 1.0f;
    hintView.layer.shadowOffset = CGSizeMake(1, 1);
    
    [self setViewToPulse:hintView
           fromIntensity:fInt
             toIntensity:tInt
                 repeats:numTimes
                   speed:speed];
}

- (void)startHint
{
    [self startHintWithColor:[UIColor blackColor] radius:15.0f fromIntensity:0.0f toIntensity:1.0f repeats:HUGE_VAL speed:1.0f];
}

- (void)endHint
{
    countToEnd = 1;
}

@end
