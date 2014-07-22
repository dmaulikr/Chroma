//
//  Dot.m
//  ColorSpin
//
//  Created by Claire Treyz on 1/19/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "OALSimpleAudio.h"
#import "Dot.h"


@implementation Dot {
    BOOL sameColorMode;
}

-(void) update:(CCTime)delta {
    if (!self.gameplayLayer.pauseGame) {
        self.rotation = -self.gameplayLayer.currentRotation;
        if (self.gameplayLayer.easy) {
            if (self.scale*7 < 3.0) {
                self.scale = self.scale + rate*delta/4.4;
                _deathLevel = (self.scale*7);
            }
        }
        else {
            if (self.scale*7 < 7.0) {
                self.scale = self.scale + rate*delta/2.2;
                _deathLevel = (self.scale*7);
            }
        }
    }
    
}

-(void) didLoadFromCCB {
    self.scale = 0.15;
    [[OALSimpleAudio sharedInstance] preloadEffect:@"pop.wav"];
    rate = 0.15;
    self.userInteractionEnabled = TRUE;
    _killNumber = 0;
    self.rotation = -self.gameplayLayer.currentRotation;
    sameColorMode = [[NSUserDefaults standardUserDefaults]  boolForKey:@"Easy Mode"];
    if (!sameColorMode) {
        [self randomizeValues];
    }
    else {
        [self randomizeValuesSameColor];
        
    }
    
}

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (neutralizeColor == self.gameplayLayer.colorState && !self.gameplayLayer.pauseGame) {
        self.scale = self.scale / 2;
        rate += 0.05;
        if (self.scale < 0.2) {
            rate = 0.15;
            [[OALSimpleAudio sharedInstance] playEffect:@"pop.wav"];
            if (!sameColorMode) {
                [self randomizeValues];
            }
            else {
                [self randomizeValuesSameColor];

            }
            _killNumber++;
        }
    }
}


-(void) randomizeValuesSameColor {
    int radius = arc4random_uniform(110);
    int angle = arc4random_uniform(360);
    //    NSLog(@"angle is %i", angle);
    dotColor = arc4random_uniform(6);
    if (dotColor == RED) {
        neutralizeColor = RED;
        [[self animationManager] runAnimationsForSequenceNamed:@"Red"];
    }
    else if (dotColor == ORANGE) {
        neutralizeColor = ORANGE;
        [[self animationManager] runAnimationsForSequenceNamed:@"Orange"];
    }
    else if (dotColor == YELLOW) {
        neutralizeColor = YELLOW;
        [[self animationManager] runAnimationsForSequenceNamed:@"Yellow"];    }
    else if (dotColor == GREEN) {
        neutralizeColor = GREEN;
        [[self animationManager] runAnimationsForSequenceNamed:@"Green"];
    }
    else if (dotColor == BLUE) {
        neutralizeColor = BLUE;
        [[self animationManager] runAnimationsForSequenceNamed:@"Blue"];
    }
    else if (dotColor == VIOLET) {
        neutralizeColor = VIOLET;
        [[self animationManager] runAnimationsForSequenceNamed:@"Purple"];
    }
    
    x = radius * cos(CC_DEGREES_TO_RADIANS(angle));
    y = radius * sin(CC_DEGREES_TO_RADIANS(angle));
    
    
    
    self.position = ccpAdd(ccp(x,y), ccp(163, 163));
    self.scale = 0.15;
    rate = 0.15;
    [self.gameplayLayer reorderDot:self];
}




-(void) randomizeValues {
    int radius = arc4random_uniform(110);
    int angle = arc4random_uniform(360);
//    NSLog(@"angle is %i", angle);
    dotColor = arc4random_uniform(6);
    if (dotColor == RED) {
        neutralizeColor = GREEN;
        [[self animationManager] runAnimationsForSequenceNamed:@"Red"];
    }
    else if (dotColor == ORANGE) {
        neutralizeColor = BLUE;
        [[self animationManager] runAnimationsForSequenceNamed:@"Orange"];
    }
    else if (dotColor == YELLOW) {
        neutralizeColor = VIOLET;
        [[self animationManager] runAnimationsForSequenceNamed:@"Yellow"];    }
    else if (dotColor == GREEN) {
        neutralizeColor = RED;
        [[self animationManager] runAnimationsForSequenceNamed:@"Green"];
    }
    else if (dotColor == BLUE) {
        neutralizeColor = ORANGE;
        [[self animationManager] runAnimationsForSequenceNamed:@"Blue"];
    }
    else if (dotColor == VIOLET) {
        neutralizeColor = YELLOW;
        [[self animationManager] runAnimationsForSequenceNamed:@"Purple"];
    }
    
    x = radius * cos(CC_DEGREES_TO_RADIANS(angle));
    y = radius * sin(CC_DEGREES_TO_RADIANS(angle));
    

    
    self.position = ccpAdd(ccp(x,y), ccp(163, 163));
    self.scale = 0.15;
    rate = 0.15;
    [self.gameplayLayer reorderDot:self];
}



@end
