//
//  QNScaleItemData.h
//  QNDeviceSDK
//
//  Created by com.qn.device on 2018/1/9.
//  Copyright © 2018年 com.qn.device. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 指标的数值类型

 - QNValueTypeDouble: 浮点型
 - QNValueTypeInt: 整形
 */
typedef NS_ENUM(NSUInteger, QNValueType) {
    QNValueTypeDouble = 0,
    QNValueTypeInt = 1,
};


/** 指标类型 */
typedef NS_ENUM(NSInteger, QNScaleType) {
    QNScaleTypeWeight = 1, //体重
    QNScaleTypeBMI = 2, //BMI
    QNScaleTypeBodyFatRate = 3, //体脂率
    QNScaleTypeSubcutaneousFat = 4, //皮下脂肪率
    QNScaleTypeVisceralFat = 5, //内脏脂肪等级
    QNScaleTypeBodyWaterRate = 6, //身体水分率
    QNScaleTypeMuscleRate = 7, //骨骼肌率
    QNScaleTypeBoneMass = 8, //骨量
    QNScaleTypeBMR = 9, //基础代谢率
    QNScaleTypeBodyType = 10, //体型
    QNScaleTypeProtein = 11, //蛋白质
    QNScaleTypeLeanBodyWeight = 12, //去脂体重
    QNScaleTypeMuscleMass = 13, //肌肉量
    QNScaleTypeMetabolicAge = 14, //体年龄
    QNScaleTypeHealthScore = 15, //分数
    QNScaleTypeHeartRate = 16, //心率
    QNScaleTypeHeartIndex = 17, //心脏指数
    QNScaleTypeFatMassIndex = 21, //脂肪重量
    QNScaleTypeObesityDegreeIndex = 22, //肥胖度
    QNScaleTypeWaterContentIndex = 23, //含水量
    QNScaleTypeProteinMassIndex = 24, //蛋白质量
    QNScaleTypeMineralSaltIndex = 25, //无机盐状况
    QNScaleTypeBestVisualWeightIndex = 26, //理想视觉体重
    QNScaleTypeStandWeightIndex = 27, //标准体重
    QNScaleTypeWeightControlIndex = 28, //体重控制
    QNScaleTypeFatControlIndex = 29, //脂肪控制
    QNScaleTypeMuscleControlIndex = 30, //肌肉控制
    QNScaleTypeMuscleMassRate = 31, //肌肉率
    QNScaleTypeFattyLiverRisk = 32, //脂肪肝风险等级
    QNScaleTypeResistance50KHZ = 33, //50阻抗
    QNScaleTypeResistance500KHZ = 34, //500阻抗
    
    QNScaleTypeRightArmMucaleWeightIndex = 101, //右臂肌肉重量
    QNScaleTypeLeftArmMucaleWeightIndex = 102, //左臂肌肉重量
    QNScaleTypeTrunkMucaleWeightIndex = 103, //躯干肌肉重量
    QNScaleTypeRightLegMucaleWeightIndex = 104, //右腿肌肉重量
    QNScaleTypeLeftLegMucaleWeightIndex = 105, //左腿肌肉重量
    QNScaleTypeRightArmFatIndex = 106, //右臂脂肪
    QNScaleTypeLeftArmFatIndex = 107, //左臂脂肪
    QNScaleTypeTrunkFatIndex = 108, //躯干脂肪
    QNScaleTypeRightLegFatIndex = 109, //右腿脂肪
    QNScaleTypeLeftLegFatIndex = 110, //左腿脂肪

    QNScaleTypeRightArmResistance20Index = 111, //右臂20阻抗
    QNScaleTypeLeftArmResistance20Index = 112, //左臂20阻抗
    QNScaleTypeTrunkResistance20Index = 113, //躯干20阻抗
    QNScaleTypeRightLegResistance20Index = 114, //右腿20阻抗
    QNScaleTypeLeftLegResistance20Index = 115, //左腿20阻抗
    
    QNScaleTypeRightArmResistance100Index = 116, //右臂100阻抗
    QNScaleTypeLeftArmResistance100Index = 117, //左臂100阻抗
    QNScaleTypeTrunkResistance100Index = 118, //躯干100阻抗
    QNScaleTypeRightLegResistance100Index = 119, //右腿100阻抗
    QNScaleTypeLeftLegResistance100Index = 120, //左腿100阻抗
};

@interface QNScaleItemData : NSObject

/** 指标类型 */
@property (nonatomic, assign) QNScaleType type;
/** 指标数值 */
@property (nonatomic, assign) double value;
/** 指标值类型 */
@property (nonatomic, assign) QNValueType valueType;
/** 指标名称 */
@property (nonatomic, strong) NSString *name;

@end
