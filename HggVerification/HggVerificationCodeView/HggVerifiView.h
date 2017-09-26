//
//  HggVerifiView.h
//  HggVerification
//
//  Created by 胡高广 on 2017/9/26.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import <UIKit/UIKit.h>

//取材库类型
typedef enum {
    BlendWordAndNumbers, //混合
    OnlyNumbers,         //只有数字
    OnlyWord ,           //只有字母
} AllWordArraytypes;

//字符间距
typedef enum  {
    WordSpacingTypeNone,   //没有间距(0)
    WordSpacingTypeSmall,  //间距较小(10)
    WordSpacingTypeMedium, //间距中等(20)
    WordSpacingTypeBig,    //间距较大(40)
} WordSpacingTypes;


@interface HggVerifiView : UIView

@property (nonatomic, copy) NSArray *charArray; //随机的数组
@property (nonatomic, strong) NSMutableString *charString;


- (instancetype)initWithFrame:(CGRect)frame andCharCount:(NSInteger)charCount andLineCount:(NSInteger)lineCount;

/**
 @author Don9
 
 刷新条形码的方法
 */
-(void)reloadAuthCodeView;

//开始验证   string是输入的字符串
- (BOOL)startAuthWithString:(NSString *)string;
@end
