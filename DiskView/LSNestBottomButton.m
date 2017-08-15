//
//  LSNestBottomButton.m
//  Switch
//
//  Created by admin on 2017/4/20.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import "LSNestBottomButton.h"

@implementation LSNestBottomButton{
    UIView *viewTop;
    UIView *viewLeft;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLayoutView];
    }
    return self;
}

-(void)setLayoutView{
    viewLeft=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/4, self.frame.size.height/2, self.frame.size.width/4+5, 5)];
    viewLeft.userInteractionEnabled=NO;
    viewLeft.backgroundColor=[UIColor orangeColor];
    [self addSubview:viewLeft];
    
    viewTop=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/2, self.frame.size.height/4, 5,self.frame.size.height/4+5)];
    viewTop.backgroundColor=[UIColor orangeColor];
    viewTop.userInteractionEnabled=NO;
    [self addSubview:viewTop];
    self.showsTouchWhenHighlighted = YES;
}

-(void)setArrow:(ArrowStyle)arrow{
    if (arrow==ArrowStyle_top) {
        self.transform=CGAffineTransformMakeRotation(M_PI/4*5);
    }
    
    if (arrow==ArrowStyle_bottom) {
        self.transform=CGAffineTransformMakeRotation(M_PI/4);
        viewLeft.transform= CGAffineTransformTranslate(viewLeft.transform,7, 7);
        viewTop.transform= CGAffineTransformTranslate(viewTop.transform,7, 7);
    }
}

-(void)setArrowColor:(UIColor *)color{
    viewLeft.backgroundColor=color;
    viewTop.backgroundColor=color;
}
@end
