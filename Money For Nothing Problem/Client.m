//
//  Client.m
//  Money For Nothing Problem
//
//  Client class to represent Producers and Consumers entered by the user.
//
//  Created by Ian Stewart on 09/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import "Client.h"

@implementation Client

-(id)initWithIdentifier:(NSUInteger)identifier andPrice:(NSUInteger)price andDate:(NSUInteger)date;
{
    if(self = [super init])
    {
        self.identifier = identifier;
        self.price = price;
        self.date = date;
    }
    return self;
}

@end
