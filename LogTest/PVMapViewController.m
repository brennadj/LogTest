//
//  PVMapViewController.m
//  LogStuff
//
//  Created by Dave Brennan on 19/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#import "PVMapViewController.h"
#import "PVIncident.h"
#import "PVAppDelegate.h"

@implementation PVMapViewController
@synthesize myMapView;
@synthesize dataManager;
@synthesize appController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    PVIncident *anIncident;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Tell view to show user location
    [myMapView setShowsUserLocation:YES]; 
    //Now get a list of incidents to display as annotations on the map
    int i;
    for (i = 0;i< [[dataManager incidentList] count]; i++) {
        anIncident = [[dataManager incidentList] objectAtIndex:i];
        if (anIncident != Nil) {
            [myMapView addAnnotation:anIncident];
        }
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (segue.identifier == @"addIncidentSegue"){
        PVAddIncidentViewController *myAddIncidentViewController = segue.destinationViewController;
        // Get the current coordinates
        //CLLocationCoordinate2D *currentLocation = [CLLocationManager location];
        // Pass the datamanager, coordinates to pre-populate the fields
        [myAddIncidentViewController setDataManager:dataManager];
        //[myAddIncidentViewController setCoordinate:currentLocation];
    }
}

- (void)viewDidUnload
{
    [self setMyMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 1
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 52.061516;
    zoomLocation.longitude = 1.160806;
    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [myMapView regionThatFits:viewRegion];                
    // 4
    [myMapView setRegion:adjustedRegion animated:YES];   
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
        MKPinAnnotationView *annotationView = (MKPinAnnotationView *) [myMapView dequeueReusableAnnotationViewWithIdentifier:@"RedPin"];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"RedPin"];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.draggable = YES;
        annotationView.canShowCallout = YES;
        annotationView.pinColor = MKPinAnnotationColorRed;
        return annotationView;
    
    return nil;    
}
@end
