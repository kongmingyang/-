//
//  ViewController.m
//  ScrollLabelDemo
//
//  Created by 55it on 2019/4/26.
//  Copyright © 2019年 55it. All rights reserved.
//

#import "ViewController.h"
#import "ScrollTextView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ScrollTextView *textView = [[ScrollTextView alloc]initWithFrame:CGRectMake(30, 100, 200, 60)];
    textView.font  = [UIFont systemFontOfSize:20];
    textView.textColor = [UIColor redColor];
    textView.text = @"这是抖音滚动字符串";
    textView.fade = 0.5;
    [self.view addSubview:textView];
    
}


@end
