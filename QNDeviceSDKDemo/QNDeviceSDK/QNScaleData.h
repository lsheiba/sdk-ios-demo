//
//  QNScaleData.h
//  QNDeviceSDK
//
//  Created by Yolanda on 2018/1/9.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNUser.h"
#import "QNScaleItemData.h"

@interface QNScaleData : NSObject

/** Owner of measurement data */
@property (nonatomic, readonly, strong) QNUser *user;

/** Measurement data measurement time */
@property (nonatomic, readonly, strong) NSDate *measureTime;

/**
 Get the details of the indicator by calling this method

 @param type QNScaleType
 @return QNScaleItemData
 */
- (QNScaleItemData *)getItem:(QNScaleType)type;


/**
 Get the value of the indicator

 @param type QNScaleType
 @return Indicator value
 */
- (double)getItemValue:(QNScaleType)type;


/**
 Get the details of the indicator after this measurement

 @return Collection of indicator details
 */
- (NSArray <QNScaleItemData *> *)getAllItem;


@end
