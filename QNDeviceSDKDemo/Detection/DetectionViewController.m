//
//  DetectionViewController.m
//  QNDeviceSDKDemo
//
//  Created by Yolanda on 2018/3/16.
//  Copyright © 2018年 Yolanda. All rights reserved.
//

typedef enum{
    DeviceStyleNormal = 0,  //Default state
    DeviceStyleScanning = 1,//Scanning
    DeviceStyleLinging = 2,   //Linking
    DeviceStyleLingSucceed = 3, //Successful link
    DeviceStyleMeasuringWeight = 4,//Measuring weight
    DeviceStyleMeasuringResistance = 5,//Measuring impedance
    DeviceStyleMeasuringHeartRate = 6, //Measuring heart rate
    DeviceStyleMeasuringSucceed = 7,     //Measurement completed
    DeviceStyleDisconnect = 8,         //Disconnect/called shutdown
}DeviceStyle;


#import "DetectionViewController.h"
#import "DeviceTableViewCell.h"
#import "ScaleDataCell.h"

@interface DetectionViewController ()<UITableViewDelegate,UITableViewDataSource,QNBleConnectionChangeListener,QNDataListener,QNBleDeviceDiscoveryListener,QNBleStateListener>
@property (weak, nonatomic) IBOutlet UILabel *appIdLabel;
@property (weak, nonatomic) IBOutlet UIButton *scanBtn;
@property (weak, nonatomic) IBOutlet UILabel *styleLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *unstableWeightLabel;  //Always weight
@property (weak, nonatomic) IBOutlet UIView *headerView;

@property (nonatomic, assign) DeviceStyle currentStyle;
@property (nonatomic, strong) NSMutableArray *deviceAry; //Scan to peripheral array
@property (nonatomic, strong) NSMutableArray *scaleDataAry; //Array after receiving the measurement

@property (nonatomic, strong) QNBleApi *bleApi;
@end

@implementation DetectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"measuring";
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedRowHeight = 0;
    self.currentStyle = DeviceStyleNormal;
    self.bleApi = [QNBleApi sharedBleApi];
    self.bleApi.discoveryListener = self;
    self.bleApi.connectionChangeListener = self;
    self.bleApi.dataListener = self;
    self.bleApi.bleStateListener = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"return" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back {
    [self.bleApi disconnectDevice:nil callback:^(NSError *error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Set the status of each phase of the device
- (void)setCurrentStyle:(DeviceStyle)currentStyle {
    _currentStyle = currentStyle;
    switch (_currentStyle) {
        case DeviceStyleScanning: //Scanning
            [self setScanningStyleUI];
            [self startScanDevice];
            break;
        case DeviceStyleLinging: //Linking
            [self setLingingStyleUI];
            break;
        case DeviceStyleLingSucceed: //Successful link
            [self setLingSucceedStyleUI];
            break;
        case DeviceStyleMeasuringWeight: //Measuring weight
            [self setMeasuringWeightStyleUI];
            break;
        case DeviceStyleMeasuringResistance: //Measuring impedance
            [self setMeasuringSucceedStyleUI];
            break;
        case DeviceStyleMeasuringHeartRate: //Measuring heart rate
            [self setMeasuringSucceedStyleUI];
            break;
        case DeviceStyleMeasuringSucceed://Measurement completed
            [self setMeasuringResistanceStyleUI];
            break;
        case DeviceStyleDisconnect://Disconnect/called shutdown
            [self setDisconnectStyleUI];
            [self disconnectDevice];
            break;
        default: //Default state
            [self setNormalStyleUI];
            [self stopScanDevice];
            break;
    }
}
#pragma - UI processing
#pragma mark Scanning status UI
- (void)setScanningStyleUI {
    [self.scanBtn setTitle:@"Scanning" forState:UIControlStateNormal];
    self.headerView.hidden = NO;
    self.styleLabel.text = @"Clink on device link";
    self.unstableWeightLabel.text = @"";
    self.tableView.hidden = NO;
}

#pragma mark Linking status UI
- (void)setLingingStyleUI {
    [self.scanBtn setTitle:@"Disconnect " forState:UIControlStateNormal];
    self.styleLabel.text = @"connecting";
    self.unstableWeightLabel.text = @"";
    self.tableView.hidden = YES;
    self.headerView.hidden = YES;
}

#pragma mark Link success status UI
- (void)setLingSucceedStyleUI {
    [self.scanBtn setTitle:@"Disconnect" forState:UIControlStateNormal];
    self.styleLabel.text = @"connection succeded";
    self.unstableWeightLabel.text = @"0.0";
    self.tableView.hidden = YES;
    self.headerView.hidden = YES;
}

#pragma mark Measuring weight status UI
- (void)setMeasuringWeightStyleUI {
    self.styleLabel.text = @"Weighing";
}

#pragma mark Measuring Impedance status UI
- (void)setMeasuringSucceedStyleUI {
    self.styleLabel.text = @"Measuring impedance";
}

#pragma mark Measurement completion status UI
- (void)setMeasuringResistanceStyleUI {
    self.styleLabel.text = @"Measurement completed";
    self.tableView.hidden = NO;
}

#pragma mark Disconnect/called shutdown status UI
- (void)setDisconnectStyleUI {
    [self.scanBtn setTitle:@"scanning" forState:UIControlStateNormal];
    self.styleLabel.text = @"The line is disconnected";
}

#pragma mark Default state UI
- (void)setNormalStyleUI {
    [self.scanBtn setTitle:@"scanning" forState:UIControlStateNormal];
    self.styleLabel.text = @"";
    self.unstableWeightLabel.text = @"";
    self.tableView.hidden = YES;
    self.headerView.hidden = NO;
}

#pragma mark - Bluetooth status processing
#pragma mark Start scanning nearby device
- (void)startScanDevice {
    [self.deviceAry removeAllObjects];
    [self.tableView reloadData];
    [_bleApi startBleDeviceDiscovery:^(NSError *error) {
        
    }];
}

#pragma mark Link device
- (void)connectDevice:(QNBleDevice *)device {
    [_bleApi stopBleDeviceDiscorvery:^(NSError *error) {
        
    }];
}

#pragma mark Disconnect device
- (void)disconnectDevice {
    [_bleApi disconnectDevice:nil callback:^(NSError *error) {
        
    }];
}

#pragma mark Stop scanning nearby devices
- (void)stopScanDevice {
    [_bleApi stopBleDeviceDiscorvery:^(NSError *error) {
        
    }];
}

#pragma mark - QNBleDeviceDiscorveryListener
- (void)onDeviceDiscover:(QNBleDevice *)device {//This method will call back after discovering the device
    for (QNBleDevice *item in self.deviceAry) {
        if ([item.mac isEqualToString:device.mac]) {
            return;
        }
    }
    [self.deviceAry addObject:device];
    [self.tableView reloadData];
}

#pragma mark - QNBleConnectionChangeListener
- (void)onScaleStateChange:(QNBleDevice *)device scaleState:(QNScaleState)state{//Scale connection or measurement status change
    if (state == QNScaleStateConnected) {//Successful link
          self.currentStyle = DeviceStyleLingSucceed;
    }else if (state == QNScaleStateRealTime){//Measuring weight
        self.currentStyle = DeviceStyleMeasuringWeight;
    }else if (state == QNScaleStateBodyFat){//Measuring impedance
        self.currentStyle = DeviceStyleMeasuringResistance;
    }else if (state == QNScaleStateHeartRate){//Measuring heart rate
        self.currentStyle = DeviceStyleMeasuringHeartRate;
    }else if (state == QNScaleStateMeasureCompleted){//Measurement completed
        self.currentStyle = DeviceStyleMeasuringSucceed;
    }else if (state == QNScaleStateLinkLoss){//Disconnect/called shutdown
        self.currentStyle = DeviceStyleNormal;
    }
}

#pragma mark - Measuring QNDataListener processing
- (void)onGetUnsteadyWeight:(QNBleDevice *)device weight:(double)weight {
    weight = [self.bleApi convertWeightWithTargetUnit:weight unit:[self.bleApi getConfig].unit];
    self.unstableWeightLabel.text = [NSString stringWithFormat:@"%.2f",weight];
}

- (void)onGetScaleData:(QNBleDevice *)device data:(QNScaleData *)scaleData {
    [self.scaleDataAry removeAllObjects];
    for (QNScaleItemData *item in [scaleData getAllItem]) {
        [self.scaleDataAry addObject:item];
    }
    [self.tableView reloadData];
}

- (void)onGetStoredScale:(QNBleDevice *)device data:(NSArray<QNScaleStoreData *> *)storedDataList {
    
    
}

#pragma mark - QNBleStateListener
- (void)onBleSystemState:(QNBLEState)state {
    
}

#pragma mark - UITabelViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentStyle == DeviceStyleScanning) {
        return self.deviceAry.count;
    }else {
        return self.scaleDataAry.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentStyle == DeviceStyleScanning) {
        DeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceTableViewCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"DeviceTableViewCell" owner:self options:nil]lastObject];
        }
        cell.device = self.deviceAry[indexPath.row];
        return cell;
    }else {
        ScaleDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScaleDataCell"];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"ScaleDataCell" owner:self options:nil]lastObject];
        }
        cell.itemData = self.scaleDataAry[indexPath.row];
        cell.unit = [self.bleApi getConfig].unit;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentStyle == DeviceStyleScanning) {
        [_bleApi stopBleDeviceDiscorvery:^(NSError *error) {
            
        }];
        self.currentStyle = DeviceStyleLinging;
        QNBleDevice *device = self.deviceAry[indexPath.row];
        [_bleApi connectDevice:device user:self.user callback:^(NSError *error) {
            
        }];
    }else {
        
    }
}

- (IBAction)clickScanBtn:(UIButton *)sender {
    switch (self.currentStyle) {
        case DeviceStyleScanning: self.currentStyle = DeviceStyleNormal; break;
        case DeviceStyleLinging:
        case DeviceStyleLingSucceed:
        case DeviceStyleMeasuringWeight:
        case DeviceStyleMeasuringResistance:
        case DeviceStyleMeasuringHeartRate:
        case DeviceStyleMeasuringSucceed:
            self.currentStyle = DeviceStyleDisconnect;
            break;
        case DeviceStyleDisconnect: self.currentStyle = DeviceStyleScanning; break;
        default:
            self.currentStyle = DeviceStyleScanning;
            break;
    }
}

- (NSMutableArray *)deviceAry {
    if (!_deviceAry) {
        _deviceAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _deviceAry;
}

- (NSMutableArray *)scaleDataAry {
    if (!_scaleDataAry) {
        _scaleDataAry = [NSMutableArray arrayWithCapacity:1];
    }
    return _scaleDataAry;
}
@end
