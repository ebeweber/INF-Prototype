//
//  ViewController.h
//  INFC4
//
//  Created by Matthew Ebeweber on 11/28/14.
//  Copyright (c) 2014 Matthew Ebeweber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate>

@property float stepSize;
@property (strong, nonatomic) UIColor *yellow;
@property (strong, nonatomic) UIColor *red;
@property (strong, nonatomic) UIView *gameBoard;

@end

