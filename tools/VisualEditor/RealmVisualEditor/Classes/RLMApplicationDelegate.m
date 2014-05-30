//
//  RLMApplicationDelegate.m
//  RealmVisualEditor
//
//  Created by Jesper Zuschlag on 22/05/14.
//  Copyright (c) 2014 Realm inc. All rights reserved.
//

#import "RLMApplicationDelegate.h"

#import <Realm/Realm.h>

@interface RealmTestClass1 : RLMObject

@property (nonatomic, readonly) NSInteger integerValue;
@property (nonatomic, readonly) BOOL boolValue;
@property (nonatomic, readonly) float floatValue;
@property (nonatomic, readonly) float doubleValue;
@property (nonatomic, readonly) NSString *stringValue;
@property (nonatomic, readonly) NSDate *dateValue;

+ (instancetype)instanceWithInt:(NSInteger)integerValue bool:(BOOL)boolValue float:(float)floatValue double:(double)doubleValue string:(NSString *)stringValue date:(NSDate *)dateValue;

@end

@implementation RealmTestClass1

+ (instancetype)instanceWithInt:(NSInteger)integerValue bool:(BOOL)boolValue float:(float)floatValue double:(double)doubleValue string:(NSString *)stringValue date:(NSDate *)dateValue
{
    RealmTestClass1 *result = [[RealmTestClass1 alloc] init];
    result->_integerValue = integerValue;
    result->_boolValue = boolValue;
    result->_floatValue = floatValue;
    result->_doubleValue = doubleValue;
    result->_stringValue = stringValue;
    result->_dateValue = dateValue;
    return result;
}

@end

@implementation RLMApplicationDelegate

-(void)applicationDidFinishLaunching:(NSNotification *)notification
{
    NSInteger openFileIndex = [self.fileMenu indexOfItem:self.openMenuItem];
    [self.fileMenu performActionForItemAtIndex:openFileIndex];    
}

- (BOOL)applicationShouldOpenUntitledFile:(NSApplication *)sender
{
    return NO;
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag
{
    return NO;
}

- (IBAction)generatedTestDb:(id)sender
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directories = [fileManager URLsForDirectory:NSDocumentDirectory
                                               inDomains:NSUserDomainMask];
    NSURL *url = [directories firstObject];
    url = [url URLByAppendingPathComponent:@"test123.realm"];
    NSString *path = url.path;
    
    RLMRealm *realm = [RLMRealm realmWithPath:path];
    
    [realm beginWriteTransaction];
    
    [realm addObject:[RealmTestClass1 instanceWithInt:10    bool:YES float:123.456 double:123456.789 string:@"ten"      date:[NSDate date]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:20    bool:YES float:23.4561 double:123456.789 string:@"twenty"   date:[NSDate distantPast]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:30    bool:YES float:3.45612 double:123456.789 string:@"thirty"   date:[NSDate distantFuture]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:40    bool:YES float:.456123 double:123456.789 string:@"fourty"   date:[NSDate date]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:50    bool:YES float:654.321 double:123456.789 string:@"fifty"    date:[NSDate date]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:60    bool:YES float:6543.21 double:123456.789 string:@"sixty"    date:[NSDate date]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:70    bool:YES float:65432.1 double:123456.789 string:@"seventy"  date:[NSDate date]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:80    bool:YES float:654321. double:123456.789 string:@"eighty"   date:[NSDate date]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:90    bool:YES float:123.456 double:123456.789 string:@"ninety"   date:[NSDate date]]];
    [realm addObject:[RealmTestClass1 instanceWithInt:100   bool:YES float:123.456 double:123456.789 string:@"hundred"  date:[NSDate date]]];
    
    [realm commitWriteTransaction];
}

@end