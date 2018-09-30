//
//  QNScaleItemData.h
//  QNDeviceSDK
//
//  Created by Yolanda on 2018/1/9.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 
 Numerical type of indicator

 - QNValueTypeDouble: Floating point
 - QNValueTypeInt: Shaping
 */
typedef NS_ENUM(NSUInteger, QNValueType) {
    QNValueTypeDouble = 0,
    QNValueTypeInt = 1,
};


/** 指标类型 */
typedef NS_ENUM(NSInteger, QNScaleType) {
    QNScaleTypeWeight = 1, //body weight
    QNScaleTypeBMI = 2, //BMI
    QNScaleTypeBodyFatRage = 3, //Body fat rate
    QNScaleTypeSubcutaneousFat = 4, //Subcutaneous fat rate
    QNScaleTypeVisceralFat = 5, //Visceral fat grade
    QNScaleTypeBodyWaterRate = 6, //Body moisture rate
    QNScaleTypeMuscleRate = 7, //Skeletal muscle rate
    QNScaleTypeBoneMass = 8, //Bone mass
    QNScaleTypeBMR = 9, //Basal metabolic rate
    QNScaleTypeBodyType = 10, //Body type
    QNScaleTypeProtein = 11, //protein
    QNScaleTypeLeanBodyWeight = 12, //Fat loss
    QNScaleTypeMuscleMass = 13, //Muscle mass
    QNScaleTypeMetabolicAge = 14, //Body age
    QNScaleTypeHealthScore = 15, //fraction
    QNScaleTypeHeartRate = 16, //Heart rate
    QNScaleTypeHeartIndex = 17, //Cardiac index
};

@interface QNScaleItemData : NSObject

/** Indicator type */
@property (nonatomic, readonly, assign) QNScaleType type;

/** Indicator value */
@property (nonatomic, readonly, assign) double value;

/** Indicator value type */
@property (nonatomic, readonly, assign) QNValueType valueType;

/** Indicator name */
@property (nonatomic, readonly, strong) NSString *name ;

@end
