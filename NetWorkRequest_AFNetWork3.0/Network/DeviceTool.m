//
//  DeviceTool.m
//  Comm
//
//  Created by wanghao on 15/6/9.
//  Copyright (c) 2015年 okay. All rights reserved.
//

#import "DeviceTool.h"

#import "SSKeychain.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>

static NSString *kSSToolkitTestsServiceName = @"com.okay";
static NSString *kSSToolkitTestsAccountName = @"okjiazhang";


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation DeviceTool

+ (int)getNetworkStatus
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    int netType = 0;
    //获取到网络返回码
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            //获取到状态栏
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            switch (netType) {
                case 0:
                    netType = 0;//无网模式
                    break;
                    
                case 1:
                    netType = 1;//2G;
                    break;
                case 2:
                    netType = 2;//3G;
                    break;
                case 3:
                    netType = 4;//4G;
                    break;
                case 5:
                    netType = 3;//WIFI;
                    break;
                default:
                    break;
            }
        }
    }
    return netType;
}

+ (NSString*)getUUID
{
    NSString *uuidStr = [SSKeychain passwordForService:kSSToolkitTestsServiceName
                                                account:kSSToolkitTestsAccountName];
    if(uuidStr.length == 0) {
        //set
        NSUUID* uuid = [NSUUID new];
        uuidStr = [uuid UUIDString];
        [SSKeychain setPassword:uuidStr
                     forService:kSSToolkitTestsServiceName
                        account:kSSToolkitTestsAccountName];
    }
    return uuidStr;
}

+ (int)getScreenWidthInPixel
{
    int w = [UIScreen mainScreen].bounds.size.width;
    int scale = [UIScreen mainScreen].scale;
    int ret = w * scale;
    return ret;
}

+ (int)getScreenHeightInPixel
{
    int h = [UIScreen mainScreen].bounds.size.height;
    int scale = [UIScreen mainScreen].scale;
    int ret = h * scale;
    return ret;
}

+ (NSString*)getMachine
{
    struct utsname u;
    uname(&u);
    
    NSString* name = [[NSString alloc] initWithUTF8String:u.machine];
    
    NSDictionary* config = @{
                             @"iPhone1,1": @"iPhone 2G (A1203)",
                             @"iPhone1,2": @"iPhone 3G (A1241/A1324)",
                             @"iPhone2,1": @"iPhone 3GS (A1303/A1325)",
                             @"iPhone3,1": @"iPhone 4 (A1332)",
                             @"iPhone3,2": @"iPhone 4 (A1332)",
                             @"iPhone3,3": @"iPhone 4 (A1349)",
                             @"iPhone4,1": @"iPhone 4S (A1387/A1431)",
                             @"iPhone5,1": @"iPhone 5 (A1428)",
                             @"iPhone5,2": @"iPhone 5 (A1429/A1442)",
                             @"iPhone5,3": @"iPhone 5c (A1456/A1532)",
                             @"iPhone5,4": @"iPhone 5c (A1507/A1516/A1526/A1529)",
                             @"iPhone6,1": @"iPhone 5s (A1453/A1533)",
                             @"iPhone6,2": @"iPhone 5s (A1457/A1518/A1528/A1530)",
                             @"iPhone7,1": @"iPhone 6 Plus (A1522/A1524)",
                             @"iPhone7,2": @"iPhone 6 (A1549/A1586)",
                             @"iPod1,1": @"iPod Touch 1G (A1213)",
                             @"iPod2,1": @"iPod Touch 2G (A1288)",
                             @"iPod3,1": @"iPod Touch 3G (A1318)",
                             @"iPod4,1": @"iPod Touch 4G (A1367)",
                             @"iPod5,1": @"iPod Touch 5G (A1421/A1509)",
                             @"iPad1,1": @"iPad 1G (A1219/A1337)",
                             @"iPad2,1": @"iPad 2 (A1395)",
                             @"iPad2,2": @"iPad 2 (A1396)",
                             @"iPad2,3": @"iPad 2 (A1397)",
                             @"iPad2,4": @"iPad 2 (A1395+New Chip)",
                             @"iPad2,5": @"iPad Mini 1G (A1432)",
                             @"iPad2,6": @"iPad Mini 1G (A1454)",
                             @"iPad2,7": @"iPad Mini 1G (A1455)",
                             @"iPad3,1": @"iPad 3 (A1416)",
                             @"iPad3,2": @"iPad 3 (A1403)",
                             @"iPad3,3": @"iPad 3 (A1430)",
                             @"iPad3,4": @"iPad 4 (A1458)",
                             @"iPad3,5": @"iPad 4 (A1459)",
                             @"iPad3,6": @"iPad 4 (A1460)",
                             @"iPad4,1": @"iPad Air (A1474)",
                             @"iPad4,2": @"iPad Air (A1475)",
                             @"iPad4,3": @"iPad Air (A1476)",
                             @"iPad4,4": @"iPad Mini 2G (A1489)",
                             @"iPad4,5": @"iPad Mini 2G (A1490)",
                             @"iPad4,6": @"iPad Mini 2G (A1491)",
                             @"i386": @"iPhone Simulator",
                             @"x86_64": @"iPhone Simulator"
                             };
    
    NSString* ret = config[name];
    if(!ret) {
        ret = name;
    }
    return ret;
}

+ (OkDeviceModel)getCurDeviceModel
{
    if(kScreenWidth ==  320.0f){
        if(kScreenHeight == 480.0f) {
            return PhoneModel4;
        } else {
            return PhoneModel5;
        }
    }else if(kScreenWidth == 375.0f){
        return PhoneModel6;
    }else if(kScreenWidth == 414.0f){
        return PhoneModel6P;
    }
    return PhoneModelOther;
}

+ (NSString*)getUA
{
    NSString* systemVersion = [UIDevice currentDevice].systemVersion;
    NSString* machine = [DeviceTool getMachine];
    NSString* ret = [NSString stringWithFormat:@"%@_%@",
                     machine,
                     systemVersion];
    return ret;
}

+ (NSString *)getDeviceVersionCode
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)getSerialCode
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

+ (NSString*)getAppVersionCode
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*)getAppBuildCode
{
    NSString* buildStr = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return buildStr;
}


@end
