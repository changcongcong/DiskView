//
//  LSNestControllView.m
//  Switch
//
//  Created by admin on 2017/4/20.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import "LSNestControllView.h"
#import "LSNestControllSmallArround.h"
#import "LSNestBottomButton.h"
#import "UIColor+Extension.h"

//在范围模式选择的左右两边类型
typedef enum {
    TemRangeSelectType_left=1,
    TemRangeSelectType_Right=2,
    TemRangeSelectType_normal=3
}TemRangeSelectType;

@implementation LSNestControllView{
    CGFloat fDrawHeight;//本控件高度
    CGFloat fDrawWeight;//本控件宽度
    CGFloat fArround;//圆的半径
    UIView *viewRound;
    NSMutableArray *arraySmallArround;
    CGFloat fDefault;//底部角度
    CGFloat fDefaultArroundInto;
    LSNestBottomButton *btnLeft;
    LSNestBottomButton *btnRight;
    UILabel *lblTitle,*lblTargetTemper;
    UIImageView *imgState;//状态图片
    UILabel *lblState;
    UIImageView *imgType;
    UIView *viewRange;
    UILabel *lblLeftRangeTitle,*lblRightRangeTitle;
    UILabel *lblLeftRangeSubmit,*lblRightRangeSubmit;
    UILabel *lblTargetTemperShow;
    UIView *viewLock1,*viewLock2,*viewLock3;//锁定是显示界面
    UIView *viewLockOff,*viewLockOff2,*viewLockOff3;//关闭状态显示界面
    TemRangeSelectType typeRangeSelectType;
    float temMin,temMax,temMum;
    BOOL isActive;//风扇是否旋转
    
    
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
    fDefault=120;
    //默认制热状态
    fDrawHeight=self.frame.size.height;
    fArround=self.frame.size.height*27/64;
    fDrawWeight=self.frame.size.width;
    arraySmallArround=[[NSMutableArray alloc]init];
    fDefaultArroundInto=fArround*15/135;
    typeRangeSelectType=TemRangeSelectType_normal;
    
    temMin=50;
    temMax=90;
    temMum=12;
    [self startDraw];
}

-(void)startDraw{
    //画圆
    viewRound=[[UIView alloc]initWithFrame:CGRectMake(fDrawWeight/2-fArround, 0, 2*fArround, 2*fArround)];
    viewRound.layer.masksToBounds=YES;
    viewRound.layer.borderColor=[UIColor whiteColor].CGColor;
    viewRound.layer.borderWidth=5;
    viewRound.layer.cornerRadius=fArround;
    viewRound.backgroundColor=[UIColor orangeColor];
    [self addSubview:viewRound];
    
    //添加周围小圆圈
    [self addSmallRound];
    
    //添加动态控件
    [self addInsideMotion];
    
    //添加锁定时候的界面
    [self addSmallRondNoDataBG];

    //添加下面两个按钮
    [self addBottomButton];

    //添加锁定时候的界面
    [self addButtonLockView];
}

-(void)addBottomButton{
    btnLeft=[[LSNestBottomButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*5/16, self.frame.size.height*5/16)];
    btnLeft.center=CGPointMake(self.frame.size.width*105/320, viewRound.frame.size.height-self.frame.size.height*2/32);
    btnLeft.backgroundColor=[UIColor whiteColor];
    btnLeft.layer.masksToBounds=YES;
    btnLeft.layer.cornerRadius=self.frame.size.height*5/32;
    btnLeft.layer.borderColor=[UIColor orangeColor].CGColor;
    btnLeft.layer.borderWidth=1;
    btnLeft.arrow=ArrowStyle_bottom;
    [btnLeft addTarget:self action:@selector(btnLeft_Click) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnLeft];
    
    btnRight=[[LSNestBottomButton alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*5/16, self.frame.size.height*5/16)];
    btnRight.center=CGPointMake(self.frame.size.width*215/320, viewRound.frame.size.height-self.frame.size.height*2/32);
    btnRight.backgroundColor=[UIColor whiteColor];
    btnRight.layer.masksToBounds=YES;
    btnRight.layer.cornerRadius=self.frame.size.height*5/32;
    btnRight.layer.borderColor=[UIColor orangeColor].CGColor;
    btnRight.layer.borderWidth=1;
    btnRight.arrow=ArrowStyle_top;
    [btnRight addTarget:self action:@selector(btnRight_Click) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnRight];
}

-(void)addSmallRondNoDataBG{
    viewLock1=[[UIView alloc]initWithFrame:CGRectMake(fDrawWeight/2-fArround, 0, 2*fArround, 2*fArround)];
    viewLock1.backgroundColor=[UIColor colorWithHexString:@"000000" alpha:0.6];
    viewLock1.layer.cornerRadius=fArround;
    viewLock1.layer.masksToBounds=YES;
    [self addSubview:viewLock1];
    
    viewLockOff=[[UIView alloc]initWithFrame:CGRectMake(fDrawWeight/2-fArround, 0, 2*fArround, 2*fArround)];
    viewLockOff.backgroundColor=[UIColor colorWithHexString:@"000000" alpha:0.6];
    viewLockOff.layer.cornerRadius=fArround;
    viewLockOff.layer.masksToBounds=YES;
    [self addSubview:viewLockOff];
    
    UILabel *lblShowOff=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 2*fArround, 70)];
    lblShowOff.textColor=[UIColor whiteColor];
    lblShowOff.font=[UIFont fontWithName:@"HelveticaNeue" size:20];
    lblShowOff.text=@"Thermostat is off";
    lblShowOff.textAlignment=NSTextAlignmentCenter;
    lblShowOff.center=CGPointMake(fArround, viewRound.center.y+40);
    [viewLockOff addSubview:lblShowOff];
    
    UIImageView *imgHead=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 55, 70)];
    imgHead.center=CGPointMake(fArround, viewRound.center.y-35);
    imgHead.image=[UIImage imageNamed:@"icon_nest_islockShow.png"];
    [viewLock1 addSubview:imgHead];
    
    UILabel *lblLockSubmit=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 2*fArround, 70)];
    lblLockSubmit.textColor=[UIColor whiteColor];
    lblLockSubmit.font=[UIFont fontWithName:@"HelveticaNeue" size:20];
    lblLockSubmit.numberOfLines=2;
    lblLockSubmit.text=@"Nest Thermostat\ntemperature is locked";
    lblLockSubmit.textAlignment=NSTextAlignmentCenter;
    lblLockSubmit.center=CGPointMake(fArround, viewRound.center.y+30);
    [viewLock1 addSubview:lblLockSubmit];
    viewLock1.hidden=YES;
    viewLockOff.hidden=YES;
}

//添加圆弧周围小圆圈
-(void)addSmallRound{
    [arraySmallArround removeAllObjects];
    if (temMum<1) {
        return ;
    }
    
    for (int i=0; i<temMum+1; i++) {
        BOOL isHideSmallArrow=NO;
        CGFloat fWide=fArround*12/135;
        if (i%2==1) {
            fWide=fArround*7/135;
            isHideSmallArrow=YES;
        }
        LSNestControllSmallArround *view=[[LSNestControllSmallArround alloc]initWithFrame:CGRectMake(0, 0, fWide, fWide)];
        view.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*i andWithRadius:fArround-fDefaultArroundInto];
        view.backgroundColor=[UIColor redColor];
        view.layer.masksToBounds=YES;
        view.layer.cornerRadius=fWide/2;
        view.iNumber=i;
        view.hidden=isHideSmallArrow;
        if (isHideSmallArrow) {
            view.arrType=arroundType_small;
        }else{
            view.arrType=arroundType_big;
        }
        view.arrcoundShwoColor=arroundColor_Black;
        [self addSubview:view];
        [arraySmallArround addObject:view];
    }
}

-(void)addInsideMotion{
    lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height*30/320, self.frame.size.width, self.frame.size.height*40/320)];
    lblTitle.textColor=[UIColor whiteColor];
    lblTitle.font=[UIFont fontWithName:@"HelveticaNeue" size:17];
    lblTitle.textAlignment=NSTextAlignmentCenter;
    [self addSubview:lblTitle];
    
    lblTargetTemper=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height*55/320, self.frame.size.width, self.frame.size.height*100/320)];
    lblTargetTemper.textColor=[UIColor whiteColor];
    lblTargetTemper.font=[UIFont fontWithName:@"HelveticaNeue" size:125];
    lblTargetTemper.text=@"--";
    lblTargetTemper.textAlignment=NSTextAlignmentCenter;
    [self addSubview:lblTargetTemper];
    
    
    lblState=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 29)];
    lblState.textColor=[UIColor whiteColor];
    lblState.center=CGPointMake(self.center.x, self.frame.size.height*200/320);
    lblState.font=[UIFont fontWithName:@"HelveticaNeue" size:24];
    lblState.textAlignment=NSTextAlignmentCenter;
    [self addSubview:lblState];
    
    viewRange=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/5, self.frame.size.height*70/320, self.frame.size.width*3/5, self.frame.size.height*105/320)];
    viewRange.backgroundColor=[UIColor orangeColor];
    [self addSubview:viewRange];
    
    //左边部分
    UIView *viewLeftRange=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width*90/320, self.frame.size.height*85/320)];
    [viewRange addSubview:viewLeftRange];
    viewLeftRange.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapLeftRange=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapLeftRange_Click)];
    [viewLeftRange addGestureRecognizer:tapLeftRange];
    viewRange.hidden=YES;
    
    lblLeftRangeTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,  self.frame.size.width*90/320, self.frame.size.height*20/320)];
    lblLeftRangeTitle.text=@"HEAT";
    lblLeftRangeTitle.font=[UIFont systemFontOfSize:20];
    lblLeftRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
    lblLeftRangeTitle.textAlignment=NSTextAlignmentCenter;
    [viewLeftRange addSubview:lblLeftRangeTitle];
    
    lblLeftRangeSubmit=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height*20/320,  self.frame.size.width*90/320, self.frame.size.height*85/320)];
    lblLeftRangeSubmit.font=[UIFont fontWithName:@"HelveticaNeue" size:70];
    lblLeftRangeSubmit.text=@"--";
    lblLeftRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
    lblLeftRangeSubmit.textAlignment=NSTextAlignmentCenter;
    [viewLeftRange addSubview:lblLeftRangeSubmit];
    
    //右边部分
    UIView *viewRightRange=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.height*102/320, 0, self.frame.size.width*90/320, self.frame.size.height*85/320)];
    [viewRange addSubview:viewRightRange];
    viewRightRange.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapRightRange=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRightRange_Click)];
    [viewRightRange addGestureRecognizer:tapRightRange];
   // viewRightRange.hidden=YES;
    
    lblRightRangeTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,  self.frame.size.width*90/320, self.frame.size.height*20/320)];
    lblRightRangeTitle.text=@"COOL";
    lblRightRangeTitle.font=[UIFont systemFontOfSize:20];
    lblRightRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
    lblRightRangeTitle.textAlignment=NSTextAlignmentCenter;
    [viewRightRange addSubview:lblRightRangeTitle];
    
    lblRightRangeSubmit=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height*20/320,  self.frame.size.width*90/320, self.frame.size.height*85/320)];
    lblRightRangeSubmit.font=[UIFont fontWithName:@"HelveticaNeue" size:70];
    lblRightRangeSubmit.text=@"--";
    lblRightRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
    lblRightRangeSubmit.textAlignment=NSTextAlignmentCenter;
    [viewRightRange addSubview:lblRightRangeSubmit];
    
    lblTargetTemperShow=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 35, 20)];
    lblTargetTemperShow.textColor=[UIColor whiteColor];
    lblTargetTemperShow.textAlignment=NSTextAlignmentCenter;
    lblTargetTemperShow.font=[UIFont systemFontOfSize:12];
    [self addSubview:lblTargetTemperShow];
    
    imgState=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 23)];
    imgState.center=CGPointMake(self.frame.size.width/2, self.frame.size.height*180/320);
    [self addSubview:imgState];
    imgState.image=[UIImage imageNamed:@"icon_nestshape.png"];
    
    imgType=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 23, 23)];
    imgType.center=CGPointMake(self.frame.size.width/2, self.frame.size.height*205/320);
    [self addSubview:imgType];
    imgType.image=[UIImage imageNamed:@"fan_title_icon.png"];
    [self spinWithOptions:imgType];
    
    UILabel *lblPoint=[[UILabel alloc]initWithFrame:CGRectMake(0, 0,  50, 50)];
    lblPoint.center=CGPointMake(self.frame.size.width*95/320, self.frame.size.height*85/640);
    lblPoint.text=@".";
    lblPoint.textAlignment=NSTextAlignmentCenter;
    lblPoint.textColor=[UIColor whiteColor];
    lblPoint.font=[UIFont systemFontOfSize:60];
    [viewRange addSubview:lblPoint];
}

- (void) spinWithOptions: (UIView *) viewArround {
    //CATransform3D rotationTransform  = CATransform3DMakeRotation(2*M_PI, 0, 0,1);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    // 设定旋转角度
    animation.fromValue = [NSNumber numberWithFloat:0.0]; // 起始角度
    animation.toValue = [NSNumber numberWithFloat:2* M_PI]; // 终止角度
    animation.duration= 1;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= HUGE_VALF;
    // 添加动画
    [viewArround.layer addAnimation:animation forKey:@"rotate-layer"];
}


-(void)tapRightRange_Click{
    typeRangeSelectType=TemRangeSelectType_Right;
    [self checkMotion];
}

-(void)tapLeftRange_Click{
    typeRangeSelectType=TemRangeSelectType_left;
    [self checkMotion];
}

//添加锁定时候的界面
-(void)addButtonLockView{
    viewLock2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*5/16, self.frame.size.height*5/16)];
    viewLock2.backgroundColor=[UIColor colorWithHexString:@"000000" alpha:0.6];
    viewLock2.layer.masksToBounds=YES;
    viewLock2.center=CGPointMake(self.frame.size.width*105/320, viewRound.frame.size.height-self.frame.size.height*2/32);
    viewLock2.layer.cornerRadius=self.frame.size.height*5/32;
    [self addSubview:viewLock2];

    viewLock3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*5/16, self.frame.size.height*5/16)];
    viewLock3.backgroundColor=[UIColor colorWithHexString:@"000000" alpha:0.6];
    viewLock3.layer.masksToBounds=YES;
    viewLock3.center=CGPointMake(self.frame.size.width*215/320, viewRound.frame.size.height-self.frame.size.height*2/32);
    viewLock3.layer.cornerRadius=self.frame.size.height*5/32;
    [self addSubview:viewLock3];
    
    viewLock3.hidden=YES;
    viewLock2.hidden=YES;

    viewLockOff2=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*5/16, self.frame.size.height*5/16)];
    viewLockOff2.backgroundColor=[UIColor colorWithHexString:@"000000" alpha:0.6];
    viewLockOff2.layer.masksToBounds=YES;
    viewLockOff2.center=CGPointMake(self.frame.size.width*105/320, viewRound.frame.size.height-self.frame.size.height*2/32);
    viewLockOff2.layer.cornerRadius=self.frame.size.height*5/32;
    [self addSubview:viewLockOff2];
    
    viewLockOff3=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.height*5/16, self.frame.size.height*5/16)];
    viewLockOff3.backgroundColor=[UIColor colorWithHexString:@"000000" alpha:0.6];
    viewLockOff3.layer.masksToBounds=YES;
    viewLockOff3.center=CGPointMake(self.frame.size.width*215/320, viewRound.frame.size.height-self.frame.size.height*2/32);
    viewLockOff3.layer.cornerRadius=self.frame.size.height*5/32;
    [self addSubview:viewLockOff3];
    
    viewLockOff3.hidden=YES;
    viewLockOff2.hidden=YES;
}

-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat) radius{
    CGFloat x2 = radius*cosf(angle*M_PI/180);
    CGFloat y2 = radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

//判断当前
-(void)checkMotion{
    [self InitializationMotion];
    //制热模式
    if (_model.modelTem==modelHight) {
        [self checkMotionHight];
    }
    
    if (_model.modelTem==modelCool) {
        [self checkMotionCool];
    }
    
    if (_model.modelTem==modelRange) {
        [self checkMotionRange];
    }
    
    //状态区分
    if (_model.modelState==modelHighting) {
        [self checkMotionHighting];
    }else if (_model.modelState==modelCooling) {
        [self checkMotionCooling];
    }else{
        [self checkMotionNormal];
    }
    
    if (_model.modelTem==modelOff) {
        [self checkMotionOffing];
    }
}

-(void)checkMotionOffing{
    lblTargetTemper.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_f.floatValue];
    viewLockOff.hidden=NO;
    viewLockOff2.hidden=NO;
    viewLockOff3.hidden=NO;
    viewRound.backgroundColor=[UIColor colorWithHexString:@"9D9D9D"];
    btnLeft.layer.borderColor=[UIColor colorWithHexString:@"9D9D9D"].CGColor;
    btnRight.layer.borderColor=[UIColor colorWithHexString:@"9D9D9D"].CGColor;
    [btnLeft setArrowColor:[UIColor colorWithHexString:@"9D9D9D"]];
    [btnRight setArrowColor:[UIColor colorWithHexString:@"9D9D9D"]];
    imgType.hidden=YES;
    imgState.hidden=YES;
}

//正在加热
-(void)checkMotionHighting{
    //更改界面颜色和风格
    viewRound.backgroundColor=[UIColor orangeColor];
    btnLeft.layer.borderColor=[UIColor orangeColor].CGColor;
    btnRight.layer.borderColor=[UIColor orangeColor].CGColor;
    [btnLeft setArrowColor:[UIColor orangeColor]];
    [btnRight setArrowColor:[UIColor orangeColor]];
}

//正在制冷
-(void)checkMotionCooling{
    viewRound.backgroundColor=[UIColor colorWithHexString:@"30B5FF" alpha:1];
    btnLeft.layer.borderColor=[UIColor colorWithHexString:@"30B5FF" alpha:1].CGColor;
    btnRight.layer.borderColor=[UIColor colorWithHexString:@"30B5FF" alpha:1].CGColor;
    [btnLeft setArrowColor:[UIColor colorWithHexString:@"30B5FF" alpha:1]];
    [btnRight setArrowColor:[UIColor colorWithHexString:@"30B5FF" alpha:1]];
    viewRange.backgroundColor=[UIColor colorWithHexString:@"30B5FF" alpha:1];
}

-(void)checkMotionNormal{
    viewRound.backgroundColor=[UIColor colorWithHexString:@"5F6573"];
    btnLeft.layer.borderColor=[UIColor colorWithHexString:@"5F6573"].CGColor;
    btnRight.layer.borderColor=[UIColor colorWithHexString:@"5F6573"].CGColor;
    [btnLeft setArrowColor:[UIColor colorWithHexString:@"5F6573"]];
    [btnRight setArrowColor:[UIColor colorWithHexString:@"5F6573"]];
    viewRange.backgroundColor=[UIColor colorWithHexString:@"5F6573" alpha:1];
}

//初始化运动界面
-(void)InitializationMotion{
    for (LSNestControllSmallArround *viewArround in arraySmallArround) {
        viewArround.isFlash=NO;
        viewArround.arrcoundShwoColor=arroundColor_Black;
        if (viewArround.arrType==arroundType_small) {
            viewArround.hidden=YES;
        }
    }
    lblTargetTemperShow.text=@"";
    lblTargetTemper.text=@"";
    lblState.text=@"";
    viewRound.backgroundColor=[UIColor clearColor];
    btnLeft.layer.borderColor=[UIColor clearColor].CGColor;
    [btnLeft setArrowColor:[UIColor clearColor]];
    [btnRight setArrowColor:[UIColor clearColor]];
    viewRange.backgroundColor=[UIColor clearColor];
    viewRange.hidden=YES;
    lblLeftRangeSubmit.text=@"--";
    lblRightRangeSubmit.text=@"--";
    
    viewLockOff.hidden=YES;
    viewLockOff2.hidden=YES;
    viewLockOff3.hidden=YES;
    viewRound.backgroundColor=[UIColor clearColor];
}

-(void)checkMotionRange{
    viewRange.hidden=NO;
    [self motionRangeCommon];
    if (_model.ambient_temperature_f.floatValue<_model.target_temperature_low_f.floatValue) {//启动加温
        [self motionRangeHight];
    }else if (_model.ambient_temperature_f.floatValue>_model.target_temperature_high_f.floatValue) {//启动降温
        [self motionRangeCool];
    }else{//正常范围
        [self motionRangeNormal];
    }
}

-(void)motionRangeCommon{
    if (typeRangeSelectType==TemRangeSelectType_normal) {
        lblLeftRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
        lblRightRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
        lblLeftRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
        lblRightRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
    }else if (typeRangeSelectType==TemRangeSelectType_left){
        lblLeftRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:1];
        lblRightRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
        lblLeftRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:1];
        lblRightRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
    }else{
        lblLeftRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
        lblRightRangeTitle.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:1];
        lblLeftRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:0.6];
        lblRightRangeSubmit.textColor=[UIColor colorWithHexString:@"FFFFFF" alpha:1];
    }
    lblLeftRangeSubmit.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_low_f.floatValue];
    lblRightRangeSubmit.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_high_f.floatValue];
}

-(void)motionRangeHight{
    //温度范围内显示淡白色
    //每个点负责的温度范围
    CGFloat fRangePoint=(temMax-temMin)/temMum;
    //计算最小的点的位置
    int iRangeState=(_model.target_temperature_low_f.floatValue-temMin)/fRangePoint;
    //计算最大的点的位置
    int iRangeEnd=(_model.target_temperature_high_f.floatValue-temMin)/fRangePoint;
    //最大最小的点之间的全部暗灰色
    for (int i=iRangeState; i<iRangeEnd+1; i++) {
        LSNestControllSmallArround *view=arraySmallArround[i];
       // if (view.arrType==arroundType_big) {
            view.hidden=NO;
            view.arrcoundShwoColor=arroundColor_BlackShadow;
       // }
        //第一个闪亮
        if (i==iRangeState) {
            view.isFlash=YES;
            view.arrcoundShwoColor=arroundColor_While;
        }else{
            view.isFlash=NO;
        }
    }
    /*
    //起始温度与目标温度之间动态显示
    //计算最大的点的位置
    int iStart=(temMin-temMin)/fRangePoint;
    //最大最小的点之间的全部暗灰色
    for (int i=iStart; i<iRangeState+1; i++) {
        LSNestControllSmallArround *view=arraySmallArround[i];
        view.hidden=NO;
        view.arrcoundShwoColor=arroundColor_BlackShadow;
    }*/

    //执行过的温度显示白色圆圈
    //计算最小的点的位置
    int iRangeStateTemper=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
    /*
    for (int i=iStart; i<iRangeStateTemper+1; i++) {
        LSNestControllSmallArround *view=arraySmallArround[i];
        view.hidden=NO;
        view.arrcoundShwoColor=arroundColor_While;
    }
     */
    
    LSNestControllSmallArround *view=arraySmallArround[iRangeStateTemper];
    view.hidden=NO;
    view.arrcoundShwoColor=arroundColor_While;
    
    lblTargetTemperShow.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*iRangeStateTemper andWithRadius:fArround-fArround*35/135];
    lblTargetTemperShow.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
}

-(void)motionRangeCool{
    //温度范围内显示淡白色
    //每个点负责的温度范围
    CGFloat fRangePoint=(temMax-temMin)/temMum;
    //计算最小的点的位置
    int iRangeState=(_model.target_temperature_low_f.floatValue-temMin)/fRangePoint;
    //计算最大的点的位置
    int iRangeEnd=(_model.target_temperature_high_f.floatValue-temMin)/fRangePoint;
    //最大最小的点之间的全部暗灰色
    for (int i=iRangeState; i<iRangeEnd+1; i++) {
        LSNestControllSmallArround *view=arraySmallArround[i];
   //     if (view.arrType==arroundType_big) {
            view.hidden=NO;
            view.arrcoundShwoColor=arroundColor_BlackShadow;
    //    }
        //最后一个闪亮
        if (i==iRangeEnd) {
            view.isFlash=YES;
            view.arrcoundShwoColor=arroundColor_While;
        }else{
            view.isFlash=NO;
        }
    }
    
    /*
    //起始温度与目标温度之间动态显示
    //计算最大的点的位置
    int iEnd=(temMax-temMin)/fRangePoint;
    //最大最小的点之间的全部暗灰色
    for (int i=iRangeEnd; i<iEnd+1; i++) {
        LSNestControllSmallArround *view=arraySmallArround[i];
        view.hidden=NO;
        view.arrcoundShwoColor=arroundColor_BlackShadow;
    }*/
    
    //执行过的温度显示白色圆圈
    //计算最小的点的位置
    int iRangeStateTemper=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
  //  for (int i=iRangeStateTemper; i<iEnd+1; i++) {
        LSNestControllSmallArround *view=arraySmallArround[iRangeStateTemper];
        view.hidden=NO;
        view.arrcoundShwoColor=arroundColor_While;
   // }
    
    lblTargetTemperShow.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*iRangeStateTemper andWithRadius:fArround+3-fArround*35/135];
    lblTargetTemperShow.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
}

-(void)motionRangeNormal{
    //改变周围原点状态
    if (_model.ambient_temperature_f.floatValue>_model.target_temperature_low_f.floatValue&&_model.ambient_temperature_f.floatValue<_model.target_temperature_high_f.floatValue) {
        //计算应该显示的温度范围
        //每个点负责的温度范围
        CGFloat fRangePoint=(temMax-temMin)/temMum;
        //计算最小的点的位置
        int iState=(_model.target_temperature_low_f.floatValue-temMin)/fRangePoint;
        //计算最大的点的位置
        int iEnd=(_model.target_temperature_high_f.floatValue-temMin)/fRangePoint;
        //最大最小的点之间的全部暗灰色
        for (int i=iState; i<iEnd+1; i++) {
            LSNestControllSmallArround *view=arraySmallArround[i];
            view.hidden=NO;
            view.arrcoundShwoColor=arroundColor_BlackShadow;
        }
        int iEndCompete=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
        lblTargetTemperShow.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*iEndCompete andWithRadius:fArround-fArround*35/135];
        lblTargetTemperShow.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
    }else{
       // lblTargetTemper.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_high_f.floatValue];
    //    lblState.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_high_f.floatValue];
    }
}

//制冷模式下的运动界面
-(void)checkMotionCool{
    //改变周围原点状态
    if (_model.ambient_temperature_f.floatValue>_model.target_temperature_f.floatValue) {
        //计算应该显示的温度范围
        //每个点负责的温度范围
        CGFloat fRangePoint=(temMax-temMin)/temMum;
        //计算最小的点的位置
        int iState=(_model.target_temperature_f.floatValue-temMin)/fRangePoint;
        //计算最大的点的位置
        int iEnd=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
        //最大最小的点之间的全部暗灰色
        for (int i=iState; i<iEnd+1; i++) {
            LSNestControllSmallArround *view=arraySmallArround[i];
            view.hidden=NO;
            view.arrcoundShwoColor=arroundColor_BlackShadow;
            //最后一个闪亮
            if (i==iState) {
                view.isFlash=YES;
                view.arrcoundShwoColor=arroundColor_While;
            }else{
                view.isFlash=NO;
            }
        }
        
        /*
        //最小，现在温度之间白色
        //计算完成的点的位置
        int iEndCompete=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
        for (int i=iEndCompete; i<iEnd+1; i++) {
            LSNestControllSmallArround *view=arraySmallArround[i];
            view.hidden=NO;
            view.arrcoundShwoColor=arroundColor_While;
        }*/
        
        //现在的温度显示
        lblTargetTemperShow.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*iEnd andWithRadius:fArround-fArround*35/135];
        lblTargetTemperShow.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
        
        //目标温度和现在温度
        lblTargetTemper.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_f.floatValue];
       // lblState.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
    }else{
        lblTargetTemper.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_f.floatValue];
       // lblState.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
        CGFloat fRangePoint=(temMax-temMin)/temMum;
        int iEndCompete=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
        lblTargetTemperShow.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*iEndCompete andWithRadius:fArround-fArround*35/135];
        lblTargetTemperShow.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
    
    }
}

//制热模式下运动
-(void)checkMotionHight{
    //改变周围原点状态
    if (_model.ambient_temperature_f.floatValue<_model.target_temperature_f.floatValue) {
        //计算应该显示的温度范围
        //每个点负责的温度范围
        CGFloat fRangePoint=(temMax-temMin)/temMum;
        //计算最小的点的位置
        int iState=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
        //计算最大的点的位置
        int iEnd=(_model.target_temperature_f.floatValue-temMin)/fRangePoint;
        //最大最小的点之间的全部暗灰色
        for (int i=iState; i<iEnd+1; i++) {
            LSNestControllSmallArround *view=arraySmallArround[i];
            view.hidden=NO;
            view.arrcoundShwoColor=arroundColor_BlackShadow;
            //最后一个闪亮
            if (i==iEnd) {
                view.isFlash=YES;
                view.arrcoundShwoColor=arroundColor_While;
            }else{
                view.isFlash=NO;
            }
        }

        /*
        //最小，现在温度之间白色
        //计算完成的点的位置
        int iEndCompete=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
        for (int i=iState; i<iEndCompete+1; i++) {
            LSNestControllSmallArround *view=arraySmallArround[i];
            view.hidden=NO;
            view.arrcoundShwoColor=arroundColor_While;
        }*/
        
        //现在的温度显示
        lblTargetTemperShow.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*iState andWithRadius:fArround-fArround*35/135];
        lblTargetTemperShow.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
        
        //目标温度和现在温度
        lblTargetTemper.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_f.floatValue];
      //  lblState.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
    }else{
        lblTargetTemper.text=[NSString stringWithFormat:@"%.0f",_model.target_temperature_f.floatValue];
        CGFloat fRangePoint=(temMax-temMin)/temMum;
        int iEndCompete=(_model.ambient_temperature_f.floatValue-temMin)/fRangePoint;
        lblTargetTemperShow.center=[self calcCircleCoordinateWithCenter:CGPointMake(fDrawWeight/2, fArround) andWithAngle:360-fDefault/2-90-((360-fDefault)/temMum)*iEndCompete andWithRadius:fArround-fArround*35/135];
        lblTargetTemperShow.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];

      //  lblState.text=[NSString stringWithFormat:@"%.0f",_model.ambient_temperature_f.floatValue];
    }
}

//左边按钮点击事件
-(void)btnLeft_Click{
    if (_model.modelTem==modelOff) {
        return ;
    }
    
    if (_model.modelTem==modelRange) {
        [self btnLeftClick_Range];
    }else{
        [self btnLeftClick_Temper];
    }
}

//范围模式下左边按钮点击事件
-(void)btnLeftClick_Range{
    if (typeRangeSelectType==TemRangeSelectType_left) {
        [self showSeletMotiom];
        if (_model.target_temperature_low_f.floatValue==temMin) {
            return ;
        }
        /*
        if (_model.is_locked.boolValue&&_model.target_temperature_low_f.floatValue<_model.locked_temp_min_f.floatValue+1) {
            self.isLock=YES;
            [MyCommon runBlockInMainQueue:^{
                self.isLock=NO;
            } afterDelay:0.5];
            return ;
        }*/
        
        if (_model.target_temperature_low_f.floatValue-1<temMin) {
            _model.target_temperature_low_f=[NSString stringWithFormat:@"%f",temMin];
            [self SendTemperateWithTitle1:@"target_temperature_low_f" withTarget1:_model.target_temperature_low_f WithTitle2:@"target_temperature_high_f" withTarget2:_model.target_temperature_high_f];
            [self checkMotion];
            return ;
        }

        _model.target_temperature_low_f=[NSString stringWithFormat:@"%f",_model.target_temperature_low_f.floatValue-1];
        [self SendTemperateWithTitle1:@"target_temperature_low_f" withTarget1:_model.target_temperature_low_f
                           WithTitle2:@"target_temperature_high_f" withTarget2:_model.target_temperature_high_f];
        [self checkMotion];
    }
    
    if (typeRangeSelectType==TemRangeSelectType_Right) {
        [self showSeletMotiom];
        /*
        if (_model.is_locked.boolValue&&_model.target_temperature_high_f.floatValue<_model.locked_temp_min_f.floatValue+4) {
            self.isLock=YES;
            [MyCommon runBlockInMainQueue:^{
                self.isLock=NO;
            } afterDelay:0.5];
            return ;
        }
        */
        if (_model.target_temperature_high_f.floatValue-4<_model.target_temperature_low_f.floatValue) {
           if (_model.target_temperature_high_f.floatValue-4<50) {
               return ;
            }
            _model.target_temperature_low_f=[NSString stringWithFormat:@"%f",_model.target_temperature_low_f.floatValue-1];
        }
        
        _model.target_temperature_high_f=[NSString stringWithFormat:@"%f",_model.target_temperature_high_f.floatValue-1];
        [self SendTemperateWithTitle1:@"target_temperature_low_f" withTarget1:_model.target_temperature_low_f
                           WithTitle2:@"target_temperature_high_f" withTarget2:_model.target_temperature_high_f];
        [self checkMotion];
    }
}

-(void)SendTemperateWithTitle1:(NSString *)strTitle1 withTarget1:(NSString *)strTarget1 WithTitle2:(NSString *)strTitle2 withTarget2:(NSString *)strTarget2{
     /*
    _model.strTitle1=strTitle1;
    _model.strTarget1=strTarget1;
    _model.strTitle2=strTitle2;
    _model.strTarget2=strTarget2;
    _model.isNeedData=YES;
    NSDate *senddate = [NSDate date];
    _model.strTimeClickRememory= [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]+5];
     */
}

//制冷，制热模式下
-(void)btnLeftClick_Temper{
    [self showSeletMotiom];
    if (_model.target_temperature_f.integerValue==temMin) {
        return ;
    }
    /*
    if (_model.is_locked.boolValue&&_model.locked_temp_min_f.floatValue+1>_model.target_temperature_f.floatValue) {
        self.isLock=YES;
        [MyCommon runBlockInMainQueue:^{
            self.isLock=NO;
        } afterDelay:0.5];
        return ;
    }*/
    
    if (_model.target_temperature_f.integerValue-1<temMin) {
        _model.target_temperature_f=[NSString stringWithFormat:@"%f",temMin];
        [self SendTemperateWithTitle1:@"target_temperature_f" withTarget1:_model.target_temperature_f
                           WithTitle2:@"" withTarget2:@""];
        [self checkMotion];
        return ;
    }
    _model.target_temperature_f=[NSString stringWithFormat:@"%f",_model.target_temperature_f.floatValue-1];
    [self SendTemperateWithTitle1:@"target_temperature_f" withTarget1:_model.target_temperature_f
                       WithTitle2:@"" withTarget2:@""];
    [self checkMotion];
}

-(void)btnRightClick_Temper{
    [self showSeletMotiom];
    if (_model.target_temperature_f.integerValue==temMax) {
        return ;
    }
    /*
    if (_model.is_locked.boolValue&&_model.locked_temp_max_f.floatValue<_model.target_temperature_f.floatValue+1) {
        self.isLock=YES;
        [MyCommon runBlockInMainQueue:^{
            self.isLock=NO;
        } afterDelay:0.5];
        return ;
    }
    */
    if (_model.target_temperature_f.integerValue+1>temMax) {
        _model.target_temperature_f=[NSString stringWithFormat:@"%f",temMax];
        [self SendTemperateWithTitle1:@"target_temperature_f" withTarget1:_model.target_temperature_f
                           WithTitle2:@"" withTarget2:@""];
        [self checkMotion];
        return ;
    }
    _model.target_temperature_f=[NSString stringWithFormat:@"%f",_model.target_temperature_f.floatValue+1];
    [self SendTemperateWithTitle1:@"target_temperature_f" withTarget1:_model.target_temperature_f
                       WithTitle2:@"" withTarget2:@""];
    [self checkMotion];
}

-(void)btnRightClick_Range{
    if (typeRangeSelectType==TemRangeSelectType_left) {
        [self showSeletMotiom];
        /*
        if (_model.is_locked.boolValue&&_model.target_temperature_low_f.floatValue+4>_model.locked_temp_max_f.floatValue) {
            self.isLock=YES;
            [MyCommon runBlockInMainQueue:^{
                self.isLock=NO;
            } afterDelay:0.5];
            return ;
        }
        */
        if (_model.target_temperature_low_f.floatValue+4>_model.target_temperature_high_f.floatValue) {
            if (_model.target_temperature_low_f.floatValue+4>90) {
                return ;
            }
            _model.target_temperature_high_f=[NSString stringWithFormat:@"%f",_model.target_temperature_high_f.floatValue+1];
        }
        
       _model.target_temperature_low_f=[NSString stringWithFormat:@"%f",_model.target_temperature_low_f.floatValue+1];
        [self SendTemperateWithTitle1:@"target_temperature_low_f" withTarget1:_model.target_temperature_low_f
                           WithTitle2:@"target_temperature_high_f" withTarget2:_model.target_temperature_high_f];
        [self checkMotion];
    }
    if (typeRangeSelectType==TemRangeSelectType_Right) {
        [self showSeletMotiom];
        if (_model.target_temperature_high_f.floatValue==temMax) {
            return ;
        }
        /*
        if (_model.is_locked.boolValue&&_model.target_temperature_high_f.floatValue+1>_model.locked_temp_max_f.floatValue) {
            self.isLock=YES;
            [MyCommon runBlockInMainQueue:^{
                self.isLock=NO;
            } afterDelay:0.5];
            return ;
        }
        */
        if (_model.target_temperature_high_f.floatValue+1>temMax) {
            _model.target_temperature_high_f=[NSString stringWithFormat:@"%f",temMax];
            [self SendTemperateWithTitle1:@"target_temperature_low_f" withTarget1:_model.target_temperature_low_f
                               WithTitle2:@"target_temperature_high_f" withTarget2:_model.target_temperature_high_f];
            [self checkMotion];
            return ;
        }
       _model.target_temperature_high_f=[NSString stringWithFormat:@"%f",_model.target_temperature_high_f.floatValue+1];
        [self SendTemperateWithTitle1:@"target_temperature_low_f" withTarget1:_model.target_temperature_low_f
                           WithTitle2:@"target_temperature_high_f" withTarget2:_model.target_temperature_high_f];
        [self checkMotion];
    }
}

-(void)btnRight_Click{
    if (_model.modelTem==modelOff) {
        return ;
    }
    if (_model.modelTem==modelRange) {
        [self btnRightClick_Range];
    }else{
        [self btnRightClick_Temper];
    }
}

-(void)showSeletMotiom{
    NSString *strStateShow=@"";
    if (_model.modelTem==modelHight) {
        strStateShow=@"HEAT SET TO";
    }
    
    if (_model.modelTem==modelCool) {
        strStateShow=@"COLD SET TO";
    }
    
    if (_model.modelTem==modelRange&&typeRangeSelectType==TemRangeSelectType_left) {
        strStateShow=@"HEAT SET TO";
    }

    if (_model.modelTem==modelRange&&typeRangeSelectType==TemRangeSelectType_Right) {
        strStateShow=@"COLD SET TO";
    }
    
    lblTitle.text=strStateShow;
    [UIView animateWithDuration:0.1 animations:^{
        lblTitle.alpha=1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 animations:^{
            lblTitle.alpha=0;
        } completion:^(BOOL finished) {
        }];
    }];
}

-(void)setIsLock:(BOOL)isLock{
    if (isLock) {
        viewLock1.hidden=NO;
        viewLock2.hidden=NO;
        viewLock3.hidden=NO;
    }else{
        viewLock1.hidden=YES;
        viewLock2.hidden=YES;
        viewLock3.hidden=YES;
    }
}

-(void)setModel:(LSNestDeviceDetailModel *)model{
    _model=model;

    //model自定义
    //根据模式显示目标的温度
    if ([model.hvac_mode isEqualToString:@"heat"]) {//制热模式
        model.modelTem=modelHight;
    }else if ([model.hvac_mode isEqualToString:@"cool"]) {//制冷模式
        model.modelTem=modelCool;
    }else if ([model.hvac_mode isEqualToString:@"heat-cool"]) {//范围模式
        model.modelTem=modelRange;
    }else if ([model.hvac_mode isEqualToString:@"off"]) {//范围模式
        model.modelTem=modelOff;
    }else{
        model.modelTem=modelState;
    }

    if ([model.hvac_state isEqualToString:@"heating"]) {
        model.modelState=modelHighting;
    }else if ([model.hvac_state isEqualToString:@"cooling"]){
        model.modelState=modelCooling;
    }else{
        model.modelState=modelStateing;
    }
    
    [self checkMotion];
    
    if (model.is_locked.boolValue) {
        self.isLock=YES;
    }else{
        self.isLock=NO;
    }
    
    if (model.has_fan.boolValue&&model.fan_timer_active.boolValue&&model.modelTem!=modelOff) {
        imgType.hidden=NO;
    }else{
        imgType.hidden=YES;
    }
    
    if (model.has_leaf.boolValue&&model.modelTem!=modelOff) {
        imgState.hidden=NO;
    }else{
        imgState.hidden=YES;
    }
}

@end
