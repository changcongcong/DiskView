//
//  LSNestControllView.h
//  Switch
//
//  Created by admin on 2017/4/20.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSNestDeviceDetailModel.h"

@interface LSNestControllView : UIView

//根据当前的开始温度，目标温度和当前温度检测是否需要运动
-(void)checkMotion;

//根据当前的参数，检测范围模式下的状态
-(void)checkMotionRange;

//是否为锁定状态，默认为否
@property(assign,nonatomic)BOOL isLock;

@property(strong,nonatomic)LSNestDeviceDetailModel *model;

@end
