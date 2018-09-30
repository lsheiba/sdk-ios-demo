//
//  QNDataProtocol.h
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/3/31.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

#import "QNBleDevice.h"
#import "QNScaleData.h"
#import "QNScaleStoreData.h"

@protocol QNDataListener <NSObject>

/**
 
 Real-time data monitoring
 
 @param device QNBleDevice
 @param weight Real-time weight
 */
- (void)onGetUnsteadyWeight:(QNBleDevice *)device weight:(double)weight;

/**
 
 Stable data monitoring
 
 @param device QNBleDevice
 @param scaleData Data result
 */
- (void)onGetScaleData:(QNBleDevice *)device data:(QNScaleData *)scaleData;


/**
 存储数据的监听
 
 @param device QNBleDevice
 @param storedDataList 结果数组
 */
- (void)onGetStoredScale:(QNBleDevice *)device data:(NSArray <QNScaleStoreData *> *)storedDataList;

@end
