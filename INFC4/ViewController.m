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

int board[7][7];
UIView *boardViews[7][7];
bool gameOver = NO;
int playerTurn = 1;  // 1 is yellow, 2 is red

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Connect Four Pop";
    self.yellow = [UIColor colorWithRed:241/255.0 green:196/255.0 blue:15/255.0 alpha:1.0];
    self.red = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1.0];
    [self drawDummyPlayerInfo];
    [self createGameBoard];
    
    // Create and initialize a tap gesture
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             initWithTarget:self action:@selector(gameBoardTapGestureRecognizer:)];
    // Specify that the gesture must be a single tap
    tapRecognizer.numberOfTapsRequired = 1;
    // Add the tap gesture recognizer to the view
    [self.gameBoard addGestureRecognizer:tapRecognizer];
}

- (void) changeTurns
{
    if (playerTurn == 1) {
        playerTurn = 2;
    } else if (playerTurn == 2) {
        playerTurn = 1;
    }
}

- (IBAction)gameBoardTapGestureRecognizer:(UITapGestureRecognizer *)recognizer {
    float stepSize = self.gameBoard.frame.size.width / 7;
    CGPoint tapPoint = [recognizer locationInView:self.gameBoard];
    
    // Get the appropraite square for that
    int col = tapPoint.x / stepSize;
    int row = tapPoint.y / stepSize;

    [self handleTapWhereRow:row Col:col];
}

- (void) handleTapWhereRow:(int)row Col:(int)col {
    if (gameOver) { return; };
    
    // x corresponds to the column, y corresponds to the row
    NSLog(@"Handling Tap: (%d, %d)", row, col);
    
    // Pop the column if correctly pressed
    if ((row == 6) &&
        ((board[row][col] == 1 && playerTurn == 1) || (board[row][col] == 2 && playerTurn == 2))) {
        // Pop a piece
        [self popBoardColumn:col];
        [self checkDifferentAnglesForFour:row :col];
        [self changeTurns];
    } else {
        // Just a regular drop
        int i;
        for (i = 6; i >= 0; i--) {
            if (board[i][col] != 1 && board[i][col] != 2) {
                break;
            }
        }
        
        if (i != -1) {
            row = i;
            UIView *newCircle = [[UIView alloc]
                                 initWithFrame:CGRectMake(self.stepSize * col + 1,
                                                          self.stepSize * row + 1,
                                                          self.stepSize - 2,
                                                          self.stepSize - 2)];
            newCircle.layer.cornerRadius = newCircle.frame.size.width / 2;
            
            if (playerTurn == 1) {
                newCircle.backgroundColor = self.yellow;
            } else {
                newCircle.backgroundColor = self.red;
            }
            
            board[row][col] = playerTurn;
            boardViews[row][col] = newCircle;
            [self.gameBoard addSubview:newCircle];
            
            [self checkDifferentAnglesForFour:row :col];
            [self changeTurns];

        }
    }
}

- (void)popBoardColumn:(int)column
{
    // Remove the view accordingly
    board[6][column] = 0;
    [boardViews[6][column] removeFromSuperview];
    
    // Now we must shift everything down.
    for (int i = 6; i > 0; i--) {
        board[i][column] = board[i-1][column];
        boardViews[i][column] = boardViews[i-1][column];
        
        [boardViews[i][column] setFrame:CGRectMake(self.stepSize * column + 1,
                                                   self.stepSize * i + 1,
                                                   self.stepSize - 2,
                                                   self.stepSize - 2)];
    }
    
    board[0][column] = 0;
    boardViews[0][column] = nil;
}

//
// Game Board Creation
//
- (void)createGameBoard {
    UIColor *boardColor = [UIColor colorWithRed:0/250.0
                                         green:0/255.0
                                          blue:0/255.0
                                         alpha:1.0];
    CGRect gameBoardRect = CGRectMake(5,
                                      90,
                                      self.view.frame.size.width - 10,
                                      self.view.frame.size.width - 10);
    self.gameBoard = [[UIView alloc] initWithFrame:gameBoardRect];
    
    // Draw the horizontal lines
    float stepSize = gameBoardRect.size.width / 7;
    for (int i = 0; i < 8; i++) {
        // Add the vertical lines
        UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(stepSize * i, 0, 1, gameBoardRect.size.width)];
        vLine.backgroundColor = boardColor;
        [self.gameBoard addSubview:vLine];
        
        // Add the horizontal lines
        UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, stepSize * i, gameBoardRect.size.width, 1)];
        hLine.backgroundColor = boardColor;
        [self.gameBoard addSubview:hLine];
        
    }
    
    // Store the step size
    self.stepSize = self.gameBoard.frame.size.width / 7;
    
    // Add the new gameboard to the game
    [self.view addSubview:self.gameBoard];
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


// Methods for checking for 4 in a row
- (BOOL)checkDifferentAnglesForFour:(int)r :(int)c
{
    NSLog(@"looking for");
    // First check for the current player
    bool four = ([self fourInARowHorizontallyFrom:r :c :playerTurn] ||
                     [self fourInARowVerticallyFrom:r :c :playerTurn] ||
                     [self fourInARowDiagonallyUpFrom:r :c :playerTurn] ||
                     [self fourInARowDiagonallyDownFrom:r :c :playerTurn]);
    if (four) {
        gameOver = YES;
        NSLog(@"Detected 4 in a row");
        return YES;
    };
            
    int otherPlayer;
    if (playerTurn == 1) { otherPlayer = 2; }
    else if (playerTurn == 2) { otherPlayer = 1; };
    
    four = ([self fourInARowHorizontallyFrom:r :c :otherPlayer] ||
            [self fourInARowVerticallyFrom:r :c :otherPlayer] ||
            [self fourInARowDiagonallyUpFrom:r :c :otherPlayer] ||
            [self fourInARowDiagonallyDownFrom:r :c :otherPlayer]);
    
    if (four) {
        NSLog(@"Detected 4 in a row");
        gameOver = YES;
    };
    return four;
}

- (BOOL)fourInARowHorizontallyFrom:(int)r :(int)c :(int)player
{
    int value = board[r][c];
    if (value != player) { return NO; };
    
    if (c + 3 >= 7) {
        return NO;
    }
    for (int i = 1; i <= 3; i++) {
        if (board[r][c + i] != value) {
            return NO;
        }
    }
    NSLog(@"4IAR - Horizontally");
    
    [self drawGameOverLine:r :c :r :c+3];
    return YES;
}

- (BOOL)fourInARowVerticallyFrom:(int)r :(int)c :(int)player
{
    int value = board[r][c];
    if (value != player) { return NO; };
    
    if (r + 3 >= 7) {
        return NO;
    }
    for (int i = 1; i <= 3; i++) {
        if (board[r + i][c] != value) {
            return NO;
        }
    }
    NSLog(@"4IAR - Vertically");
    
    [self drawGameOverLine:r :c :r+3 :c];
    return YES;
}

- (BOOL)fourInARowDiagonallyDownFrom:(int)r :(int)c :(int)player
{
    int value = board[r][c];
    if (value != player) { return NO; };
    
    if (r + 3 >= 7 || c + 3 >= 7) {
        return NO;
    }
    for (int i = 1; i <= 3; i++) {
        if (board[r+i][c+i] != value) {
            return NO;
        }
    }
    NSLog(@"4IAR - Diagonally Down");
    
    [self drawGameOverLine:r :c :r+3 :c+3];
    return YES;
}

- (BOOL)fourInARowDiagonallyUpFrom:(int)r :(int)c :(int)player
{
    int value = board[r][c];
    if (value != player) { return NO; };
    
    if (c - 3 < 0 || r + 3 >= 7) {
        return NO;
    }
    for (int i = 1; i <= 3; i++) {
        if (board[r+i][c-i] != value) {
            return NO;
        }
    }
    NSLog(@"4IAR - Diagonally Up");
    
    [self drawGameOverLine:r :c :r+3 :c-3];
    return YES;
}

- (void)drawGameOverLine:(int)r1 :(int)c1 :(int)r2 :(int)c2
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    int boardWidth = self.gameBoard.frame.size.height / 7;
    
    // Draw the line from the middle of the squares to the other
    [path moveToPoint:CGPointMake((c1 + .5) * boardWidth, (r1 + .5) * boardWidth)];
    [path addLineToPoint:CGPointMake((c2 + .5) * boardWidth, (r2 + .5) * boardWidth)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = [path CGPath];
    shapeLayer.strokeColor = [[UIColor blackColor] CGColor];
    shapeLayer.lineWidth = 1.0;
    [self.gameBoard.layer addSublayer:shapeLayer];
}

@end
