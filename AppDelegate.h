//
//  __distributed_objectsAppDelegate.h
//  4_distributed_objects

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
