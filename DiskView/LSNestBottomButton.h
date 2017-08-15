//
//  LSNestBottomButton.h
//  Switch
//
//  Created by admin on 2017/4/20.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ArrowStyle_top=1,//往上的箭头
    ArrowStyle_bottom=2//往下的箭头
}ArrowStyle;

@interface LSNestBottomButton : UIButton

@property(assign,nonatomic)ArrowStyle arrow;

-(void)setArrowColor:(UIColor *)color;

@end
