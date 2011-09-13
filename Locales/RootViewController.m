//
//  RootViewController.m
//  Locales
//
//  Created by Ariel Rodriguez on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, readwrite, copy) NSArray *identifiers;
@property (nonatomic, readwrite, copy) NSArray *keys;
- (NSString *)humanFriendlyKeyName:(NSString *)key; 
@end

@implementation RootViewController
@synthesize identifiers; 
@synthesize keys; 

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder]; 
    if ( self != nil ) {
        NSArray *tmpKeys = [[NSArray alloc] initWithObjects:NSLocaleLanguageCode, NSLocaleCountryCode, NSLocaleCalendar, NSLocaleUsesMetricSystem, NSLocaleMeasurementSystem, NSLocaleDecimalSeparator, NSLocaleGroupingSeparator, NSLocaleCurrencySymbol, NSLocaleCurrencyCode, NSLocaleQuotationBeginDelimiterKey, NSLocaleQuotationEndDelimiterKey, nil]; 
        self.keys = tmpKeys; 
        [tmpKeys release]; 
        
        self.identifiers = [NSLocale availableLocaleIdentifiers]; 
    }
    return self; 
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.identifiers.count;
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section {
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[self.identifiers objectAtIndex:section]];     
    NSString *displayNameString = [locale displayNameForKey:NSLocaleIdentifier value:[locale objectForKey:NSLocaleIdentifier]];
    [locale release]; 
    return displayNameString; 
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return self.keys.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSString *key = [self.keys objectAtIndex:indexPath.row]; 
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:[self.identifiers objectAtIndex:indexPath.section]];
    id objectForKey = [locale objectForKey:key]; 
    if ( [objectForKey isKindOfClass:[NSCalendar class]] ) {
        cell.detailTextLabel.text = [objectForKey calendarIdentifier]; 
    } else if ( [objectForKey isKindOfClass:[NSNumber class]] ) { 
        cell.detailTextLabel.text = [objectForKey boolValue] == YES ? NSLocalizedString(@"yes",@"yes") : NSLocalizedString(@"no",@"no"); 
    } else {
        cell.detailTextLabel.text = objectForKey;
    }
    cell.textLabel.text = [self humanFriendlyKeyName:key]; 
    [locale release]; 
    return cell;
}

- (void)dealloc {
    self.identifiers = nil; 
    self.keys = nil; 
    
    [super dealloc];
}

- (NSString *)humanFriendlyKeyName:(NSString *)key {
    if ( [key isEqualToString:NSLocaleLanguageCode] ) {
        return NSLocalizedString(@"Language Code", @"Language Code"); 
    }
    
    if ( [key isEqualToString:NSLocaleCountryCode] ) {
        return NSLocalizedString(@"Country Code", @"Country Code"); 
    }    
    
    if ( [key isEqualToString:NSLocaleCalendar] ) {
        return NSLocalizedString(@"Calendar", @"Calendar"); 
    }   
    
    if ( [key isEqualToString:NSLocaleUsesMetricSystem] ) {
        return NSLocalizedString(@"Metric System", @"Metric System"); 
    } 
    
    if ( [key isEqualToString:NSLocaleMeasurementSystem] ) {
        return NSLocalizedString(@"Measurement System", @"Measurement System"); 
    } 
    
    if ( [key isEqualToString:NSLocaleDecimalSeparator] ) {
        return NSLocalizedString(@"Decimal Separator", @"Decimal Separator"); 
    }  
    
    if ( [key isEqualToString:NSLocaleGroupingSeparator] ) {
        return NSLocalizedString(@"Grouping Separator", @"Grouping Separator"); 
    }  
    
    if ( [key isEqualToString:NSLocaleCurrencySymbol] ) {
        return NSLocalizedString(@"Currency Symbol", @"Currency Symbol"); 
    }  
    
    if ( [key isEqualToString:NSLocaleCurrencyCode] ) {
        return NSLocalizedString(@"Currency Code", @"Currency Code"); 
    }  
    
    if ( [key isEqualToString:NSLocaleQuotationBeginDelimiterKey] ) {
        return NSLocalizedString(@"Quotation Begin Delimiter", @"Quotation Begin Delimiter"); 
    } 
    
    if ( [key isEqualToString:NSLocaleQuotationEndDelimiterKey] ) {
        return NSLocalizedString(@"Quotation End Delimiter", @"Quotation End Delimiter"); 
    }     
    
    return nil; 
}

@end
