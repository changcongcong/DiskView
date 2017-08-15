//
//  LSNestControllSmallArround.m
//  Switch
//
//  Created by admin on 2017/4/20.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import "LSNestControllSmallArround.h"
#import "UIColor+Extension.h"

@implementation LSNestControllSmallArround{
    BOOL isAnimation;
}

//初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setLayoutView];
    }
    return self;
}

-(void)setLayoutView{
       [self.layer addAnimation:[self opacityForever_Animation:0.5] forKey:nil];
}

-(void)setIsFlash:(BOOL)isFlash{
    _isFlash=isFlash;
    if (isFlash) {
        [self resumeAnimation];
    }else{
        [self pauseAnimation];
    }
}

#pragma mark - 动画效果
//暂停动画
- (void)pauseAnimation {
    self.layer.timeOffset = 0;
    self.layer.speed = 0;
}

//恢复动画
- (void)resumeAnimation {
    [self.layer setTimeOffset:0];
    [self.layer setBeginTime:0];
    self.layer.speed = 1;
}

#pragma mark ===  永久闪烁的动画 ======
-(CABasicAnimation *)opacityForever_Animation:(  float )time
{
    CABasicAnimation  *animation = [ CABasicAnimation animationWithKeyPath:@"opacity" ]; // 必须写 opacity 才行。
    animation.fromValue  = [NSNumber numberWithFloat  : 1.0f ];
    animation.toValue  = [NSNumber numberWithFloat  : 0.0f ]; // 这是透明度。
    animation.autoreverses =  YES ;
    animation.duration = time;
    animation.repeatCount =  MAXFLOAT ;
    animation.removedOnCompletion  = NO ;
    animation.fillMode  = kCAFillModeForwards  ;
    return animation;
}

-(void)setArrcoundShwoColor:(arroundColor)arrcoundShwoColor{
    if (arrcoundShwoColor==arroundColor_While) {
        self.backgroundColor=[UIColor whiteColor];
    }
    
    if (arrcoundShwoColor==arroundColor_BlackShadow) {
        self.backgroundColor=[UIColor colorWithWhite:1 alpha:0.6];
    }
    
    if (arrcoundShwoColor==arroundColor_Black) {
        self.backgroundColor=[UIColor colorWithHexString:@"454343" alpha:0.2];
    }
}

@end
