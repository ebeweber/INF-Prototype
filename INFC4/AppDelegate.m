//
//  AppDelegate.m
//  INFC4
//
//  Created by Matthew Ebeweber on 11/28/14.
//  Copyright (c) 2014 Matthew Ebeweber. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  Initialize our main view
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ViewController *viewController = [[ViewController alloc] init];
    
    //  Add navigation controller to the application for the bar
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:52/255.0
                                                                  green:152/255.0
                                                                   blue:219/255.0
                                                                  alpha:1.0]];
    self.window.rootViewController = navigationController;
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
