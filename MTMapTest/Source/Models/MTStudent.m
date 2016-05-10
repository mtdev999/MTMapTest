//
//  MTStudent.m
//  MTMapTest
//
//  Created by Mark Tezza on 15/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "MTStudent.h"

static NSString * const firstName[] = {
    @"Emily", @"James", @"Chloe", @"Jack", @"Megan", @"Alex", @"Charlotte", @"Ben", @"Emma", @"Daniel",
    @"Lauren", @"Tom", @"Ellie", @"Matthew", @"Hannah", @"Adam", @"Sophie", @"Sam", @"Katie", @"Ryan",
    @"Amy", @"Callum", @"Lucy", @"Thomas", @"Olivia", @"David", @"Holly", @"Joe", @"Jessica", @"Lewis",
    @"Georgia", @"Josh", @"Rebecca", @"Jake", @"Sarah", @"Harry", @"Caitlin", @"Liam", @"Beth", @"William",
    @"Bethany", @"Kieran", @"Molly", @"Luke", @"Grace", @"Connor", @"Rachel", @"Joshua", @"Laura", @"Charlie"
};

static NSString * const lastName[] = {
    @"Smith", @"Johnson", @"Williams", @"Jones", @"Brown", @"Davis", @"Miller", @"Wilson", @"Moore", @"Taylor",
    @"Anderson", @"Thomas", @"Jackson", @"White", @"Harris", @"Martin", @"Thompson", @"Garcia", @"Martinez", @"Robinson",
    @"Clark", @"Rodriguez", @"Lewis", @"Lee", @"Walker", @"Hall", @"Allen", @"Young", @"Hernandez", @"King",
    @"Wright", @"Lopez", @"Hill", @"Scott", @"Green", @"Adams", @"Baker", @"Gonzalez", @"Nelson", @"Carter",
    @"Mitchell", @"Perez", @"Roberts", @"Turner", @"Phillips", @"Campbell", @"Parker", @"Evans", @"Edwards", @"Collins"
};

static int countName = 50;

@implementation MTStudent

+ (MTStudent *)randomStudent {
    MTStudent *student = [[MTStudent alloc] init];
    
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", firstName[arc4random_uniform(countName)],
                                                              lastName[arc4random_uniform(countName)]];
    
    student.title = fullName;
    student.subtitle = [NSString stringWithFormat:@"BD: %lu", (NSUInteger)(arc4random_uniform(40) + 1970)];
    student.latitudeValue = [student randomValueLatitude];
    student.longitudeValue = [student randomValueLongitude];
    
    student.coordinate = CLLocationCoordinate2DMake(student.latitudeValue,
                                                    student.longitudeValue);
    student.gender = [student randomGender];

    return student;
}

- (BOOL)randomGender {
    BOOL result = (arc4random_uniform(2000) / 1000) % 2;
    
    return result;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@; G:%@ location = {%f ,%f}",self.title,
                                                                    self.subtitle,
                                                                    self.gender ? @"Male":@"Female",
                                                                    self.latitudeValue,
                                                                    self.longitudeValue];
}

- (double)randomValueLatitude {
    double val1 = 41.01f;//(double)arc4random_uniform(180) + (-90);
    double val2 = (double)arc4random_uniform(99999)/1000000;
    double value = val1 + val2;
    
    return value;
}

- (double)randomValueLongitude {
    double val1 = 28.90f; //(double)arc4random_uniform(270) + (-180);
    double val2 = (double)arc4random_uniform(99999)/1000000;
    double value = val1 + val2;
    
    return value;
}

@end
