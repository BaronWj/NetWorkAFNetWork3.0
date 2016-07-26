//
//  OkayLogTool.h
//  Comm
//
//  Created by wanghao on 15/10/31.
//  Copyright © 2015年 okay. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG  // 调试状态
// 打开LOG功能
#define OKAY_LOG(fmt, ...) do {                                           \
    NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
    OkayLogv((@"%@(%s)(line:%d) " fmt), [file lastPathComponent], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \
    file = nil;                                                 \
} while(0)
#else // 发布状态
// 关闭LOG功能
#define OKAY_LOG(...)
#endif


//#define OKAY_LOG(fmt, ...) do {                                           \
//NSString* file = [[NSString alloc] initWithFormat:@"%s", __FILE__]; \
//OkayLogv((@"%@(%s)(line:%d) " fmt), [file lastPathComponent], __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \
//file = nil;                                                 \
//} while(0)

extern void OkayLogv(NSString *format, ...);
