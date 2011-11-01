//
//  PVAddIncidentViewController.h
//  LogTest
//
//  Created by Dave Brennan on 31/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PVDataManager.h"
#import <CoreLocation/CoreLocation.h>

@interface PVAddIncidentViewController : UIViewController
@property (weak, nonatomic) PVDataManager *dataManager;
@property CLLocationCoordinate2D *currentLocation;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextView *incidentTextField;
@end
