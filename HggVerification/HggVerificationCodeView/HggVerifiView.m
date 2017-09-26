//
//  HggVerifiView.m
//  HggVerification
//
//  Created by 胡高广 on 2017/9/26.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import "HggVerifiView.h"

#define NNRandomColor [UIColor colorWithRed:arc4random() % 100 / 100.0 green:arc4random() % 100 / 100.0 blue:arc4random() % 100 / 100.0 alpha: 0.5]  //随机数的宏定义

@interface HggVerifiView ()

/// 字符串数量，初始化时设置
@property (nonatomic, assign) NSInteger charCount;
/// 线条数量，初始化时设置
@property (nonatomic, assign) NSInteger lineCount;

@end

@implementation HggVerifiView

//实现的方法
- (instancetype)initWithFrame:(CGRect)frame andCharCount:(NSInteger)charCount andLineCount:(NSInteger)lineCount
{
    if (self = [super initWithFrame:frame]) {
        self.charCount = charCount;
        self.lineCount = lineCount;
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = NNRandomColor;
        [self changeValidationCode];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)]];
    }
    return self;
}

-(void)reloadAuthCodeView{
    
    [self changeValidationCode];
    [self setNeedsDisplay];
    
}

- (void)tapGesture {
    [self changeValidationCode];
    [self setNeedsDisplay];
}

#pragma mark - 更换验证码
- (void)changeValidationCode {
    NSMutableString *getStr = [[NSMutableString alloc] initWithCapacity:self.charCount];
    self.charString = [[NSMutableString alloc] initWithCapacity:self.charCount];
    
    for(NSInteger i = 0; i < self.charCount; i++) {
        NSInteger index = arc4random() % ([self.charArray count]);
        getStr = [self.charArray objectAtIndex:index];
        self.charString = (NSMutableString *)[self.charString stringByAppendingString:getStr];
    }
    
   
}

#pragma mark - 绘制界面
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    self.backgroundColor = NNRandomColor;
    CGFloat rectWidth = rect.size.width;
    CGFloat rectHeight = rect.size.height;
    CGFloat pointX, pointY;
    
    NSString *text = [NSString stringWithFormat:@"%@",self.charString];
    NSInteger charWidth = rectWidth / text.length - 15;
    NSInteger charHeight = rectHeight - 25;
    
    // 依次绘制文字
    for (NSInteger i = 0; i < text.length; i++) {
        // 文字X坐标
        pointX = arc4random() % charWidth + rectWidth / text.length * i;
        // 文字Y坐标
        pointY = arc4random() % charHeight;
        unichar charC = [text characterAtIndex:i];
        NSString *textC = [NSString stringWithFormat:@"%C", charC];
        
        [textC drawAtPoint:CGPointMake(pointX, pointY) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:arc4random() % 10 + 15]}];
    }
    
    // 获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置线宽
    CGContextSetLineWidth(context, 1.0);
    
    // 依次绘制直线
    for(NSInteger i = 0; i < self.lineCount; i++) {
        // 设置线的颜色
        CGContextSetStrokeColorWithColor(context, NNRandomColor.CGColor);
        // 设置线的起点
        pointX = arc4random() % (NSInteger)rectWidth;
        pointY = arc4random() % (NSInteger)rectHeight;
        CGContextMoveToPoint(context, pointX, pointY);
        // 设置线的终点
        pointX = arc4random() % (NSInteger)rectWidth;
        pointY = arc4random() % (NSInteger)rectHeight;
        CGContextAddLineToPoint(context, pointX, pointY);
        // 绘画路径
        CGContextStrokePath(context);
    }
}

#pragma mark - Lazy loading
- (NSArray *)charArray {
    if (!_charArray) {
        _charArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    }
    return _charArray;
}
//开始验证   string是输入的字符串
- (BOOL)startAuthWithString:(NSString *)string {
    int result = [self.charString compare:string options:NSCaseInsensitiveSearch | NSNumericSearch];
    
    if (result == 0) {
        return YES;
    }
    else {
        return NO;
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
