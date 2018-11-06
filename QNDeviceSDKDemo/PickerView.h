//
//  PickerView.h
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/3/15.
//  Copyright © 2018年 Yolanda. All rights reserved.
//
//Relationship type
typedef enum{
    PickerViewTypeHeight = 0,//height
    PickerViewTypeBirthday= 1,//birthday
}PickerViewType;



#import <UIKit/UIKit.h>
@class PickerView;

@protocol PickerViewDelegate <NSObject>
@optional
/** Determine birthday*/
- (void)confirmBirthday:(NSDate *)birthday;
/** 确定身高*/
- (void)confirmHeight:(NSInteger )height;

@end

@interface PickerView : UIView
/** Display type*/
@property (nonatomic, assign) PickerViewType type;

/** Default display birthday*/
@property (nonatomic, strong) NSDate *defaultBirthday;

/** Default display height*/
@property (nonatomic, assign) NSInteger defaultHeight;

@property (nonatomic, weak) id<PickerViewDelegate> pickerViewDelegate;

/** Time conversion format*/
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

+ (instancetype)secPickerView;

@end
