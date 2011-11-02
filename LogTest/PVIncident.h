//
//  PVIncident.h
//  LogStuff
//
//  Created by Dave Brennan on 25/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PVIncident : NSObject <MKAnnotation> {
    NSDate   *theDate;
    NSString *whatHappened;
    CLLocationCoordinate2D coordinate;
}

// Center latitude and longitude of the annotion view.
// The implementation of this property must be KVO compliant.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


// Title and subtitle for use by selection UI.
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *subtitle;

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(NA, 4_0);

@property (copy) NSDate *theDate;
@property (copy) NSString *whatHappened;
@property (nonatomic, readonly) CLLocationCoordinate2D where;

- (id)initWithWhen:(NSDate*)aDate what:(NSString*)anOccurrence coordinate:(CLLocationCoordinate2D)aCoordinate;

@end
