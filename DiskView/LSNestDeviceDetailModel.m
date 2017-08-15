//
//  LSNestDeviceDetailModel.m
//  Switch
//
//  Created by admin on 2017/5/2.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import "LSNestDeviceDetailModel.h"
#import <objc/runtime.h>


@implementation LSNestDeviceDetailModel

-(void)setFan_timer_timeout:(NSString *)fan_timer_timeout{
    _fan_timer_timeout=fan_timer_timeout;
    NSDate *dateTimeOut=[self dateFromISO8601String:fan_timer_timeout];
    NSDate *dateTimeNow=[NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[dateTimeOut timeIntervalSince1970]];
          NSString *timeSpNow = [NSString stringWithFormat:@"%ld", (long)[dateTimeNow timeIntervalSince1970]];
    _iTimeOut=timeSp.integerValue-timeSpNow.integerValue;
}

- (NSDate *)dateFromISO8601String:(NSString *)string {
    if (!string) return nil;
    
    struct tm tm;
    time_t t;
    
    strptime([string cStringUsingEncoding:NSUTF8StringEncoding], "%Y-%m-%dT%H:%M:%S%z", &tm);
    tm.tm_isdst = -1;
    t = mktime(&tm);
    return [NSDate dateWithTimeIntervalSince1970:t + [[NSTimeZone localTimeZone] secondsFromGMT]];//东八区
}

@end
