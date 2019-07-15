//
//  UIView+JHDrawCategory.h
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

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CAGradientLayerDirection) {
    CAGradientLayerDirection_FromLeftToRight,           // 从左到右
    CAGradientLayerDirection_FromTopToBottom,           // 从上到下
    CAGradientLayerDirection_FromTopLeftToBottomRight,  // 从左上到右下
    CAGradientLayerDirection_FromTopRightToBottomLeft,  // 从右上到左下
    CAGradientLayerDirection_FromCenterToEdge,          // 从中心向四周
};

@interface UIView (JHDrawCategory)

/// draw line in view.
- (void)jh_drawLineFromPoint:(CGPoint)fPoint
                     toPoint:(CGPoint)tPoint
                   lineColor:(UIColor *)color
                  lineHeight:(CGFloat)height;

/// draw dash line in view. type: 0 - cube, 1 - round
- (void)jh_drawDashLineFromPoint:(CGPoint)fPoint
                         toPoint:(CGPoint)tPoint
                       lineColor:(UIColor *)color
                       lineWidth:(CGFloat)width
                      lineHeight:(CGFloat)height
                       lineSpace:(CGFloat)space
                        lineType:(NSInteger)type;

/// draw pentagram in view. rate: 0.3 ~ 1.1
- (void)jh_drawPentagram:(CGPoint)center
                  radius:(CGFloat)radius
                   color:(UIColor *)color
                    rate:(CGFloat)rate;

/// draw rect. type: 0 - cube, 1 - round
- (void)jh_drawRect:(CGRect)rect
          lineColor:(UIColor *)color
          lineWidth:(CGFloat)width
         lineHeight:(CGFloat)height
           lineType:(NSInteger)type
             isDash:(BOOL)dash
          lineSpace:(CGFloat)space;

/// gradient layer with direction.
- (CALayer *)jh_gradientLayer:(CGRect)rect
                        color:(NSArray <UIColor *>*)colors
                     location:(NSArray <NSNumber *> *)locations
                    direction:(CAGradientLayerDirection)direction;

- (CALayer *)jh_gradientLayer:(CGRect)rect
                        color:(NSArray <UIColor *>*)colors
                   startPoint:(CGPoint)startPoint
                     endPoint:(CGPoint)endPoint
                     location:(NSArray <NSNumber *> *)locations
                         type:(NSInteger)type;

/// draw oval. type: 0 - cube, 1 - round
- (void)jh_drawOval:(CGRect)rect
          lineColor:(UIColor *)color
          lineWidth:(CGFloat)width
         lineHeight:(CGFloat)height
           lineType:(NSInteger)type
             isDash:(BOOL)dash
          lineSpace:(CGFloat)space;

/// draw round rect. type: 0 - cube, 1 - round
- (void)jh_drawRoundRect:(CGRect)rect
               lineColor:(UIColor *)color
               lineWidth:(CGFloat)width
              lineHeight:(CGFloat)height
                lineType:(NSInteger)type
                  isDash:(BOOL)dash
               lineSpace:(CGFloat)space
                  radius:(CGFloat)radius;

/// draw round rect. type: 0 - cube, 1 - round
- (void)jh_drawRoundRect:(CGRect)rect
         roundingCorners:(UIRectCorner)corners
               lineColor:(UIColor *)color
               lineWidth:(CGFloat)width
              lineHeight:(CGFloat)height
                lineType:(NSInteger)type
                  isDash:(BOOL)dash
               lineSpace:(CGFloat)space
                  radius:(CGFloat)radius;

@end
