//
//  PVAddIncidentViewController.m
//  LogTest
//
//  Created by Dave Brennan on 31/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#import "PVAddIncidentViewController.h"

@implementation PVAddIncidentViewController

@synthesize dataManager;
@synthesize currentLocation;
@synthesize datePicker;
@synthesize incidentTextField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [datePicker setDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}

- (void)viewDidUnload
{
    [self setDatePicker:nil];
    [self setIncidentTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
