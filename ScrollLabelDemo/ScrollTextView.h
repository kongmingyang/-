//
//  ScrollTextView.h
//  ScrollLabelDemo
//
//  Created by 55it on 2019/4/26.
//  Copyright © 2019年 55it. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScrollTextView : UIView
/**
 * 文本内容
 **/
@property (nonatomic,copy) NSString * text;
/**
 * 文本颜色
 **/
@property (nonatomic,copy)UIColor * textColor;

@property (nonatomic,copy)UIFont * font;
/**
 * 渐变开始的距离(0~0.5) 推荐 0.0x eg:0.026,
 *
 **/
@property (nonatomic,assign)CGFloat  fade;
@end

NS_ASSUME_NONNULL_END
