//
//  PVDataManager.h
//  LogStuff
//
//  Created by Dave Brennan on 26/10/2011.
//  Copyright (c) 2011 Dave Brennan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PVDataManager : NSObject

@property (strong, nonatomic) NSMutableArray *incidentList;

- (PVDataManager*)init;
- (NSString *)extractStringWithTag:(NSString *)tagString fromSourceString:(NSString *)sourceString;
- (NSInteger)parseXMLSourceIntoArrray:(NSMutableArray *)incidentArray;

@end
