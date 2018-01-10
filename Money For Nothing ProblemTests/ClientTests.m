//
//  ClientTests.m
//  Money For Nothing ProblemTests
//
//  Created by Ian Stewart on 10/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Client.h"

@interface ClientTests : XCTestCase

@end

@implementation ClientTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testClientInit
{
    NSUInteger identifier = 5;
    NSUInteger price = 6;
    NSUInteger date = 7;
    Client* client = [[Client alloc] initWithIdentifier:identifier andPrice:price andDate:date];
    XCTAssertNotNil(client);
    XCTAssertEqual(client.identifier, identifier);
    XCTAssertEqual(client.price, price);
    XCTAssertEqual(client.date, date);
}

@end
