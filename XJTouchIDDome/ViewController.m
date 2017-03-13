//
//  ViewController.m
//  XJTouchIDDome
//
//  Created by dengxiaojun on 2017/2/5.
//  Copyright © 2017年 dengxiaojun. All rights reserved.
//

#import "ViewController.h"
#import "XJTouchHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 200, 375, 40)];
    lable.font = [UIFont systemFontOfSize:30];
    lable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lable];
    
    [XJTouchHelper touchHelperWithlocalizedReason:@"请按home键指纹解锁" reply:^(BOOL success, TouchIDErrorType errorType) {        
        if (success) {
            NSLog(@"%@",@"成功");
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                 lable.text = @"解锁成功";
            });
            
        }else{
            switch (errorType) {
                case TouchIDErrorTypeSystemCancel: //验证成功. 一般不用.
                    lable.text = @"验证成功. 一般不用";
                    break;
                case TouchIDErrorTypeUserCancel: //系统取消授权，如其他APP切入
                    lable.text = @"系统取消授权，如其他APP切入";
                    break;
                case TouchIDErrorTypeAuthenticationFailed: // 验证失败(验证三次 均失败)
                    lable.text = @"验证失败(验证三次 均失败)";
                    break;
                case TouchIDErrorTypePasscodeNotSet: //系统未设置密码
                    lable.text = @"系统未设置密码";
                    break;
                case TouchIDErrorTypeUserFallback: //用户选择输入密码，切换主线程处理
                    lable.text = @"用户选择输入密码，切换主线程处理";
                    break;
                case TouchIDErrorTypeTouchIDNotEnrolled: //设备不支持指纹识别
                    lable.text = @"设备不支持指纹识别";
                    break;
                default:
                    break;
            }
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
