//
//  ComponentAConnector.m
//  URL_Block_ProtocolDemo
//
//  Created by admin on 2018/7/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ComponentAConnector.h"
#import "LDBusMediator.h"
#import "TAEntreyAVC.h"
#import "ComponentAEnteryServicePrt.h"

@interface ComponentAConnector ()<ComponentAEnteryServicePrt>

@end
@implementation ComponentAConnector

#pragma mark - register connector

/**
 * 每个组件的实现必须自己通过load完成挂载；load只需要在挂载connector的时候完成当前connecotor的初始化，挂载量、挂载消耗、挂载所耗内存都在可控范围内；
 */
+(void)load{
    @autoreleasepool{
        [LDBusMediator registerConnector:[self sharedConnector]];
    }
}


+(nonnull ComponentAConnector *)sharedConnector{
    static ComponentAConnector *_sharedConnector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedConnector = [[ComponentAConnector alloc] init];
    });
    
    return _sharedConnector;
}

/**
 * 当前业务组件可导航的URL询问判断
 */
-(BOOL)canOpenURL:(nonnull NSURL *)URL {
    if ([URL.host isEqualToString:@"TAEntreyA"]) {
        return YES;
    }
    return NO;
}

/**
 * 业务模块挂接中间件，注册自己能够处理的URL，完成url的跳转；
 * 如果url跳转需要回传数据，则传入实现了数据接收的调用者；
 *  @param URL          跳转到的URL，通常为 productScheme://connector/relativePath
 *  @param params       伴随url的的调用参数
 *  @return
 (1) UIViewController的派生实例，交给中间件present;
 (2) nil 表示不能处理;
 (3) [UIViewController notURLController]的实例，自行处理present;
 (4) [UIViewController paramsError]的实例，参数错误，无法导航;
 */
- (nullable UIViewController *)connectToOpenURL:(nonnull NSURL *)URL params:(nullable NSDictionary *)params {
    
    if ([URL.host isEqualToString:@"TAEntreyA"]) {
        TAEntreyAVC *viewController = [[TAEntreyAVC alloc] init];
        return viewController;
    }
    
    //容错处理
    return nil;
}


/**
 * 业务模块挂接中间件，注册自己提供的service，实现服务接口的调用；
 *
 * 通过protocol协议找到组件中对应的服务实现，生成一个服务单例；
 * 传递给调用者进行protocol接口中属性和方法的调用；
 */
- (nullable id)connectToHandleProtocol:(nonnull Protocol *)servicePrt {
    if (servicePrt == @protocol(ComponentAEnteryServicePrt)) {
        return [[self class] sharedConnector];
    }
    return nil;
}


#pragma mark - ComponentBEnteryServicePrt 业务协议
- (void)componentA_jumpToComponentB {
    [LDBusMediator routeURL:[NSURL URLWithString:@"URL://TAEntreyB"]];
}

@end
