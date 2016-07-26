//
//  DictTool.h
//  Comm
//
//  Created by wanghao on 15/8/10.
//  Copyright (c) 2015年 okay. All rights reserved.
//

#import <Foundation/Foundation.h>

//从dictionary里安全取值的工具，永不返回nil
@interface DictTool : NSObject

+(NSString*) getStringValue:(NSDictionary*) dict
                    withKey:(NSString*) key;

+(NSNumber*) getNumberValue:(NSDictionary*) dict
                    withKey:(NSString*) key;

+(NSArray*) getArrayValue:(NSDictionary*) dict
                  withKey:(NSString*) key;

+(NSArray*) getArrayValue:(NSDictionary*) dict
                  withKey:(NSString*) key
            withItemClass:(Class) itemClass;

+(NSDictionary*) getDictionaryValue:(NSDictionary*) dict
                            withKey:(NSString*) key;


//json字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//字典转json字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

@end
