//
//  XJTouchHelper.h
//  XJTouchIDDome
//
//  Created by dengxiaojun on 2017/2/5.
//  Copyright © 2017年 dengxiaojun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TouchIDErrorTypeSuccess, //验证成功. 一般不用.
    TouchIDErrorTypeSystemCancel, //系统取消授权，如其他APP切入
    TouchIDErrorTypeUserCancel, //用户取消验证
    TouchIDErrorTypeAuthenticationFailed, // 验证失败(验证三次 均失败)
    TouchIDErrorTypePasscodeNotSet, //系统未设置密码
    TouchIDErrorTypeUserFallback, // 用户选择输入密码，切换主线程处理
    TouchIDErrorTypeTouchIDNotEnrolled //设备不支持指纹识别
} TouchIDErrorType;


@interface XJTouchHelper : NSObject
+ (void)touchHelperWithlocalizedReason:(NSString *)localizedReason reply:(void (^)(BOOL success, TouchIDErrorType errorType))reply;
@end
