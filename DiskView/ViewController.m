//
//  ViewController.m
//  DiskView
//
//  Created by admin on 2017/8/10.
//  Copyright © 2017年 常丛丛. All rights reserved.
//

#import "ViewController.h"
#import "LSNestDeviceDetailModel.h"
#import "NSObject+MJKeyValue.h"
#import "LSNestControllView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LSNestDeviceDetailModel  *modelNew=[self addNotion];
    LSNestControllView *view=[[LSNestControllView alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
    view.center=self.view.center;
    view.model=modelNew;
    [self.view addSubview:view];
}


-(LSNestDeviceDetailModel *)addNotion{
    NSDictionary *dicDevice=@{@"ambient_temperature_c":@"10.5",
                              @"ambient_temperature_f":@"51",
                              @"can_cool":@"1",
                              @"can_heat":@"1",
                              @"device_id":@"123456",
                              @"fan_timer_active":@"0",
                              @"fan_timer_duration":@"60",
                              @"fan_timer_timeout":@"2017-06-10T04:26:25.000Z",
                              @"has_fan":@"1",
                              @"has_leaf":@"0",
                              @"hvac_mode":@"heat",
                              @"hvac_state":@"heating",
                              @"is_locked":@"0",
                              @"is_online":@"1",
                              @"label":@"DE012cccc",
                              @"locked_temp_max_c":@"22",
                              @"locked_temp_max_f":@"72",
                              @"locked_temp_min_c":@"20",
                              @"locked_temp_min_f":@"68",
                              @"name":@"Basement (DE012)",
                              @"name_long":@"Basement Thermostat (DE012)",
                              @"target_temperature_c":@"30.5",
                              @"target_temperature_f":@"87",
                              @"target_temperature_high_c":@"11.5",
                              @"target_temperature_high_f":@"53",
                              @"target_temperature_low_c":@"10",
                              @"target_temperature_low_f":@"50",
                              @"where_name":@"Basement"};
    LSNestDeviceDetailModel  *modelNew=[LSNestDeviceDetailModel objectWithKeyValues:dicDevice];
    return modelNew;
    
}


@end
