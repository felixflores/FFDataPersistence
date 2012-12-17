FFDataPersistence
=================

FFDataPersistence
A helper class that simplifies application interaction with CoreData.

Setup
-----
Insert the following into your app delegate:

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
	    FFDataPersistence *dataPersistence = [FFDataPersistence sharedInstance];
	    [dataPersistence start];
	    
	    return YES;
	}

Define the kTCDatabaseName constant (here I have created an FFConfiguration class:

	#import <Foundation/Foundation.h>

	@interface FFConfiguration : NSObject
		extern NSString *kTCDatabaseName;
	@end

	@implementation FFConfiguration
		NSString *kTCDatabaseName = @"CoreDataExample.sqlite";
	@end

Then on your pch file add the following:

	// If you're using a configuration class
	#import "FFConfiguration.h"

	#import "FFDataPersistence.h"
	#import "FFDataPersistence+Setup.h"
	#import "FFDataPersistence+Saving.h"

Also make sure that CoreData is included in your project:

	#ifdef __OBJC__
	    #import <UIKit/UIKit.h>
	    #import <Foundation/Foundation.h>
	    #import <CoreData/CoreData.h>
	#endif

Usage
-----
To instantiate a new NSManagedObject

	NSManagedObject *myObj = [[FFDataPersistence sharedInstance] createEntity:@"NameOfManagedObject"];

This method returns an NSManagedObject which you can set attributes for

	[myObject setAttribute:@"a value"];

Then when you are done manipulating your NSManageObject you can save the current context

	[[FFDataPersistence sharedInstance] saveContext];

or 

	[[FFDataPersistence sharedInstance] saveContextAndWait];