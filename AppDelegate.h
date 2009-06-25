//
//  __distributed_objectsAppDelegate.h
//  4_distributed_objects
//
//  Created by Brian Cooke on 6/24/09.
//  Copyright 2009 roobasoft, LLC. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HostsEditorServer.h"

@interface AppDelegate : NSObject {
    NSWindow *window;
    NSString *line;
    NSDistantObject<HostsEditorServerProtocol> * server;
}

@property (assign) IBOutlet NSWindow *window;
@property (nonatomic, retain) NSString *line;

- (IBAction) writeLine:(id)sender;
- (IBAction) clearLines:(id)sender;
- (IBAction) killServer:(id)sender;

@end
