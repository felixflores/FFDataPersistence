FFDataPersistence
=================

A helper class that simplifies application interaction with CoreData.

Setup
-----

Add the following to your plist:

	[[NSBundle mainBundle] infoDictionary][@"Data Persistence"][@"Manage Object Model"];
	[[NSBundle mainBundle] infoDictionary][@"Data Persistence"][@"Database Name"];

Then on your .pch file add the following:

	// If you're using a configuration class
	#import "FFConfiguration.h"

	#import "FFDataPersistence.h"
	#import "FFDataPersistence+Setup.h"
	#import "FFDataPersistence+Saving.h"
	#import "NSManagedObject+FFDataPersistence.h"

Also make sure that CoreData is included in your project:

	#ifdef __OBJC__
	    #import <UIKit/UIKit.h>
	    #import <Foundation/Foundation.h>
	    #import <CoreData/CoreData.h>
	#endif


You can *optionally* insert this to your app delegate to manually start the managed object context:

	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	{
	    FFDataPersistence *dataPersistence = [FFDataPersistence sharedInstance];
	    [dataPersistence start];
	    
	    return YES;
	}

Usage
-----
To instantiate a new NSManagedObject

	NSManagedObject *myObj = [NSManagedObject initInDataPersistenceContext];

This method returns an NSManagedObject which you can set attributes for

	[myObject setAttribute:@"a value"];

Then when you are done manipulating your NSManageObject you can save the current context

	[myObject save];

or 

	[myObject saveAndWait];

Code Sample
-----------
https://github.com/felixflores/CoreDataCodeSamples