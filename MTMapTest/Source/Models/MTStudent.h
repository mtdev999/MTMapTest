//
//  MTStudent.h
//  MTMapTest
//
//  Created by Mark Tezza on 15/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MKAnnotation.h>

@interface MTStudent : NSObject <MKAnnotation>

@property (nonatomic, assign)   CLLocationCoordinate2D  coordinate;
@property (nonatomic, copy)     NSString    *title;
@property (nonatomic, copy)     NSString    *subtitle;
@property (nonatomic, assign)     double    latitudeValue;
@property (nonatomic, assign)     double    longitudeValue;

+ (MTStudent *)randomStudent;

@end
