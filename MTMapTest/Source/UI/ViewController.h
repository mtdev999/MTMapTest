//
//  ViewController.h
//  MTMapTest
//
//  Created by Mark Tezza on 15/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKMapView;

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet  MKMapView   *mapView;
@property (strong, nonatomic)           UIButton    *infoButton;


@end

