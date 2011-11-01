//
//  PVMapViewController.h
//  LogStuff
//
//  Created by Dave Brennan on 19/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#define METERS_PER_MILE 1609.344
#import <UIKit/UIKit.h>
#import <MapKit/Mapkit.h>
#import "PVDataManager.h"
#import "PVAppDelegate.h"
#import "PVAddIncidentViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface PVMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) IBOutlet PVDataManager *dataManager;
@property (strong, nonatomic) IBOutlet PVAppDelegate *appController;

@end
