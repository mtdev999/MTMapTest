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
#import "MTDetailsViewController.h"

@interface ViewController () <MKMapViewDelegate, MTDetailsViewControllerDelegate>
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

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
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
        
        if ([pin.annotation isKindOfClass:[MTStudent class]]) {
            if ([(MTStudent*)annotation gender]) {
                pin.image = [UIImage imageNamed:@"logo_roof-1"];
            }
        }
        
        pin.draggable = YES;
        pin.rightCalloutAccessoryView = [self calloutImage];
    } else {
        pin.annotation = annotation;
    }
    
    return pin;
}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    [mapView deselectAnnotation:view.annotation animated:YES];
//    
//    
//    
//}

- (UIView *)calloutImage {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 30)];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];

    [view addSubview:button];
    
    [button addTarget:self action:@selector(actionInfo:) forControlEvents:UIControlEventTouchUpInside];
    self.infoButton = button;
    
    return view;
}

- (void)actionInfo:(UIButton *)sender {
    
    NSLog(@"info action");
    
    MTDetailsViewController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"MTDetailsViewController"];
    dvc.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:dvc];
    
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self presentViewController:navController animated:YES completion:nil];
    
    UIPopoverPresentationController *popController = [navController popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.sourceView = self.infoButton;
    //popController.sourceRect = CGRectMake(30, 50, 10, 10);;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        
    }

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
