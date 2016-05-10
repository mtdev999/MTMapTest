//
//  MTDetailsViewController.h
//  MTMapTest
//
//  Created by Mark Tezza on 16/03/16.
//  Copyright © 2016 Mark Tezza. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTDetailsViewControllerDelegate <NSObject>

@end

@interface MTDetailsViewController : UIViewController
@property (nonatomic, strong) id<MTDetailsViewControllerDelegate> delegate;

@end
