//
//  OkayLogTool.m
//  Comm
//
//  Created by wanghao on 15/10/31.
//  Copyright © 2015年 okay. All rights reserved.
//

#import "OkayLogTool.h"
//#import "appConfigMacro.h"

void OkayLogv(NSString *format, ...) {
    {
        va_list args;
        va_start(args, format);
        NSLogv(format, args);
        va_end(args);
    }
    
#if USE_FILE_LOG
    {
        va_list args2;
        va_start(args2, format);
        NSString* s = [[NSString alloc] initWithFormat:format arguments:args2];
        NSData* d = [s dataUsingEncoding:NSUTF8StringEncoding];
        
        void (^code)() = ^() {
            static FILE* logFile = NULL;
            if(!logFile) {
                NSString *errFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                errFilePath = [errFilePath stringByAppendingPathComponent:@"log"];
                [[NSFileManager defaultManager] createDirectoryAtPath:errFilePath withIntermediateDirectories:YES attributes:nil error:nil];
                NSString *fileName =[NSString stringWithFormat:@"%@[stderr].log",[NSDate date]];
                errFilePath = [errFilePath stringByAppendingPathComponent:fileName];
                NSLog(@"log file path: %@", errFilePath);
                
                logFile = fopen([errFilePath cStringUsingEncoding:NSASCIIStringEncoding],"a+");
            }
            
            assert(logFile);
            
            fwrite(d.bytes, d.length, 1, logFile);
            
            static const char* newline = "\n";
            fwrite(newline, strlen(newline), 1, logFile);
            
            fflush(logFile);
        };
        
        if([NSThread isMainThread]) {
            code();
        }
        else {
            dispatch_sync(dispatch_get_main_queue(), code);
        }
        va_end(args2);
    }
#endif //USE_FILE_LOG
}
