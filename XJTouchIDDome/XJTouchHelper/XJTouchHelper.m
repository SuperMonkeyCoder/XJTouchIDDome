//
//  XJTouchHelper.m
//  XJTouchIDDome
//
//  Created by dengxiaojun on 2017/2/5.
//  Copyright © 2017年 dengxiaojun. All rights reserved.
//

#import "XJTouchHelper.h"
#import <LocalAuthentication/LocalAuthentication.h>

@implementation XJTouchHelper
+ (void)touchHelperWithlocalizedReason:(NSString *)localizedReason reply:(void (^)(BOOL success, TouchIDErrorType errorType))reply{
    
    LAContext *context = [LAContext new];
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        NSLog(@"支持指纹识别");
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:localizedReason reply:^(BOOL success, NSError * _Nullable error)
         {
             if (success)
             {
                 if (reply) {
                     reply(YES,TouchIDErrorTypeSuccess);
                 }
             }
             else
             {
                 switch (error.code) {
                     case LAErrorSystemCancel:
                     {
                         if (reply) {
                             reply(NO,TouchIDErrorTypeSystemCancel);
                         }
                         break;
                     }
                     case LAErrorUserCancel:
                     {
                         if (reply) {
                             reply(NO,TouchIDErrorTypeUserCancel);
                         }
                         break;
                     }
                     case LAErrorAuthenticationFailed:
                     {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             if (reply) {
                                 reply(NO,TouchIDErrorTypeAuthenticationFailed);
                             }
                         });
                         break;
                     }
                     case LAErrorPasscodeNotSet:
                     {
                         if (reply) {
                             reply(NO,TouchIDErrorTypePasscodeNotSet);
                         }
                         break;
                     }
                         
                     case LAErrorUserFallback:
                     {
                         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                             if (reply) {
                                 reply(NO,TouchIDErrorTypeUserFallback);
                             }
                         }];
                         break;
                     }
                     default:
                     {
                         [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                             NSLog(@"其他情况，切换主线程处理");
                         }];
                         break;
                     }
                 }
             }
         }];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的不支持指纹识别" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertView show];
        
        if (reply) {
            reply(NO,TouchIDErrorTypeTouchIDNotEnrolled);
        }
    }
}
@end
