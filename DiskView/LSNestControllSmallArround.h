//
//  LSNestControllSmallArround.h
//  Switch
//
//  Created by admin on 2017/4/20.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    arroundType_small=1,//大圆
    arroundType_big=2//小圆
}arrondType;

typedef enum {
    arroundColor_Black=1,
    arroundColor_BlackShadow=2,
    arroundColor_While=3
}arroundColor;

@interface LSNestControllSmallArround : UIView

@property(assign,nonatomic)BOOL isFlash;//是否正在闪动

@property(assign,nonatomic)arrondType arrType;

@property(assign,nonatomic)NSInteger iNumber;

@property(assign,nonatomic)arroundColor arrcoundShwoColor;

@end
