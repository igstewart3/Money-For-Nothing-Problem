//
//  Money_For_Nothing_ProblemUITests.m
//  Money For Nothing ProblemUITests
//
//  Created by Ian Stewart on 10/01/2018.
//  Copyright © 2018 igstewart3. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface Money_For_Nothing_ProblemUITests : XCTestCase

@end

@implementation Money_For_Nothing_ProblemUITests

- (void)setUp
{
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{
    XCUIElement *moneyForNothingWindow = [[XCUIApplication alloc] init].windows[@"Money For Nothing"];
    XCUIElement *disclosureTriangle = [moneyForNothingWindow childrenMatchingType:XCUIElementTypeDisclosureTriangle].element;
    
    XCUIElement *helpDesc = moneyForNothingWindow.staticTexts[@"Input Description"];
    
    XCTAssertEqual(helpDesc.exists, false);
    [disclosureTriangle click];
    XCTAssertEqual(helpDesc.exists, true);
    [disclosureTriangle click];
    XCTAssertEqual(helpDesc.exists, false);
    [disclosureTriangle click];
    XCTAssertEqual(helpDesc.exists, true);
    
    XCUIElement *textView = [moneyForNothingWindow.scrollViews childrenMatchingType:XCUIElementTypeTextView].element;
    [textView typeText:@"2 2\r"];
    [textView typeText:@"1 3\r"];
    [textView typeText:@"2 1\r"];
    [textView typeText:@"3 5\r"];
    [textView typeText:@"7 2"];
    
    XCUIElement *processButton = moneyForNothingWindow.buttons[@"Process"];
    [processButton click];
    
    XCUIElement *outputField = moneyForNothingWindow.staticTexts[@"Output Label"];
    XCTAssert([outputField.value isEqualToString:@"Maximum Profit: 5   -   from Producer 2 and Consumer 2"]);
    
    [textView click];
    [textView typeText:@" "];
    [textView click];
    [textView typeText:@" "];
    [processButton click];
    
    XCTAssert([outputField.value isEqualToString:@"Maximum Profit: 5   -   from Producer 2 and Consumer 2"]);
    
    [textView click];
    [textView typeText:@"l"];
    [processButton click];
    
    XCTAssert([outputField.value isEqualToString:@"Error: Wrong number of elements in line 4"]);
    
    [textView click];
    [textView typeKey:XCUIKeyboardKeyDelete modifierFlags:XCUIKeyModifierNone];
    [textView typeText:@""];
    [textView typeKey:XCUIKeyboardKeyDelete modifierFlags:XCUIKeyModifierNone];
    [textView click];
    [textView typeText:@"5"];
    [processButton click];
    
    XCTAssert([outputField.value isEqualToString:@"Error: Wrong number of elements in line 4"]);
    
    [textView typeKey:XCUIKeyboardKeyDelete modifierFlags:XCUIKeyModifierNone];
    [textView typeKey:XCUIKeyboardKeyDelete modifierFlags:XCUIKeyModifierNone];
    [textView typeKey:XCUIKeyboardKeyDelete modifierFlags:XCUIKeyModifierNone];
    [textView typeText:@"m"];
    [processButton click];
    
    XCTAssert([outputField.value isEqualToString:@"Error: Non-integer value in line 4"]);
}

@end
