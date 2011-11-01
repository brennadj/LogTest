//
//  PVDataManager.m
//  LogStuff
//
//  Created by Dave Brennan on 26/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#import "PVDataManager.h"
#import "PVIncident.h"
#import <Foundation/NSObjCRuntime.h>

@implementation PVDataManager
@synthesize incidentList;

- (PVDataManager*)init {
    
    self = [super init];
    // Create a mutable array to hold the Incidents 
    incidentList = [[NSMutableArray alloc] initWithCapacity:10];
    // Temporary kludge - build a couple of dummy incidents to display
    CLLocationCoordinate2D location;
    location.latitude = 52.060016;
    location.longitude = 1.159256;            
    PVIncident *theIncident = [[PVIncident alloc]
                               initWithWhen:[NSDate dateWithTimeIntervalSinceReferenceDate:340880400] 
                               what:@"Jon and Julie move in"
                               coordinate:location];
    [incidentList addObject:theIncident];
    location.latitude = 52.064400;
    location.longitude = 1.160090;            
    PVIncident *theIncident2 = [[PVIncident alloc] 
                                initWithWhen:[NSDate dateWithTimeIntervalSinceNow:-25]
                                what:@"Man takes dog for walk"
                                coordinate:location];
    [incidentList addObject:theIncident2];
    [self parseXMLSourceIntoArrray:incidentList];
    return self;
}

// Parse an XML string

- (NSInteger)parseXMLSourceIntoArrray:(NSMutableArray *)incidentArray {
    PVIncident *theIncident;
    NSDate *theDate;
    NSString *theIncidentText;
    NSScanner *theScanner;
    CLLocationCoordinate2D thePosition;
    NSError *anError;
    NSString *dataString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.proverbltd.co.uk/logeye/ws.php"]
                                                              encoding:NSASCIIStringEncoding
                                                              error:&anError];
    NSString *incidentString, *detailString;
    NSInteger year, month, day, hour, minute, second;
    NSInteger theNumberOfIncidents, i;
    NSRange theFirstRange, theSecondRange, theContentRange, newRange;
    // Get the number of incidents
    theFirstRange = [dataString rangeOfString:@"<numberOfIncidents>"];
    theSecondRange = [dataString rangeOfString:@"</numberOfIncidents>"];
    theContentRange.location = theFirstRange.location + theFirstRange.length;
    theContentRange.length = theSecondRange.location - theContentRange.location;
    theScanner = [NSScanner scannerWithString:[dataString substringWithRange:theContentRange]];
    [theScanner scanInteger:&theNumberOfIncidents];
    for(i=0; i<theNumberOfIncidents; i++) {
        //parse each incident
        theFirstRange = [dataString rangeOfString:@"<incident>"];
        theSecondRange = [dataString rangeOfString:@"</incident>"];
        theContentRange.location = theFirstRange.location + theFirstRange.length;
        theContentRange.length = theSecondRange.location - theContentRange.location;
        //Now put the whole incident into one string
        incidentString = [dataString substringWithRange:theContentRange];
        // Now parse out the details of the incident
        
        // Put the detail into a string
        detailString = [self extractStringWithTag:@"coordinateLatitude" fromSourceString:dataString];
        // Now scan it into the variable
        theScanner = [NSScanner scannerWithString:detailString];
        [theScanner scanDouble:&thePosition.latitude];
        
        // Put the detail into a string
        detailString = [self extractStringWithTag:@"coordinateLongitude" fromSourceString:dataString];
        // Now scan it into the variable
        theScanner = [NSScanner scannerWithString:detailString];
        [theScanner scanDouble:&thePosition.longitude];
        
        // Put the detail into a string
        detailString = [self extractStringWithTag:@"date" fromSourceString:dataString];
        NSLog(@"%@",detailString);
        // Just check the date is well formed
        if ([detailString length] == 19) {
            // Now parse out each piece
            // Year
            theContentRange.location = 0;
            theContentRange.length = 4;
            theScanner = [NSScanner scannerWithString:[detailString substringWithRange:theContentRange]];
            [theScanner scanInteger:&year];
            if ((year < 0) || (year > 10000)) year = 2000;
            
            // Month
            theContentRange.location = 5;
            theContentRange.length = 2;
            theScanner = [NSScanner scannerWithString:[detailString substringWithRange:theContentRange]];
            [theScanner scanInteger:&month];
            if ((month < 1) || (month > 12)) month = 1;
            
            // Day
            theContentRange.location = 8;
            theContentRange.length = 2;
            theScanner = [NSScanner scannerWithString:[detailString substringWithRange:theContentRange]];
            [theScanner scanInteger:&day];
            if ((day < 1) || (day > 31)) day = 1;
            
            // Hour
            theContentRange.location = 11;
            theContentRange.length = 2;
            theScanner = [NSScanner scannerWithString:[detailString substringWithRange:theContentRange]];
            [theScanner scanInteger:&hour];
            if ((hour < 0) || (hour > 23)) hour = 1;
            
            // Minute
            theContentRange.location = 14;
            theContentRange.length = 2;
            theScanner = [NSScanner scannerWithString:[detailString substringWithRange:theContentRange]];
            [theScanner scanInteger:&minute];
            if ((minute < 0) || (minute > 59)) minute = 0;
            
            // Second
            theContentRange.location = 17;
            theContentRange.length = 2;
            theScanner = [NSScanner scannerWithString:[detailString substringWithRange:theContentRange]];
            [theScanner scanInteger:&second];
            if ((second < 0) || (second > 59)) second = 0;
            
            // Now construct the date
            NSDateComponents *comps = [[NSDateComponents alloc] init];
            [comps setDay:day];
            [comps setMonth:month];
            [comps setYear:year];
            [comps setHour:hour];
            [comps setMinute:minute];
            [comps setSecond:second];
            
            NSCalendar *gregorian = [[NSCalendar alloc]
                                     initWithCalendarIdentifier:NSGregorianCalendar];
            theDate = [gregorian dateFromComponents:comps];
            
        }
        // If not just put in today's date
        else {
            theDate = [NSDate date];
        }
        // Put the detail into a string
        theIncidentText = [self extractStringWithTag:@"whatHappened" fromSourceString:dataString];
        
        
        // Build an incident object 
        theIncident = [[PVIncident alloc] initWithWhen:theDate what:theIncidentText coordinate:thePosition];
        // Add to the incident array
        [incidentArray addObject:theIncident];
        
        //Now remove everything up to that incident from the datastring and carry on
        newRange.location = theSecondRange.location + theSecondRange.length;
        newRange.length = [dataString length] - newRange.location;
        dataString = [dataString substringWithRange:newRange];
    }
    
    return theNumberOfIncidents;
}

- (NSString *)extractStringWithTag:(NSString *)tagString fromSourceString:(NSString *)sourceString
{
    NSRange theFirstRange, theSecondRange, theContentRange;
    theFirstRange = [sourceString rangeOfString:[NSString stringWithFormat:@"<%@>",tagString]];
    theSecondRange = [sourceString rangeOfString:[NSString stringWithFormat:@"</%@>",tagString]];
    theContentRange.location = theFirstRange.location + theFirstRange.length;
    theContentRange.length = theSecondRange.location - theContentRange.location;
    //Now put the whole incident into one string
    return [sourceString substringWithRange:theContentRange];
}
@end
