//
//  ComponentAEnteryServicePrt.h
//  URL_Block_ProtocolDemo
//
//  Created by admin on 2018/7/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComponentBEnteryServicePrt <NSObject>

-(void)moduleB_showAlertWithMessage:(nonnull NSString *)message
                       cancelAction:(void(^__nullable)(NSDictionary *__nonnull info))cancelAction
                      confirmAction:(void(^__nullable)(NSDictionary *__nonnull info))confirmAction;

@end
