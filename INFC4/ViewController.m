//
//  ViewController.m
//  INFC4
//
//  Created by Matthew Ebeweber on 11/28/14.
//  Copyright (c) 2014 Matthew Ebeweber. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Connect Four Pop";
    self.yellow = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:1.0];
    self.red = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1.0];
    [self drawDummyPlayerInfo];
    [self createGameBoard];
}


- (void)createGameBoard {
    UIColor *boardColor = [UIColor colorWithRed:0/250.0
                                         green:0/255.0
                                          blue:0/255.0
                                         alpha:1.0];
    CGRect gameBoardRect = CGRectMake(5,
                                      90,
                                      self.view.frame.size.width - 10,
                                      self.view.frame.size.width - 10);
    UIView *gameBoard = [[UIView alloc] initWithFrame:gameBoardRect];
    
    // Draw the horizontal lines
    float stepSize = gameBoardRect.size.width / 7;
    for (int i = 0; i < 8; i++) {
        // Add the vertical lines
        UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(stepSize * i, 0, 1, gameBoardRect.size.width)];
        vLine.backgroundColor = boardColor;
        [gameBoard addSubview:vLine];
        
        // Add the horizontal lines
        UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, stepSize * i, gameBoardRect.size.width, 1)];
        hLine.backgroundColor = boardColor;
        [gameBoard addSubview:hLine];
        
    }
    
    // Add the new gameboard to the game
    [self.view addSubview:gameBoard];
}

//
// Player Card Drawing
//
#define kPlayerCardHeight 75
- (void)drawDummyPlayerInfo {
    // Create the player one card
    UIView *playerOneView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                     0,
                                                                     self.view.frame.size.height - kPlayerCardHeight * 2,
                                                                     self.view.frame.size.width,
                                                                     kPlayerCardHeight
                                                                     )];
    // Add the circle to the view
    UIView *playerOneCircle = [[UIView alloc] initWithFrame:CGRectMake(5, 12.5, 50, 50)];
    playerOneCircle.layer.cornerRadius = playerOneCircle.frame.size.height / 2;
    playerOneCircle.backgroundColor = self.yellow;
    [playerOneView addSubview:playerOneCircle];
    
    // Add the player name to the view
    UILabel *playerOneLabel = [[UILabel alloc] init];
    playerOneLabel.text = @"Player One";
    playerOneLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
    [playerOneLabel sizeToFit];
    CGRect oneFrame = playerOneLabel.frame;
    oneFrame.origin.x = 65;
    oneFrame.origin.y = (playerOneView.frame.size.height - playerOneLabel.frame.size.height) / 2;
    playerOneLabel.frame = oneFrame;
    [playerOneView addSubview:playerOneLabel];
    
    // Add the player score to the view
    UILabel *playerOneRank = [[UILabel alloc] init];
    playerOneRank.text = @"1254";
    playerOneRank.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
    [playerOneRank sizeToFit];
    CGRect oneRankFrame = playerOneRank.frame;
    oneRankFrame.origin.x = playerOneView.frame.size.width - oneRankFrame.size.width - 10;
    oneRankFrame.origin.y = (playerOneView.frame.size.height - playerOneLabel.frame.size.height) / 2;
    playerOneRank.frame = oneRankFrame;
    [playerOneView addSubview:playerOneRank];

    // Create the player two card
    UIView *playerTwoView = [[UIView alloc] initWithFrame:CGRectMake(
                                                                     0,
                                                                     self.view.frame.size.height - kPlayerCardHeight,
                                                                     self.view.frame.size.width,
                                                                     kPlayerCardHeight
                                                                     )];
    // Add the player two circle to the view
    UIView *playerTwoCircle = [[UIView alloc] initWithFrame: CGRectMake(5, 12.5, 50, 50)];
    playerTwoCircle.layer.cornerRadius = playerTwoCircle.frame.size.height / 2;
    playerTwoCircle.backgroundColor = self.red;
    [playerTwoView addSubview:playerTwoCircle];
    
    // Add the player name to the view
    UILabel *playerTwoLabel = [[UILabel alloc] init];
    playerTwoLabel.text = @"Player Two";
    playerTwoLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
    [playerTwoLabel sizeToFit];
    CGRect twoFrame = playerTwoLabel.frame;
    twoFrame.origin.x = 65;
    twoFrame.origin.y = (playerTwoView.frame.size.height - playerTwoLabel.frame.size.height) / 2;
    playerTwoLabel.frame = twoFrame;
    [playerTwoView addSubview:playerTwoLabel];
    
    // Add the player score to the view
    UILabel *playerTwoRank = [[UILabel alloc] init];
    playerTwoRank.text = @"1040";
    playerTwoRank.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:24.0];
    [playerOneRank sizeToFit];
    CGRect twoRankFrame = playerTwoRank.frame;
    twoRankFrame.origin.x = playerOneView.frame.size.width - twoRankFrame.size.width - 10;
    twoRankFrame.origin.y = (playerOneView.frame.size.height - playerOneLabel.frame.size.height) / 2;
    playerTwoRank.frame = oneRankFrame;
    [playerTwoView addSubview:playerTwoRank];

    
    // Add them both to the view
    [self.view addSubview:playerOneView];
    [self.view addSubview:playerTwoView];
}


@end
