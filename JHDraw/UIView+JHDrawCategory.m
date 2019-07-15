//
//  UIView+JHDrawCategory.m
//  JHKit
//
//  Created by Lightech on 14-10-16.
//  Copyright (c) 2014年 Lightech. All rights reserved.
//
//  MIT License
//
//  Copyright (c) 2017 xjh093
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

#import "UIView+JHDrawCategory.h"

@implementation UIView (JHDrawCategory)

//画直线 - draw line in view.
- (void)jh_drawLineFromPoint:(CGPoint)fPoint
                     toPoint:(CGPoint)tPoint
                   lineColor:(UIColor *)color
                   lineHeight:(CGFloat)height
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:fPoint];
        [path addLineToPoint:tPoint];
        path.CGPath;
    });
    shapeLayer.lineWidth = height;
    [self.layer addSublayer:shapeLayer];
}

//画虚线 - draw dash line.
- (void)jh_drawDashLineFromPoint:(CGPoint)fPoint
                         toPoint:(CGPoint)tPoint
                       lineColor:(UIColor *)color
                       lineWidth:(CGFloat)width
                      lineHeight:(CGFloat)height
                       lineSpace:(CGFloat)space
                        lineType:(NSInteger)type
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:fPoint];
        [path addLineToPoint:tPoint];
        path.CGPath;
    });
    //第一格虚线缩进多少 - the degree of indent of the first cell
    //shapeLayer.lineDashPhase = 4;
    shapeLayer.lineWidth = height < 0 ? 1 : height;
    shapeLayer.lineCap = kCALineCapButt;
    width = width < 0 ? 1 : width;
    shapeLayer.lineDashPattern = @[@(width),@(space)];
    if (type == 1) {
        shapeLayer.lineCap = kCALineCapRound;
        shapeLayer.lineDashPattern = @[@(width),@(space+width)];
    }
    [self.layer addSublayer:shapeLayer];
}

//画五角星 - draw pentagram
- (void)jh_drawPentagram:(CGPoint)center
                  radius:(CGFloat)radius
                   color:(UIColor *)color
                    rate:(CGFloat)rate
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor clearColor].CGColor;
    shapeLayer.fillColor = [UIColor orangeColor].CGColor;
    if (color) {
        shapeLayer.fillColor = color.CGColor;
    }
    shapeLayer.path = ({
        UIBezierPath *path = [UIBezierPath bezierPath];
        
        //五角星最上面的点
        CGPoint first  = CGPointMake(center.x, center.y-radius);
        
        [path moveToPoint:first];
        
        //点与点之间点夹角为2*M_PI/5.0,要隔一个点才连线
        CGFloat angle=4*M_PI/5.0;
        if (rate > 1.5) {
            rate = 1.5;
        }
        for (int i= 1; i <= 5; i++) {
            CGFloat x = center.x - sinf(i*angle)*radius;
            CGFloat y = center.y - cosf(i*angle)*radius;
            
            CGFloat midx = center.x - sinf(i*angle-2*M_PI/5.0)*radius*rate;
            CGFloat midy = center.y - cosf(i*angle-2*M_PI/5.0)*radius*rate;
            [path addQuadCurveToPoint:CGPointMake(x, y) controlPoint:CGPointMake(midx, midy)];
        }
        
        path.CGPath;
    });
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:shapeLayer];
}

- (void)jh_drawRect:(CGRect)rect
          lineColor:(UIColor *)color
          lineWidth:(CGFloat)width
         lineHeight:(CGFloat)height
           lineType:(NSInteger)type
             isDash:(BOOL)dash
          lineSpace:(CGFloat)space
{
    [self jh_drawInRect:rect
              lineColor:color
              lineWidth:width
             lineHeight:height
               lineType:type
                 isDash:dash
              lineSpace:space
               pathType:0
                 radius:0
                corners:0];
}

- (CALayer *)jh_gradientLayer:(CGRect)rect
                        color:(NSArray <UIColor *>*)colors
                     location:(NSArray <NSNumber *> *)locations
                    direction:(CAGradientLayerDirection)direction
{
    if (colors.count == 0) {
        return nil;
    }
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = rect;
    layer.locations = locations;
    layer.colors = ({
        NSMutableArray *marr = @[].mutableCopy;
        for (UIColor *color in colors) {
            if ([color isKindOfClass:[UIColor class]]) {
                [marr addObject:(__bridge id)color.CGColor];
            }
        }
        marr;
    });
    
    if (direction == CAGradientLayerDirection_FromLeftToRight) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint   = CGPointMake(1, 0);
    }else if (direction == CAGradientLayerDirection_FromTopToBottom) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint   = CGPointMake(0, 1);
    }else if (direction == CAGradientLayerDirection_FromTopLeftToBottomRight) {
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint   = CGPointMake(1, 1);
    }else if (direction == CAGradientLayerDirection_FromTopRightToBottomLeft) {
        layer.startPoint = CGPointMake(1, 0);
        layer.endPoint   = CGPointMake(0, 1);
    }else if (direction == CAGradientLayerDirection_FromCenterToEdge) {
        layer.startPoint = CGPointMake(0.5, 0.5);
        layer.endPoint   = CGPointMake(1, 1);
        layer.type = kCAGradientLayerRadial;
    }
    
    [self.layer addSublayer:layer];
    return layer;
}

- (CALayer *)jh_gradientLayer:(CGRect)rect
                        color:(NSArray <UIColor *>*)colors
                   startPoint:(CGPoint)startPoint
                     endPoint:(CGPoint)endPoint
                     location:(NSArray <NSNumber *> *)locations
                         type:(NSInteger)type
{
    if (colors.count == 0) {
        return nil;
    }
    
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = rect;
    layer.locations = locations;
    layer.colors = ({
        NSMutableArray *marr = @[].mutableCopy;
        for (UIColor *color in colors) {
            if ([color isKindOfClass:[UIColor class]]) {
                [marr addObject:(__bridge id)color.CGColor];
            }
        }
        marr;
    });
    
    layer.startPoint = startPoint;
    layer.endPoint   = endPoint;
    
    if (type == 0) {
        layer.type = kCAGradientLayerAxial;
    }else if (type == 1) {
        layer.type = kCAGradientLayerRadial;
    }else if (type == 2) {
        if (@available(iOS 12,*)){
            layer.type = kCAGradientLayerConic;
        }
    }
    
    [self.layer addSublayer:layer];
    return layer;
}

- (void)jh_drawOval:(CGRect)rect
          lineColor:(UIColor *)color
          lineWidth:(CGFloat)width
         lineHeight:(CGFloat)height
           lineType:(NSInteger)type
             isDash:(BOOL)dash
          lineSpace:(CGFloat)space
{
    [self jh_drawInRect:rect
              lineColor:color
              lineWidth:width
             lineHeight:height
               lineType:type
                 isDash:dash
              lineSpace:space
               pathType:1
                 radius:0
                corners:0];
    
}

/// draw round rect. type: 0 - cube, 1 - round
- (void)jh_drawRoundRect:(CGRect)rect
               lineColor:(UIColor *)color
               lineWidth:(CGFloat)width
              lineHeight:(CGFloat)height
                lineType:(NSInteger)type
                  isDash:(BOOL)dash
               lineSpace:(CGFloat)space
                  radius:(CGFloat)radius
{
    [self jh_drawInRect:rect
              lineColor:color
              lineWidth:width
             lineHeight:height
               lineType:type
                 isDash:dash
              lineSpace:space
               pathType:2
                 radius:radius
                corners:0];
}

- (void)jh_drawRoundRect:(CGRect)rect
         roundingCorners:(UIRectCorner)corners
               lineColor:(UIColor *)color
               lineWidth:(CGFloat)width
              lineHeight:(CGFloat)height
                lineType:(NSInteger)type
                  isDash:(BOOL)dash
               lineSpace:(CGFloat)space
                  radius:(CGFloat)radius
{
    [self jh_drawInRect:rect
              lineColor:color
              lineWidth:width
             lineHeight:height
               lineType:type
                 isDash:dash
              lineSpace:space
               pathType:3
                 radius:radius
                corners:corners];
}

- (void)jh_drawInRect:(CGRect)rect
            lineColor:(UIColor *)color
            lineWidth:(CGFloat)width
           lineHeight:(CGFloat)height
             lineType:(NSInteger)type
               isDash:(BOOL)dash
            lineSpace:(CGFloat)space
             pathType:(NSInteger)pathType
               radius:(CGFloat)radius
              corners:(UIRectCorner)corners
{
    CAShapeLayer* shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    if (color) {
        shapeLayer.strokeColor = color.CGColor;
    }
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.path = ({
        UIBezierPath *path;
        if (pathType == 0) {
            path = [UIBezierPath bezierPathWithRect:rect];
        }else if (pathType == 1) {
            path = [UIBezierPath bezierPathWithOvalInRect:rect];
        }else if (pathType == 2) {
            path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        }else if (pathType == 3) {
            path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
        }
        path.CGPath;
    });
    shapeLayer.lineWidth = height < 0 ? 1 : height;
    shapeLayer.lineCap = kCALineCapButt;
    if (type == 1) {
        shapeLayer.lineCap = kCALineCapRound;
    }
    
    width = width < 0 ? 1 : width;
    if (dash) {
        shapeLayer.lineDashPattern = @[@(width),@(space)];
        if (type == 1) {
            shapeLayer.lineDashPattern = @[@(width),@(space+width)];
        }
    }
    
    [self.layer addSublayer:shapeLayer];
}

@end
