//
//  ViewController.m
//  HggVerification
//
//  Created by 胡高广 on 2017/9/26.
//  Copyright © 2017年 jinshuaier. All rights reserved.
//

#import "ViewController.h"
#import "HggVerifiView.h"
@interface ViewController () <UITextFieldDelegate>
@property (nonatomic, strong) HggVerifiView *testView; //自定义的view
@property (nonatomic, strong) UITextField *hggTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"验证码";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //创建View
    [self setupViews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupViews {
    
   //创建textfield
    self.hggTextField = [[UITextField alloc] init];
    self.hggTextField.frame = CGRectMake(100, 300, 100, 40);
    self.hggTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.hggTextField.delegate = self;
    self.hggTextField.tintColor = [UIColor redColor];
    self.hggTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.hggTextField];
    
    //自定义的View
    _testView = [[HggVerifiView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 100) / 2, 200, 100, 40) andCharCount:4 andLineCount:4];
    [self.view addSubview:_testView];
    
    UIButton *reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    reloadBtn.frame = CGRectMake(CGRectGetMaxX(_testView.frame) + 20, 200, 100, 40);
    reloadBtn.layer.cornerRadius = 5;
    reloadBtn.backgroundColor = [UIColor greenColor];
    [reloadBtn setTitle:@"刷新验证码" forState:UIControlStateNormal];
    [self.view addSubview:reloadBtn];
    [reloadBtn addTarget:self action:@selector(reloadAction) forControlEvents:UIControlEventTouchUpInside];
    
   
    UIButton *yanzhengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yanzhengBtn.frame = CGRectMake((self.view.frame.size.width - 100) / 2, 350, 40, 40);
    yanzhengBtn.layer.cornerRadius = 5;
    yanzhengBtn.backgroundColor = [UIColor greenColor];
    [yanzhengBtn setTitle:@"验证" forState:UIControlStateNormal];
    [self.view addSubview:yanzhengBtn];
    [yanzhengBtn addTarget:self action:@selector(yanzhengAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)reloadAction {
    [self.testView reloadAuthCodeView];
}
// 全局手势
- (void)yanzhengAction
{
    BOOL isOk = [self.testView startAuthWithString:self.hggTextField.text];
    
    
    
    if (isOk) {
        
        //这里面写验证正确之后的动作.
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"匹配正确" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:2];
        
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证码错误" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
        [alert show];
        [alert performSelector:@selector(dismissWithClickedButtonIndex:animated:) withObject:nil afterDelay:2];
        
     
        //这里面写验证失败之后的动作.
        [self.testView reloadAuthCodeView];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
