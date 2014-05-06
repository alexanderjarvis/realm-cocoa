//
//  mixed.m
//  TightDB
//
// Demo code for short tutorial using Objective-C interface
//

#import "RLMTestCase.h"

#import <realm/objc/Realm.h>
#import <realm/objc/RLMTable_noinst.h>

REALM_TABLE_3(MixedTable,
              Hired, Bool,
              Other, Mixed,
              Age,   Int)

REALM_TABLE_2(SubMixedTable,
              Hired, Bool,
              Age,   Int)

@interface MACTestMixed : RLMTestCase

@end

@implementation MACTestMixed

- (void)testMixedEqual
{
    NSDate *nowTime = [NSDate date];
    NSDate *nowTime1 = [[NSDate date] dateByAddingTimeInterval:1];

    NSNumber *mixedBool1 = [NSNumber numberWithBool:YES];
    NSNumber *mixedBool2 = [NSNumber numberWithBool:NO];
    NSNumber *mixedBool3 = [NSNumber numberWithBool:NO];
    XCTAssertEqual([mixedBool1 isEqual:mixedBool1], YES, @"Same mixed should be equal (1)");
    XCTAssertEqual([mixedBool2 isEqual:mixedBool2], YES, @"Same mixed should be equal (2)");
    XCTAssertEqual([mixedBool2 isEqual:mixedBool3], YES,  @"Mixed with same bools should be equal");
    XCTAssertEqual([mixedBool1 isEqual:mixedBool2], NO,  @"Mixed with different bools should be different");

    NSNumber *mixedInt1 = [NSNumber numberWithLongLong:10001];
    NSNumber *mixedInt2 = [NSNumber numberWithLongLong:20002];
    NSNumber *mixedInt3 = [NSNumber numberWithLongLong:20002];
    XCTAssertEqual([mixedInt1 isEqual:mixedInt1], YES, @"Same mixed should be equal (3)");
    XCTAssertEqual([mixedInt2 isEqual:mixedInt2], YES, @"Same mixed should be equal (4)");
    XCTAssertEqual([mixedInt2 isEqual:mixedInt3], YES, @"Mixed with same ints should be equal");
    XCTAssertEqual([mixedInt1 isEqual:mixedInt2], NO,  @"Mixed with different ints should be different");

    NSString *mixedString1 = [NSString stringWithUTF8String:"Hello"];
    NSString *mixedString2 = [NSString stringWithUTF8String:"Goodbye"];
    NSString *mixedString3 = [NSString stringWithUTF8String:"Goodbye"];
    XCTAssertEqual([mixedString1 isEqual:mixedString1], YES, @"Same mixed should be equal (5)");
    XCTAssertEqual([mixedString2 isEqual:mixedString2], YES, @"Same mixed should be equal (6)");
    XCTAssertEqual([mixedString2 isEqual:mixedString3], YES, @"Mixed with same strings should be equal");
    XCTAssertEqual([mixedString1 isEqual:mixedString2], NO,  @"Mixed with different strings should be different");

    const char* str1 = "Hello";
    const char* str2 = "Goodbye";
    NSData *mixedBinary1 = [NSData dataWithBytes:str1 length:strlen(str1)];
    NSData *mixedBinary2 = [NSData dataWithBytes:str2 length:strlen(str2)];
    NSData *mixedBinary3 = [NSData dataWithBytes:str2 length:strlen(str2)];
    XCTAssertEqual([mixedBinary1 isEqual:mixedBinary1], YES, @"Same mixed should be equal (7)");
    XCTAssertEqual([mixedBinary2 isEqual:mixedBinary2], YES, @"Same mixed should be equal (8)");
    XCTAssertEqual([mixedBinary2 isEqual:mixedBinary3], YES, @"Mixed with same binary data should be equal");
    XCTAssertEqual([mixedBinary1 isEqual:mixedBinary2], NO,  @"Mixed with different binary data should be different");

    NSDate *mixedDate1 = nowTime;
    NSDate *mixedDate2 = nowTime1;
    NSDate *mixedDate3 = nowTime1;
    XCTAssertEqual([mixedDate1 isEqual:mixedDate1], YES, @"Same mixed should be equal (9)");
    XCTAssertEqual([mixedDate2 isEqual:mixedDate2], YES, @"Same mixed should be equal (10)");
    XCTAssertEqual([mixedDate2 isEqual:mixedDate3], YES, @"Mixed with same timestamps should be equal");
    XCTAssertEqual([mixedDate1 isEqual:mixedDate2], NO,  @"Mixed with different timestamps should be different");

    [self.realmWithTestPath writeUsingBlock:^(RLMRealm *realm) {
        MixedTable    *table1 = [realm createTableWithName:@"table1" asTableClass:MixedTable.class];
        SubMixedTable *table2 = [realm createTableWithName:@"table2" asTableClass:SubMixedTable.class];
        SubMixedTable *table3 = [realm createTableWithName:@"table3" asTableClass:SubMixedTable.class];
        [table1 addHired:YES Other:mixedBool1 Age:54];
        [table2 addHired:YES                  Age:54];
        [table3 addHired:YES                  Age:54];
        XCTAssertEqual([table1 isEqual:table1], YES, @"Same mixed should be equal (11)");
        XCTAssertEqual([table2 isEqual:table2], YES, @"Same mixed should be equal (12)");
        XCTAssertEqual([table2 isEqual:table3], YES, @"Mixed with same tables should be equal");
        XCTAssertEqual([table1 isEqual:table2], NO,  @"Mixed with different tables should be different");
        
        
        XCTAssertEqual([mixedBool1 isEqual:mixedInt1],    NO, @"Mixed with different types should be different (1)");
        XCTAssertEqual([mixedBool1 isEqual:mixedString1], NO, @"Mixed with different types should be different (2)");
        XCTAssertEqual([mixedBool1 isEqual:mixedBinary1], NO, @"Mixed with different types should be different (3)");
        XCTAssertEqual([mixedBool1 isEqual:mixedDate1],   NO, @"Mixed with different types should be different (4)");
        XCTAssertEqual([mixedBool1 isEqual:table1],       NO, @"Mixed with different types should be different (5)");
        
        XCTAssertEqual([mixedInt1 isEqual:mixedBool1],   NO, @"Mixed with different types should be different (6)");
        XCTAssertEqual([mixedInt1 isEqual:mixedString1], NO, @"Mixed with different types should be different (7)");
        XCTAssertEqual([mixedInt1 isEqual:mixedBinary1], NO, @"Mixed with different types should be different (8)");
        XCTAssertEqual([mixedInt1 isEqual:mixedDate1],   NO, @"Mixed with different types should be different (9)");
        XCTAssertEqual([mixedInt1 isEqual:table1],       NO, @"Mixed with different types should be different (10)");
        
        XCTAssertEqual([mixedString1 isEqual:mixedBool1],   NO, @"Mixed with different types should be different (11)");
        XCTAssertEqual([mixedString1 isEqual:mixedInt1],    NO, @"Mixed with different types should be different (12)");
        XCTAssertEqual([mixedString1 isEqual:mixedBinary1], NO, @"Mixed with different types should be different (13)");
        XCTAssertEqual([mixedString1 isEqual:mixedDate1],   NO, @"Mixed with different types should be different (14)");
        XCTAssertEqual([mixedString1 isEqual:table1],       NO, @"Mixed with different types should be different (15)");
        
        XCTAssertEqual([mixedBinary1 isEqual:mixedBool1],   NO, @"Mixed with different types should be different (16)");
        XCTAssertEqual([mixedBinary1 isEqual:mixedInt1],    NO, @"Mixed with different types should be different (17)");
        XCTAssertEqual([mixedBinary1 isEqual:mixedString1], NO, @"Mixed with different types should be different (18)");
        XCTAssertEqual([mixedBinary1 isEqual:mixedDate1],   NO, @"Mixed with different types should be different (19)");
        XCTAssertEqual([mixedBinary1 isEqual:table1],       NO, @"Mixed with different types should be different (20)");
        
        XCTAssertEqual([mixedDate1 isEqual:mixedBool1],   NO, @"Mixed with different types should be different (21)");
        XCTAssertEqual([mixedDate1 isEqual:mixedInt1],    NO, @"Mixed with different types should be different (22)");
        XCTAssertEqual([mixedDate1 isEqual:mixedString1], NO, @"Mixed with different types should be different (23)");
        XCTAssertEqual([mixedDate1 isEqual:mixedBinary1], NO, @"Mixed with different types should be different (24)");
        XCTAssertEqual([mixedDate1 isEqual:table1],       NO, @"Mixed with different types should be different (25)");
        
        XCTAssertEqual([table1 isEqual:mixedBool1],   NO, @"Mixed with different types should be different (26)");
        XCTAssertEqual([table1 isEqual:mixedInt1],    NO, @"Mixed with different types should be different (27)");
        XCTAssertEqual([table1 isEqual:mixedString1], NO, @"Mixed with different types should be different (28)");
        XCTAssertEqual([table1 isEqual:mixedBinary1], NO, @"Mixed with different types should be different (29)");
        XCTAssertEqual([table1 isEqual:mixedDate1],   NO, @"Mixed with different types should be different (30)");
    }];
}


- (void)testMixed
{
    [[self realmWithTestPath] writeUsingBlock:^(RLMRealm *realm) {
        SubMixedTable *tableSub = [realm createTableWithName:@"tableSub" asTableClass:SubMixedTable.class];
        XCTAssertTrue([tableSub isKindOfClass:[RLMTable class]], @"RLMTable excepted");
        
        // Add some rows
        [tableSub addHired:YES Age:20];
        [tableSub addHired:NO Age:21];
        [tableSub addHired:YES Age:22];
        [tableSub addHired:NO Age:43];
        [tableSub addHired:YES Age:54];
        

        // Create new table in realm
        MixedTable *table = [realm createTableWithName:@"MixedValues" asTableClass:[MixedTable class]];
        NSLog(@"Table: %@", table);
        // Add some rows
        [table addHired:YES Other:[NSString stringWithUTF8String:"Jens"] Age:50];
        [table addHired:YES Other:[NSString stringWithUTF8String:"Aage"] Age:52];
        [table addHired:YES Other:[NSString stringWithUTF8String:"Joergen"] Age:53];
        [table addHired:YES Other:[NSString stringWithUTF8String:"Dave"] Age:54];
        [table addHired:YES Other:tableSub Age:54];
        [table addHired:YES Other:[NSDate date] Age:54];
    
        MixedTable *tableRetrieved = [realm tableWithName:@"MixedValues" asTableClass:[MixedTable class]];
        
        XCTAssertEqual([tableRetrieved rowCount], (NSUInteger)6, @"6 rows expected");
        XCTAssertTrue([tableRetrieved[0].Other isKindOfClass:[NSString class]], @"NSString excepted");
        XCTAssertTrue([tableRetrieved[4].Other isKindOfClass:[RLMTable class]], @"RLMTable excepted");
        XCTAssertEqual([(RLMTable *)tableRetrieved[4].Other rowCount], (NSUInteger)5,@"Subtable should have 5 rows");
        XCTAssertTrue([tableRetrieved[5].Other isKindOfClass:[NSDate class]], @"NSDate excepted");
        
        // Test cast and isClass
        // FIXME: When hasSameDescriptorAs is implemented, reenable unit test below
        // XCTAssertEquals([tableSub hasSameDescriptorAs:[SubMixedTable class]], YES,@"Unknown table should be of type SubMixedTable");
        tableSub = [tableSub castToTypedTableClass:[SubMixedTable class]];
        NSLog(@"TableSub Size: %lu", [tableSub rowCount]);
        XCTAssertEqual([tableSub rowCount], (NSUInteger)5,@"Subtable should have 5 rows");
        NSLog(@"Count int: %lu", [tableRetrieved countRowsWithInt:50 inColumnWithIndex:2]);
        NSLog(@"Max: %lld", [tableRetrieved maxIntInColumnWithIndex:2]);
        NSLog(@"Avg: %.2f", [tableRetrieved avgIntColumnWithIndex:2]);
    }];
}

-(void)testMixedValidate
{
    [self.realmWithTestPath writeUsingBlock:^(RLMRealm *realm) {
        MixedTable *table = [realm createTableWithName:@"table" asTableClass:MixedTable.class];
        XCTAssertThrows(([table addRow:@[@YES, @[@1, @2], @7]]), @"Mixed cannot be an NSArray");
        XCTAssertThrows(([table addRow:@[@YES, @{@"key": @7}, @11]]), @"Mixed cannot be an NSDictionary");
    }];
}
@end