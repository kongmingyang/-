//
//  ScrollTextView.m
//  ScrollLabelDemo
//
//  Created by 55it on 2019/4/26.
//  Copyright © 2019年 55it. All rights reserved.
//

#import "ScrollTextView.h"
@interface ScrollTextView()

@property (nonatomic,strong) CATextLayer * textLayer;//文本layer
@property (nonatomic,strong) CAGradientLayer *gradientLayer;//蒙板渐变layer

@property (nonatomic,assign)CGFloat  textSeparateWidth;//文本分割宽度
@property (nonatomic,assign)CGFloat  textWidth;//文本宽度
@property (nonatomic,assign)CGFloat  textHeight;//文本高度
@property (nonatomic,assign)CGRect   textLayerFrame;//文本layer的frame
@property (nonatomic,assign)CGFloat translationX;//文字位置游标
@end

NSString *const kSeparateText = @"   ";
@implementation ScrollTextView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {

        [self initLayer];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    CGFloat textLayerFrameY = CGRectGetHeight(self.bounds)/2 - CGRectGetHeight(self.textLayer.bounds)/2;
    self.textLayer.frame = CGRectMake(0, textLayerFrameY, CGRectGetWidth(self.textLayerFrame), CGRectGetHeight(self.textLayerFrame));
    self.gradientLayer.frame = self.bounds;
    [CATransaction commit];
    
    
}

-(void)initLayer{
    
    //文本layer 1
    if (self.textLayer == nil) {
        self.textLayer = [[CATextLayer alloc]init];
        
    }
    self.textLayer.alignmentMode = kCAAlignmentNatural;//自然对齐
    self.textLayer.truncationMode = kCATruncationNone;//设置截断模式
    self.textLayer.wrapped = NO;//是否折行
    self.textLayer.contentsScale = [UIScreen mainScreen].scale;
    if (self.textLayer.superlayer == nil) {
        [self.layer addSublayer:self.textLayer];
    }
    
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.shouldRasterize = YES;
   //栅格化比例，默认1
    self.gradientLayer.rasterizationScale = [UIScreen mainScreen].scale;
    if (self.textLayer.superlayer == nil) {
        [self.layer addSublayer:self.textLayer];
    }
    self.gradientLayer = [CAGradientLayer layer];
    self.gradientLayer.shouldRasterize = YES;
    self.gradientLayer.rasterizationScale = [UIScreen mainScreen].scale;
    //开始和结束滚动设置，下面的设置是横向，开始为止改为(1.0f, 0.0f)为纵向;
    self.gradientLayer.startPoint = CGPointMake(0.0f, 0.5f);
    self.gradientLayer.endPoint = CGPointMake(1.0f, 0.5f);
    id transparent = (id)[UIColor clearColor].CGColor;
    id opaque = (id)[UIColor blackColor].CGColor;
    self.gradientLayer.colors = @[transparent,opaque,opaque,transparent];
    self.gradientLayer.locations = @[@0,@(self.fade),@(1-self.fade),@1];
    self.layer.mask = self.gradientLayer;
    
    
}
//拼装文字
-(void)drawTextLayer{
    
    self.textLayer.foregroundColor = self.textColor.CGColor;
    CFStringRef fontName = (__bridge CFStringRef)self.font.fontName;
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    self.textLayer.font = fontRef;
    self.textLayer.fontSize = self.font.pointSize;
    CGFontRelease(fontRef);
    self.textLayer.string = [NSString stringWithFormat:@"%@%@%@",kSeparateText,self.text,kSeparateText];
    
    
}

//文本滚动动画
-(void)startAnimation{
    
    if ([self.textLayer animationForKey:kCATransitionFromLeft]) {
        [self.textLayer removeAnimationForKey:kCATransitionFromLeft];
    }
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.translation.x";
    animation.fromValue = @(self.bounds.origin.x);
    animation.toValue = @(self.bounds.origin.x - self.translationX);
    animation.duration = self.textWidth * 0.035f;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.textLayer addAnimation:animation forKey:kCATransitionFromLeft];
}
-(void)setText:(NSString *)text{
    
    _text = text;
    NSDictionary *dic= @{NSFontAttributeName:self.font};
       NSStringDrawingContext *dcontext = [[NSStringDrawingContext alloc] init];
    CGSize size = [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:dcontext].size;
    self.textWidth = size.width;
    self.textHeight = size.height;
    self.textLayerFrame = CGRectMake(0, 0, self.textWidth*3+self.textSeparateWidth*2, self.textHeight);
    self.translationX = self.textWidth+self.textSeparateWidth;
    [self drawTextLayer];
    [self startAnimation];
    
    
}
@end
