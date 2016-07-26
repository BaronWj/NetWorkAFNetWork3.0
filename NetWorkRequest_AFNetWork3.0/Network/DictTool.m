//
//  DictTool.m
//  Comm
//
//  Created by wanghao on 15/8/10.
//  Copyright (c) 2015年 okay. All rights reserved.
//

#import "DictTool.h"

@implementation DictTool
+(NSString*) getStringValue:(NSDictionary*) dict
                    withKey:(NSString*) key
{
    if(![dict isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    if(![key isKindOfClass:[NSString class]]) {
        return @"";
    }
    if(key.length == 0) {
        return @"";
    }
    
    id v = dict[key];
    if(![v isKindOfClass:[NSString class]]) {
        return @"";
    }
    
    return (NSString*) v;
}

+(NSNumber*) getNumberValue:(NSDictionary*) dict
                    withKey:(NSString*) key
{
    if(![dict isKindOfClass:[NSDictionary class]]) {
        return @(0);
    }
    if(![key isKindOfClass:[NSString class]]) {
        return @(0);
    }
    if(key.length == 0) {
        return @(0);
    }
    
    id v = dict[key];
    if(![v isKindOfClass:[NSNumber class]]) {
        return @(0);
    }

    
    return (NSNumber*) v;
}

+(NSArray*) getArrayValue:(NSDictionary*) dict
                  withKey:(NSString*) key
{
    if(![dict isKindOfClass:[NSDictionary class]]) {
        return @[];
    }
    if(![key isKindOfClass:[NSString class]]) {
        return @[];
    }
    if(key.length == 0) {
        return @[];
    }
    
    id v = dict[key];
    if(![v isKindOfClass:[NSArray class]]) {
        return @[];
    }
    
    return (NSArray*) v;
}

+(NSArray*) getArrayValue:(NSDictionary*) dict
                  withKey:(NSString*) key
            withItemClass:(Class) itemClass
{
    if(![dict isKindOfClass:[NSDictionary class]]) {
        return @[];
    }
    if(![key isKindOfClass:[NSString class]]) {
        return @[];
    }
    if(key.length == 0) {
        return @[];
    }
    
    id v = dict[key];
    if(![v isKindOfClass:[NSArray class]]) {
        return @[];
    }
    
    NSArray* array = (NSArray*) v;
    
    for (id item in array) {
        if(![item isKindOfClass:itemClass]) {
            return @[];
        }
    }
    
    return array;
}

+(NSDictionary*) getDictionaryValue:(NSDictionary*) dict
                            withKey:(NSString*) key
{
    if(![dict isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    if(![key isKindOfClass:[NSString class]]) {
        return @{};
    }
    if(key.length == 0) {
        return @{};
    }
    
    id v = dict[key];
    if(![v isKindOfClass:[NSDictionary class]]) {
        return @{};
    }
    
    return (NSDictionary*) v;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}



+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


@end
