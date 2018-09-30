//
//  QNConfig.h
//  QNDeviceSDK
//
//  Created by Yolanda on 2018/3/27.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Scale end weight unit display

 - QNUnitKG: All devices support the display of this unit
 - QNUnitLB: If the device does not support the display of this unit, the "QNUnitKG" type will be displayed even if it is set to "QNUnitLB" type.
 - QNUnitJIN: If the device does not support the display of this unit, the "QNUnitKG" type will be displayed even if it is set to "QNUnitJIN" type.
 - QNUnitST: If the device does not support the display of this unit and supports the display of "QNUnitLB", "QNUnitLB" will be displayed. If "QNUnitLB" is not supported, "QNUnitKG" will be displayed."
 */
typedef NS_ENUM(NSUInteger, QNUnit) {
    QNUnitKG = 0,
    QNUnitLB = 1,
    QNUnitJIN = 2,
    QNUnitST = 3,
};

/**
 The QNConfig class, after the user sets, the SDK will automatically save the setting information. When the setting information in the class is used again, the information set by the user last will be used.
 */

@interface QNConfig : NSObject

/**
 Whether to return only the device that is turned on (bright screen), the default is false */
@property (nonatomic, assign) BOOL onlyScreenOn;

/**
 Whether the same device returns multiple times, the default is false */
@property (nonatomic, assign) BOOL allowDuplicates;

/**
 
 Scan duration, in ms, defaults to 0, ie scans all the time, unless APP calls stopBleDeviceDiscovery
 When it is not 0, the minimum value is 3000ms. After the delay time ms, the scan will stop automatically.
 */
@property (nonatomic, assign) int duration;

/**
 The unit displayed on the end, if not set, the SDK defaults to kg. After the setting, the local will be saved. If the device is currently connected, the unit display of the scale end will be updated in real time. */
@property (nonatomic, assign) QNUnit unit;

/**
 This setting is only called "- (void)initSdk:(NSString *)appId firstDataFile:(NSString *)dataFile callback:(QNResultCallback)callback" The pre-method settings are valid. If you set this method later, the SDK will automatically configure this setting the next time you restart the SDK.
 
 For details on the role of this attribute, please refer to Apple Developer Documenttation => CoreBluetooth => CBCentralManager =>  Central Manager Initialization Options
 */
@property (nonatomic, assign) BOOL showPowerAlertKey;

@end
