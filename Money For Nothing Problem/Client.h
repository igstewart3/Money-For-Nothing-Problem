//
//  Client.h
//  Money For Nothing Problem
//
//  Created by Ian Stewart on 09/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Client : NSObject

// The position of the client in the producer/consumer list
@property NSUInteger identifier;
// Price at which goods will be bought/sold
@property NSUInteger price;
// Date at (or after) which product will be sold (or no longer sold)
@property NSUInteger date;

-(id)initWithIdentifier:(NSUInteger)identifier andPrice:(NSUInteger)price andDate:(NSUInteger)date;

@end
