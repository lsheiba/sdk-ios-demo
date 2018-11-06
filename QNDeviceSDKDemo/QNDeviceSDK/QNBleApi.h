//
//  QNBleApi.h
//  QNDeviceSDK
//
//  Created by Yolanda on 2018/1/9.
//  Copyright © 2018年 Yolanda. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "QNBleStateProtocol.h"
#import "QNBleDeviceDiscoveryProtocol.h"
#import "QNBleConnectionChangeProtocol.h"
#import "QNDataProtocol.h"
#import "QNUser.h"
#import "QNConfig.h"

/**
 
 This SDK is a static library of the equipment connection tool of the light cow. It needs to obtain the "appId" from the light cattle official. Otherwise, the SDK cannot be used normally.
 
 current version【 0.4.0 】
 
 SDK minimum configuration 8.0 system
 
 Project configuration instructions:
 1. Apple officially has to use the "Privacy - Bluetooth Peripheral Usage Description" button in Info.plist after iOS10.0 (including 10.0), otherwise the system Bluetooth cannot be used.
 2. Introduce SDK path [TARGETS]-> [Build Setting]->[Search Paths]->[LibrarySearch Paths]Add SDK path
 3. Configure the linker [TARGETS]-> [Build Setting]-> [Linking]-> [Other Linker Flags] add "-ObjC", "-all_load", "-force_load [SDK path]"
 
 Scale measurement method description:
 
 1. It is necessary to measure bare feet to measure human bioimpedance
 
 
 
 Description of scale data:

 1. Measure when connecting the scale, the data will be uploaded immediately after the measurement is completed.
 2. When the scale is not connected, the measurement data will be automatically stored to the scale end. For details, please refer to "QNScaleStoreData" to store the data class.
 
 There are two situations in which the scale has a broadcast:
 1. When the scale is on the screen, a broadcast will be issued.
 2. When the scale has stored data, it will broadcast even if the scale is off.
 
 
 manual:
 
 1. Initialize the SDK with "+ (QNBleApi *)sharedBleApi"
 2. Do you need the system's Bluetooth bulletin box? This box will determine whether the Bluetooth is turned on when the Bluetooth management is initialized. If the Bluetooth is off, the system will automatically pop up the box. If you need to call "- (QNConfig *) ) getConfig" method to get the configuration item, and then directly set the corresponding attribute, if you do not need to play the box, skip this step directly
 2. Use "- (void)initSdk:(NSString *)appId firstDataFile:(NSString *)dataFile callback:(QNResultCallback)callback"Register SDK
 3. Follow the appropriate agent and implement the corresponding proxy method
 4. Call the "- (QNConfig *) getConfig" method to get the configuration item and set the corresponding switch, such as the type of the returned device, whether the device returns multiple times, etc. This step can also be set in the second step.
 4. Call the scan method "- (void) startBleDeviceDiscovery: (QNResultCallback) callback", the app processes the scanned device (such as adding an array to implement list scanning to the device, etc.)
 5. Call the connection method and connect the corresponding device "- (void)connectDevice:(QNBleDevice *)device user:(QNUser *)user callback:(QNResultCallback)callback"
 6. Agent method callback measurement of each state, stored data, real-time weight, measurement results and other data
 7. After the measurement is completed, you can call the "- (void)disconnectDevice:(QNBleDevice *)device callback:(QNResultCallback)callback" method to disconnect the device.
 */

@interface QNBleApi : NSObject

/** Whether to turn on the debug switch The default is NO (when the release version is recommended, set to NO) */
@property (nonatomic, assign, class) BOOL debug;

/**
 
 The device is monitored. The listener must be implemented. Otherwise, the searched device information cannot be obtained.
 Details can be found in QNBleDeviceDiscorveryProtocol.h
 
 */
@property (nonatomic, weak) id<QNBleDeviceDiscoveryListener> discoveryListener;

/**
 Device status monitoring
 Details can be found in QNBleConnectionChangeProtocol.h
 
 */
@property (nonatomic, weak) id<QNBleConnectionChangeListener> connectionChangeListener;

/**
 
 Monitoring of measurement data, the monitor must be implemented
 Details can be found in QNDataProtocol.h
 
 */
@property (nonatomic, weak) id<QNDataListener> dataListener;

/**
 System Bluetooth status monitoring
 Details can be viewed in QQNBleStateProtocol.h
 
 */
@property (nonatomic, weak) id<QNBleStateListener> bleStateListener;

/**
 
 Initialize the SDK

 @return QNBleApi
 */
+ (QNBleApi *)sharedBleApi;


/**
 
 Register SDK
 You must first register the SDK and use other operations.
 Appid and initial configuration file, please talk to the light cattle official
 
 @param appId Need to get the correct appid to the official
 @param dataFile Configuration file path
 @param callback Result callback
 */
- (void)initSdk:(NSString *)appId firstDataFile:(NSString *)dataFile callback:(QNResultCallback)callback;


/**
 
 Scanning device

 @param callback Result callback
 */
- (void)startBleDeviceDiscovery:(QNResultCallback)callback;


/**
 Stop scanning

 @param callback Result callback
 */
- (void)stopBleDeviceDiscorvery:(QNResultCallback)callback;


/**
 Connecting device

 @param device Connected device (the device object must be the device object returned by the search)
 @param user User Information (This user information object must be built using the following "buildUser")
 @param callback Result callback
 */
- (void)connectDevice:(QNBleDevice *)device user:(QNUser *)user callback:(QNResultCallback)callback;


/**
 Disconnect the device

 @param device Currently connected device (may not pass)
 @param callback Result callback
 */
- (void)disconnectDevice:(QNBleDevice *)device callback:(QNResultCallback)callback;


/**
 Get the current settings of the SDK

 @return QNConfig
 */
- (QNConfig *)getConfig;


/**
 Converted to the value of the specified unit based on the weight of the supplied kg value

 @param kgWeight Weight of kg unit
 @param unit QNUnit kg、lb，All scales can support this unit; kg, if the scale end does not support, it will display kg (not support ST conversion)
 @return Result callback
 */
- (double)convertWeightWithTargetUnit:(double)kgWeight unit:(QNUnit)unit;

/**
 Building a user model
 
 @param userId User id
 @param height User height
 @param gender User gender male female
 @param birthday User's date of birth age 3~80
 @param callback Result callback
 @return QNUser
 */
- (QNUser *)buildUser:(NSString *)userId height:(int)height gender:(NSString *)gender birthday:(NSDate *)birthday callback:(QNResultCallback)callback;

/**
 建立用户模型
 @param userId 用户id
 @param height 用户身高
 @param gender 用户性别 male female
 @param birthday 用户的出生日期 age 3~80
 @param athleteType 是否是运动员模式
 @param callback 结果的回调
 @return QNUser
 */
- (QNUser *)buildUser:(NSString *)userId height:(int)height gender:(NSString *)gender birthday:(NSDate *)birthday athleteType:(int)athleteType callback:(QNResultCallback)callback;
@end
