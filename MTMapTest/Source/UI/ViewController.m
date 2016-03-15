//
//  ViewController.m
//  MTMapTest
//
//  Created by Mark Tezza on 15/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import "ViewController.h"

#import <MapKit/MapKit.h>

#import "MTStudent.h"

@interface ViewController () <MKMapViewDelegate>
@property (nonatomic, strong)   NSArray     *studentsArray;
@property (nonatomic, assign)   NSUInteger  indexObject;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self generationRandomStudents];
    self.indexObject = 0;
    
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                              target:self
                                                                              action:@selector(actionAdd:)];
    
    UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                                                target:self
                                                                                action:@selector(actionShowAll:)];
    /*
     // можно устанавливать жесткое растояние между кнопками
     UIBarButtonItem *fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
     target:nil
     action:nil];
     fixed.width = 50;
     */
    /*
     // устанвливает пропорциональное растояние между кнопками(таким способом можно одну из кнопок поставить на середину бара)
     UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
     target:nil
     action:nil];
     
     self.navigationItem.rightBarButtonItems = @[addButton, flexible, zoomButton,flexible];
     */
    
    self.navigationItem.rightBarButtonItems = @[addButton, zoomButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Actions

- (void)actionAdd:(UIBarButtonItem *)sender {
//    MTMapAnnotation *annotation = [[MTMapAnnotation alloc] init];
//    annotation.title = @"test title";
//    annotation.subtitle = @"test subtitle";
//    annotation.coordinate = self.mapView.region.center;
    
    if (self.indexObject < self.studentsArray.count) {
        MTStudent *student = [self.studentsArray objectAtIndex:self.indexObject++];
        
        [self.mapView addAnnotation:student];
    }
    
    
}

#pragma mark -
#pragma mark MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"Annotation";
    MKPinAnnotationView * pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        pin.pinTintColor = [UIColor purpleColor];
        pin.animatesDrop = YES;
        pin.canShowCallout = YES;
        pin.draggable = YES;
        pin.rightCalloutAccessoryView = [self calloutImage];
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}

- (UIView *)calloutImage {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];

    [view addSubview:button];
    
    return view;
}

#pragma mark -
#pragma mark Private

- (void)generationRandomStudents {
    NSMutableArray *array = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 30; i++) {
        MTStudent *student = [MTStudent randomStudent];
        [array addObject:student];
        NSLog(@"%@", student.description);
    }
    
    self.studentsArray = array;
}

@end
