//
//  LSNestDeviceDetailModel.h
//  Switch
//
//  Created by admin on 2017/5/2.
//  Copyright © 2017年 Lucis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef  enum{
    modelHight = 1, //
    modelCool= 2,   //制冷状态
    modelRange=3,    //范围状态
    modelOff=4,    //范围状态
    modelState=5    //初始状态
}modelTemperature;//模式

typedef  enum{
    modelHighting = 1, //
    modelCooling= 2,   //制冷状态
    modelStateing=3    //初始状态
}modelTemperatureState;//状态

@interface LSNestDeviceDetailModel : NSObject
//湿度，以%（%）的格式，在设备测量，舍入到最近的5%。
@property(copy,nonatomic)NSString *humidity;
//华氏或摄氏温度；用于温度显示。
@property(copy,nonatomic)NSString *temperature_scale;
//指定语言和区域（或国家）偏好
@property(copy,nonatomic)NSString *locale;
/*热泵冷却系统的紧急热状态。
当紧急情况发生时：
用户可以调整设备上的目标温度，但不能改变模式，直到紧急热关闭
的hvac_mode仍然可以通过API的改变
看什么是急诊热？有关巢温器支持紧急加热的更多信息
 */
@property(copy,nonatomic)NSString *is_using_emergency_heat;
//系统控制风扇独立加热或冷却的能力
@property(copy,nonatomic)NSString *has_fan;
//版本号
@property(copy,nonatomic)NSString *software_version;
//当温控器设置为节能温度时显示
@property(copy,nonatomic)NSString *has_leaf;
//一个唯一的，嵌套的标识符，它表示名称，设备的显示名称。了解更多的名称巢温控器，巢保护和巢凸轮
@property(copy,nonatomic)NSString *where_id;
//巢恒温器唯一标识符。
@property(copy,nonatomic)NSString *device_id;
//显示设备名称。可以是我们提供的列表中的任何房间名称，也可以是自定义名称。
@property(copy,nonatomic)NSString *name;
//系统热能力
@property(copy,nonatomic)NSString *can_heat;
//系统冷能力
@property(copy,nonatomic)NSString *can_cool;
//所需温度，在半摄氏度（0.5°C）。使用时，加热或冷却hvac_mode =。
@property(copy,nonatomic)NSString *target_temperature_c;
//所需温度，华氏度（华氏1度）。使用时，加热或冷却hvac_mode =
@property(copy,nonatomic)NSString *target_temperature_f;
//最高目标温度，显示在半摄氏度（0.5°C）。使用时hvac_mode =热冷（热•酷模式）
@property(copy,nonatomic)NSString *target_temperature_high_c;
//最高目标温度，显示在全华氏度（1°F）。使用时hvac_mode =热冷（热•酷模式）
@property(copy,nonatomic)NSString *target_temperature_high_f;
//最低目标温度，显示在半摄氏度（0.5°C）。使用时hvac_mode =热冷（热•酷模式）
@property(copy,nonatomic)NSString *target_temperature_low_c;
//最低目标温度，显示在全华氏度（1°F）。使用时hvac_mode =热冷（热•酷模式）
@property(copy,nonatomic)NSString *target_temperature_low_f;
//温度，在设备测量，在半摄氏度（0.5°C）
@property(copy,nonatomic)NSString *ambient_temperature_c;
//温度，在设备测量，在整个华氏度（1°F）
@property(copy,nonatomic)NSString *ambient_temperature_f;
//最高温度，显示在半摄氏度（0.5°C）。(停用)
@property(copy,nonatomic)NSString *away_temperature_high_c;
//最高离温，显示在全华氏度（1°F）。(停用)
@property(copy,nonatomic)NSString *away_temperature_high_f;
//最低温度，显示在半摄氏度（0.5°C）(停用)
@property(copy,nonatomic)NSString *away_temperature_low_c;
//最低温度，全华氏度（1°F）(停用)
@property(copy,nonatomic)NSString *away_temperature_low_f;
//恒温器锁定状态。当真正的，温控器锁定功能启用，并限制温度范围的最小/最大值：locked_temp_min_f，locked_temp_max_f，locked_temp_min_c，和locked_temp_max_c。
@property(copy,nonatomic)NSString *is_locked;
//最低温控器锁定温度，显示在半摄氏度（0.5°C）。is_locked为真时使用
@property(copy,nonatomic)NSString *locked_temp_min_c;
//最低温控器锁温度，显示在全华氏度（1°F）。is_locked为真时使用
@property(copy,nonatomic)NSString *locked_temp_min_f;
//最高温控器锁定温度，显示在半摄氏度（0.5°C）。is_locked为真时使用
@property(copy,nonatomic)NSString *locked_temp_max_c;
//最高温控器锁温度，显示在全华氏度（1°F）。is_locked为真时使用
@property(copy,nonatomic)NSString *locked_temp_max_f;
//结构独特的标识符
@property(copy,nonatomic)NSString *structure_id;
//表明如果风扇定时器是啮合；用fan_timer_timeout打开一扇（用户指定）设定的时间。有关风扇设置风扇持续时间的详细信息，请参见高级风扇控制
@property(copy,nonatomic)NSString *fan_timer_active;
//时间戳显示当风扇定时器达到0（停止时间），在ISO 8601格式
@property(copy,nonatomic)NSString *fan_timer_timeout;
/*
 表示HVAC系统的加热/冷却模式，如热和冷却系统的加热和冷却能力，或节约能源的生态温度。
 hvac_mode可如果恒温器是锁定了
 target_temperature_f和target_temperature_c不能如果hvac_mode =关闭或生态变化
 */
@property(copy,nonatomic)NSString *hvac_mode;
//设备连接状态与嵌套服务
@property(copy,nonatomic)NSString *is_online;
//设备的长显示名称。包括自定义（标签），由用户创建，或通过在哪里
@property(copy,nonatomic)NSString *name_long;
/*
 表示HVAC系统是否正在主动加热、冷却或关闭。使用此值指示HVAC活动状态。
 关闭时，HVAC系统不主动加热或冷却。hvac_state独立风机的运行。
 */
@property(copy,nonatomic)NSString *hvac_state;
//上次与嵌套服务成功交互的时间戳，在ISO 8601格式
@property(copy,nonatomic)NSString *last_connection;
//最大生态温度，全华氏度（1华氏度）。使用时hvac_mode =生态
@property(copy,nonatomic)NSString *eco_temperature_high_f;
//最高生态温度，显示在半摄氏度（0.5°C）。使用时hvac_mode =生态
@property(copy,nonatomic)NSString *eco_temperature_high_c;
//最低生态温度，全华氏度（1华氏度）。使用时hvac_mode =生态
@property(copy,nonatomic)NSString *eco_temperature_low_f;
//最低生态温度，半摄氏度（0.5°C）。使用时hvac_mode =生态
@property(copy,nonatomic)NSString *eco_temperature_low_c;
//恒温器自定义标签。出现在括号中，之后的名称
@property(copy,nonatomic)NSString *label;
//防晒功能的状态。用sunlight_correction_active。如果为true，防晒技术的启用，和温控器自动调节阳光直射、读取和设置正确的温度。
@property(copy,nonatomic)NSString *sunlight_correction_enabled;
//防晒霜的主动地位。用sunlight_correction_enabled。当TRUE，表明恒温器位于阳光直射。
@property(copy,nonatomic)NSString *sunlight_correction_active;
//the name of the显示装置。Associated with the恒温器，_ ----- can be any room name from a list我们提供，或自定义名称。了解更多关于where names for是温控器，是保护和巢切除
@property(copy,nonatomic)NSString *where_name;
//指定风扇设置运行的时间长度（分钟）。
@property(copy,nonatomic)NSString *fan_timer_duration;
//的时间，在几分钟内，它将采取的结构达到目标温度。
@property(copy,nonatomic)NSString *time_to_target;
//当在训练模式下，鸟巢恒温器了解HVAC系统，并发现多少时间达到目标温度。当恒温器有足够的信息，以合理的估计时间达到目标温度，这个值将改变从训练到准备
@property(copy,nonatomic)NSString *time_to_target_training;
//显示最后的暖通空调_ -选择模式。当开关从暖通空调_ used模式=生态我们设备以及outdated固件
@property(copy,nonatomic)NSString *previous_hvac_mode;

@property(assign)NSInteger iTimeOut;


//自定义部分
//设置当前模式
@property(assign)modelTemperature modelTem;

//设置当前状态
@property(assign)modelTemperature modelState;

//需要设备设置参数的时间戳
@property(strong,nonatomic)NSString *strTimeClickRememory;

//当为制冷或制热模式下的时候strTitle1，strTarget1为有效值，当为范围模式下四个参数为有效值
//是否需要发送数据
@property(assign)BOOL isNeedData;
//是否正在发送数据
@property(assign)BOOL isSendingData;
//目标1参数
@property(strong,nonatomic)NSString *strTitle1;
//目标1值
@property(strong,nonatomic)NSString *strTarget1;
//目标2参数
@property(strong,nonatomic)NSString *strTitle2;
//目标2值
@property(strong,nonatomic)NSString *strTarget2;

@end
