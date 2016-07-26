//
//  DeviceTool.h
//  Comm
//
//  Created by wanghao on 15/6/9.
//  Copyright (c) 2015年 okay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PhoneModel4 = 0,
    PhoneModel5,
    PhoneModel6,
    PhoneModel6P,
    PhoneModelOther
} OkDeviceModel;

@interface DeviceTool : NSObject

+ (int)getNetworkStatus;

+ (NSString *)getUUID;
+ (NSString *)getUA;
+ (NSString *)getDeviceVersionCode;
+ (NSString *)getSerialCode;//设备序列号
+ (int)getScreenWidthInPixel;
+ (int)getScreenHeightInPixel;

+ (NSString *)getAppVersionCode;
+ (NSString *)getAppBuildCode;

+ (OkDeviceModel)getCurDeviceModel;

@end
