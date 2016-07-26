//
//  NSObject+Common.m
//  okayEducation
//
//  Created by 潘伟杰 on 16/5/27.
//  Copyright © 2016年 OKAY.XDF.CN. All rights reserved.
//

#import "NSObject+Common.h"
#import "MBProgressHUD.h"
#import "ApiUrl.h"
#import "DictTool.h"
#import "AppDelegate.h"
#import "EMIMHelper.h"
#import "UserCacheManager.h"
@implementation NSObject (Common)
#pragma mark NetError
-(id)handleResponse:(id)responseJSON{
    NSError *error = nil;
    //code为非0值时，表示有错

    NSNumber *resultCode = [DictTool getNumberValue:(NSDictionary *)responseJSON withKey:@"ecode"];
//    NSNumber *resultCode = [responseJSON valueForKey:@"ecode"];
    if (resultCode.intValue != 0) {
        
        error = [NSError errorWithDomain:okEducation_Code_Base code:resultCode.intValue userInfo:responseJSON];
//        [self showError:error];
        
        if((resultCode.intValue != APP_ERROR_VALIDATE_MANY_TIMES)
           &&(resultCode.integerValue != APP_NETWORKSECURITY)
           &&(resultCode.intValue != APP_ERROR_TOKEN_INVALID)
           &&(resultCode.intValue != APP_ERROR_NOT_BIND_STUDENT)
           ){
            [self showHudTipStr:[responseJSON valueForKey:@"emsg"]];
        }
        
        //根据错误码逻辑判断，如登录token失效
        if (resultCode.intValue == APP_ERROR_TOKEN_INVALID) {
            NSString * message = [DictTool getStringValue:(NSDictionary *)responseJSON  withKey:@"emsg"];
            if (message.length == 0) {
                message = @"登录状态已失效,请重新登录";
            }
            [self showAlert:message];
        }
        
    }
    return error;
}


-(void)showAlert:(NSString *)message{
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alertView.delegate = self;
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        //清除缓存
        [[UserCacheManager defaultManager] clearUserCacheAndEditAccount];
        [((AppDelegate *)[UIApplication sharedApplication].delegate) prepareRootController];
    }

}





#pragma mark Tip M
- (NSString *)tipFromError:(NSError *)error{
    if (error && error.userInfo) {
        NSMutableString *tipStr = [[NSMutableString alloc] init];
        if ([error.userInfo objectForKey:@"emsg"]) {
            NSString *msgStr = [error.userInfo objectForKey:@"emsg"];
            if (msgStr) {
                [tipStr appendString:msgStr];
            }
        }else{
            if ([error.userInfo objectForKey:@"NSLocalizedDescription"]) {
                tipStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            }else{
                [tipStr appendFormat:@"ErrorCode%ld", (long)error.code];
            }
        }
        return tipStr;
    }
    return nil;
}


- (void)showError:(NSError *)error{
//    if ([JDStatusBarNotification isVisible]) {//如果statusBar上面正在显示信息，则不再用hud显示error
//        NSLog(@"如果statusBar上面正在显示信息，则不再用hud显示error");
//        return;
//    }
    
    NSString *tipStr = [self tipFromError:error];
    OKAY_LOG(@"error_____%@",tipStr);
        if(error.code == APP_NETWORKFAILE){
            tipStr = @"网络不给力";
        }else if(error.code == APP_NETWOROUTTIME){
            tipStr = @"网络请求超时";
        }else if(error.code == APP_NETWORKUNFONDHOST){
            tipStr = @"网络不给力";
        }else if (error.code == APP_NSURLError_404){
            tipStr = @"网络不给力";
        }else{
            tipStr = @"网络不给力";
        }
        [self showHudTipStr:tipStr];

}


- (void)showHudTipStr:(NSString *)tipStr{
    if (tipStr && tipStr.length > 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = tipStr;
        hud.margin = 10.f;
        if((kScreenHeight - 568)<0){
            OKAY_LOG(@"DBL_EPSILON===************");
            hud.yOffset = 110;
        }else{
            hud.yOffset = 150;
        }
        hud.yOffset += 100.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:2.0];
    }
}

@end
