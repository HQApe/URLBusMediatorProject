//
//  ViewController.m
//  URL_Block_ProtocolDemo
//
//  Created by admin on 2018/7/30.
//  Copyright © 2018年 admin. All rights reserved.
//

#import "ViewController.h"
#import "LDBusMediator.h"

#import "ComponentBEnteryServicePrt.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)moduleAAction:(id)sender {
    [LDBusMediator routeURL:[NSURL URLWithString:@"URL://TAEntreyA"]];
}


- (IBAction)moduleBAction:(id)sender {
    
    [LDBusMediator routeURL:[NSURL URLWithString:@"URL://TAEntreyB"]];
}

- (IBAction)moduleAPromot:(id)sender {
    
    [[LDBusMediator serviceForProtocol:@protocol(ComponentBEnteryServicePrt)] moduleB_showAlertWithMessage:@"模块B的弹窗" cancelAction:^(NSDictionary * _Nonnull info) {
        
    } confirmAction:^(NSDictionary * _Nonnull info) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
