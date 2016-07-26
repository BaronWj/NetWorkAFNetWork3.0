//
//  NSObject+Common.h
//  okayEducation
//
//  Created by 潘伟杰 on 16/5/27.
//  Copyright © 2016年 OKAY.XDF.CN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (Common)<UIAlertViewDelegate>


#pragma mark NetError
-(id)handleResponse:(id)responseJSON;
- (void)showError:(NSError *)error;


@end
