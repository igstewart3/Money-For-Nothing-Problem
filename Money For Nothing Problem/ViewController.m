//
//  ViewController.m
//  Money For Nothing Problem
//
//  View controller to handle all the input and output for the problem.
//  Should properly evaluate the inputs for errors and display an output representing the maximum
//  possible profit from the options available.
//
//  Created by Ian Stewart on 09/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import "ViewController.h"
#import "Client.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];
}


- (IBAction)processClick:(NSButton *)sender
{
    NSString* inputString = self.inputText.textStorage.string;
    
    // Seperate into lines and remove empties
    NSArray* lines = [inputString componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    NSMutableArray* tmpArray = [lines mutableCopy];
    [tmpArray removeObject:@""];
    lines = [tmpArray copy];
    tmpArray = nil;
    
    // Setup arrays
    NSInteger counts[2];
    NSMutableArray* producers = nil;
    NSMutableArray* consumers = nil;
    
    // Parse lines
    NSUInteger lineNumber = 0;
    for (NSString* line in lines)
    {
        // Remove any leading or trailing whitespaces
        NSString* trimmed = [line stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        // Seperate into components and check component number
        NSArray* parts = [trimmed componentsSeparatedByCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
        if (parts.count != 2)
        {
            self.outputLabel.stringValue = [NSString stringWithFormat:@"Error: Wrong number of elements in line %ld", lineNumber];
            return;
        }
        
        // Check for non-integer values
        for (NSString* part in parts)
        {
            if ([part rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]].location == NSNotFound)
            {
                self.outputLabel.stringValue = [NSString stringWithFormat:@"Error: Non-integer value in line %ld", lineNumber];
                return;
            }
        }
        
        // Convert to integers for processing
        NSUInteger firstPart = (NSUInteger)[parts[0] integerValue];
        NSUInteger secondPart = (NSUInteger)[parts[1] integerValue];
        
        // Check for first line to handle expected producer/consumer numbers
        if (lineNumber == 0)
        {
            counts[0] = firstPart;
            counts[1] = secondPart;
            
            // Check values match up
            if (lines.count != firstPart + secondPart + 1)
            {
                self.outputLabel.stringValue = [NSString stringWithFormat:@"Error: Total number of consumers and producers does not match entered values: Total: %ld, entered:%ld", lines.count, (firstPart + secondPart)];
                return;
            }
            
            // Create arrays
            producers = [NSMutableArray arrayWithCapacity:firstPart];
            consumers = [NSMutableArray arrayWithCapacity:secondPart];
        }
        else
        {
            // Setup client number for producer or consumer and retrieve relevant array
            NSUInteger clientNumber = lineNumber <= counts[0] ? lineNumber : lineNumber - counts[0];
            NSMutableArray* clientArray = lineNumber <= counts[0] ? producers : consumers;
            
            // Create client and assign to relevant array.
            Client* client = [[Client alloc] initWithIdentifier:clientNumber andPrice:firstPart andDate:secondPart];
            [clientArray setObject:client atIndexedSubscript:(clientNumber - 1)];
        }
        
        // Increment line number
        lineNumber++;
    }
    
    [self evaluateProducers:producers andConsumers:consumers];
}

- (IBAction)helpClick:(NSButton *)sender
{
    // Show/hide help label
    self.helpLabel.hidden = !self.helpLabel.hidden;
}

- (void)evaluateProducers:(NSArray*)producers andConsumers:(NSArray*)consumers
{
    NSInteger profit = 0;
    Client* bestProducer = nil;
    Client* bestConsumer = nil;
    
    // Parse producers and consumers
    for (Client* producer in producers)
    {
        for (Client* consumer in consumers)
        {
            // if producer starts too late for this consumer, or the price difference will yield no profit, skip
            if (producer.date >= consumer.date || producer.price >= consumer.price)
                continue;
            
            // Calculate profit and keep if highest value
            NSInteger tmpProfit = (consumer.date - producer.date) * (consumer.price - producer.price);
            if (tmpProfit > profit)
            {
                profit = tmpProfit;
                bestProducer = producer;
                bestConsumer = consumer;
            }
        }
    }
    
    // Display maximum profit and optimal producer and consumer combination
    NSString* outputString = @"";
    if (profit == 0 || bestProducer == nil | bestConsumer == nil)
        outputString = @"No profit can be made";
    else
        outputString = [NSString stringWithFormat:@"Maximum Profit: %ld   -   from Producer %ld and Consumer %ld", profit, bestProducer.identifier, bestConsumer.identifier];
    
    self.outputLabel.stringValue = outputString;
}

@end
