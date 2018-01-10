//
//  ViewController.h
//  Money For Nothing Problem
//
//  Created by Ian Stewart on 09/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

@property (unsafe_unretained) IBOutlet NSTextView *inputText;
@property (weak) IBOutlet NSButton *processButton;
@property (weak) IBOutlet NSTextField *outputLabel;
@property (weak) IBOutlet NSTextField *helpLabel;

//
// Handle clicks on the Process button on the UI.
//
- (IBAction)processClick:(NSButton *)sender;
- (IBAction)helpClick:(NSButton *)sender;

- (void)evaluateProducers:(NSArray*)producers andConsumers:(NSArray*)consumers;

@end

