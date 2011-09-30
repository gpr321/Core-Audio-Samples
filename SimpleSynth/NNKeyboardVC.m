//
//  NNKeyboardVC.m
//  SimpleSynth
//
//  Created by Boris Bügling on 17.06.11.
//  Copyright 2011 - All rights reserved.
//

#import "NNKeyboardVC.h"

@implementation NNKeyboardVC

@synthesize keyboard;
@synthesize levelMeter;
@synthesize synthController;

#pragma mark - View lifecycle

- (void)setupButton:(UIButton*)button 
{
    [button addTarget:self action:@selector(keyPressed:) forControlEvents:UIControlEventTouchDown];
    [button setBackgroundImage:[UIImage imageNamed:@"ButtonHighlighted"] forState:UIControlStateHighlighted];
}

- (void)loadView
{
    self.view = [[UIView alloc] init];
    
    CGFloat x = 64.0;
    for (int i = 0; i < 7; i++) {
        UIButton* whiteKey = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        whiteKey.frame = CGRectMake(x, 386.0, 128.0, 362.0);
        whiteKey.tag = i;
        
        [self setupButton:whiteKey];
        [self.view insertSubview:whiteKey atIndex:0];
        
        x += whiteKey.frame.size.width;
        
        
        UIButton* blackKey;
        
        switch (i) {
            case 0:
            case 1:
            case 3:
            case 4:
            case 5:
                blackKey = [UIButton buttonWithType:UIButtonTypeCustom];
                
                blackKey.backgroundColor = [UIColor blackColor];
                blackKey.frame = CGRectMake(x - 44.0, whiteKey.frame.origin.y, 88.0, 240.0);
                blackKey.tag = i + kBlackKeyOffset;
                
                [self setupButton:blackKey];
                [self.view addSubview:blackKey];
                break;
        }
    }
    
    
    self.levelMeter = [[LevelMeterView alloc] init];
    self.levelMeter.frame = CGRectMake(824.0, 0.0, 200.0, 200.0);
    [self.view addSubview:self.levelMeter];
    
    
    UILabel* effectSwitchLabel = [[UILabel alloc] initWithFrame:CGRectMake(50.0, 50.0, 50.0, 20.0)];
    effectSwitchLabel.backgroundColor = [UIColor clearColor];
    effectSwitchLabel.textColor = [UIColor whiteColor];
    effectSwitchLabel.text = @"Effect";
    [self.view addSubview:effectSwitchLabel];
    
    UISwitch* effectSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(110.0, 45.0, 50.0, 20.0)];
    effectSwitch.on = NO;
    [effectSwitch addTarget:self action:@selector(effectSwitchToggled:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:effectSwitch];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - Actions

- (void)effectSwitchToggled:(UISwitch*)effectSwitch 
{
    self.synthController.reverbEffect.active = effectSwitch.on;
}

- (void)keyPressed:(UIButton*)button
{
    [self.keyboard pressKey:button.tag];
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

@end