//
//  ViewController.m
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/1/9.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

#import "ViewController.h"
#import "PickerView.h"
#import "DetectionViewController.h"
#import "QNBleApi.h"

@interface ViewController ()<PickerViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userIdTF;
@property (weak, nonatomic) IBOutlet UILabel *heightLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *maleBtn;

@property (nonatomic, strong) NSDate *birthdayDate;

@property (weak, nonatomic) IBOutlet UIButton *everyBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;

@property (weak, nonatomic) IBOutlet UIButton *jinBtn;
@property (weak, nonatomic) IBOutlet UIButton *stBtn;
@property (weak, nonatomic) IBOutlet UIButton *kgBtn;
@property (weak, nonatomic) IBOutlet UIButton *lbBtn;

@property (nonatomic, strong) PickerView *pickerView;
@property (nonatomic, strong) QNBleApi *bleApi;
@property (nonatomic, strong) QNConfig *config;
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation ViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.bleApi = [QNBleApi sharedBleApi];
    self.config = [self.bleApi getConfig];
    
    self.pickerView.defaultHeight = [[self.heightLabel.text stringByReplacingOccurrencesOfString:@"cm" withString:@""] intValue];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = 2000;
    dateComponents.month = 1;
    dateComponents.day = 1;
    self.birthdayDate = [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    self.birthdayLabel.text = [self.pickerView.dateFormatter stringFromDate:self.birthdayDate];
    self.pickerView.defaultBirthday = self.birthdayDate;
    switch (self.config.unit) {
        case QNUnitLB:
            [self setSelectUnitWith:self.lbBtn];
            break;
        case QNUnitST:
            [self setSelectUnitWith:self.stBtn];
            break;
        case QNUnitJIN:
            [self setSelectUnitWith:self.jinBtn];
            break;
        default:
            [self setSelectUnitWith:self.kgBtn];
            break;
    }

    [self selectMaleBtn:self.maleBtn];
    
    if (self.config.allowDuplicates) {
        [self selectEveryBtn:self.everyBtn];
    }else {
        [self selectFirstBtn:self.firstBtn];
    }
}

#pragma mark - Confirm user ID
#pragma mark Click the keyboard Return button
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Choose height
- (IBAction)selectHeight:(UITapGestureRecognizer *)sender {
    self.pickerView.type = PickerViewTypeHeight;
    self.pickerView.hidden = NO;
}

- (void)confirmHeight:(NSInteger)height {
    self.heightLabel.text = [NSString stringWithFormat:@"%ldcm",height];
}

#pragma mark - Choose birthday
- (IBAction)selectBirthday:(UITapGestureRecognizer *)sender {
    self.pickerView.type = PickerViewTypeBirthday;
    self.pickerView.defaultBirthday = self.birthdayDate;
    self.pickerView.hidden = NO;
}

- (void)confirmBirthday:(NSDate *)birthday {
    self.birthdayDate = birthday;
    self.birthdayLabel.text = [self.pickerView.dateFormatter stringFromDate:birthday];
}

#pragma mark - Selected gender
#pragma mark Selected gender - female
- (IBAction)selectFemaleBtn:(UIButton *)sender {
    if (sender.isSelected) return;
    sender.selected = YES;
    self.maleBtn.selected = NO;
}

#pragma mark Selected gender - male
- (IBAction)selectMaleBtn:(UIButton *)sender {
    if (sender.isSelected) return;
    sender.selected = YES;
    self.femaleBtn.selected = NO;
}

#pragma mark - Scan mode
#pragma mark Check scan mode - every time
- (IBAction)selectEveryBtn:(UIButton *)sender {
    if (sender.isSelected) return;
    sender.selected = YES;
    self.firstBtn.selected = NO;
    self.config.allowDuplicates = YES;
}

#pragma mark Check scan mode - first time
- (IBAction)selectFirstBtn:(UIButton *)sender {
    if (sender.isSelected) return;
    sender.selected = YES;
    self.everyBtn.selected = NO;
    self.config.allowDuplicates = NO;
}

#pragma mark - Weighing unit
#pragma mark Select the weighing unit - kg
- (IBAction)selectJinBtn:(UIButton *)sender {
    [self setSelectUnitWith:sender];
}

#pragma mark Select weighing unit - st
- (IBAction)selectStBtn:(UIButton *)sender {
    [self setSelectUnitWith:sender];
}

#pragma mark Selected weighing unit - kg
- (IBAction)selectKgBtn:(UIButton *)sender {
    [self setSelectUnitWith:sender];
}

#pragma mark Selected weighing unit - lb
- (IBAction)selectLbBtn:(UIButton *)sender {
    [self setSelectUnitWith:sender];
}

- (void)setSelectUnitWith:(UIButton *)sender {
    if (sender.isSelected) return;
    _selectBtn.selected = NO;
    sender.selected = YES;
    _selectBtn = sender;
    //The unit for saving the set scale is 0, the default value; 1 is lb 2 for kg 3 for st
    int index = (int)sender.tag - 100;
    switch (index) {
            case 1:
            self.config.unit = QNUnitLB;
            break;
            
            case 2:
            self.config.unit = QNUnitJIN;
            break;
            
            case 3:
            self.config.unit = QNUnitST;
            break;
            
        default:
            self.config.unit = QNUnitKG;
            break;
    }
}


#pragma mark - Click to confirm jump scan
- (IBAction)clickConfirm:(UIButton *)sender {
    int height = [[self.heightLabel.text stringByReplacingOccurrencesOfString:@"cm" withString:@""] intValue];
    QNUser *user = [_bleApi buildUser:self.userIdTF.text height:height gender:self.femaleBtn.selected ? @"female" : @"male" birthday:self.birthdayDate callback:^(NSError *error) {
        
    }];
    DetectionViewController *detectionVC = [[DetectionViewController alloc] init];
    detectionVC.user = user;
    detectionVC.config = self.config;
    [self.navigationController pushViewController:detectionVC animated:YES];
}

- (PickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [PickerView secPickerView];
        _pickerView.frame = self.view.bounds;
        _pickerView.hidden = YES;
        _pickerView.pickerViewDelegate = self;
        [self.view addSubview:_pickerView];
    }
    return _pickerView;
}

@end
