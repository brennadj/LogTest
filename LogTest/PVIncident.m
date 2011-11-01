//
//  PVIncident.m
//  LogStuff
//
//  Created by Dave Brennan on 25/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#import "PVIncident.h"

@implementation PVIncident


@synthesize theDate;
@synthesize whatHappened;
@synthesize where;
// Center latitude and longitude of the annotion view.
// The implementation of this property must be KVO compliant.
@synthesize coordinate;

@synthesize title;
@synthesize subtitle;

// Called as a result of dragging an annotation view.
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate NS_AVAILABLE(NA, 4_0)
{
    [self setCoordinate:newCoordinate]; 
}


- (id)initWithWhen:(NSDate*)aDate what:(NSString*)anOccurrence coordinate:(CLLocationCoordinate2D)aCoordinate{
    if ((self = [super init])) {
        theDate = [aDate copy];
        whatHappened = [anOccurrence copy];
        where = aCoordinate;
        coordinate = aCoordinate;
    }
    return self;
}

- (NSString *)title {
    return whatHappened;
}

- (NSString *)subtitle {
    // Returns the data and time of the incident as the subtitle of the popup
    NSString *dateAndTimeString =  [NSDateFormatter localizedStringFromDate:(NSDate *)theDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    return dateAndTimeString;
}

- (void)dealloc
{
    theDate = nil;
    whatHappened = nil;    
}

@end