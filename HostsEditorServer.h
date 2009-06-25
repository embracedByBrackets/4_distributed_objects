//
//  HostsEditorServer.h
//  4_distributed_objects
//
//

#import <Cocoa/Cocoa.h>

#pragma mark protocol definitions

//
// main application calls these to talk to the server process.
//
@protocol HostsEditorServerProtocol
- (BOOL) writeLine:(in bycopy NSString *)line;
- (BOOL) clearLines;
- (BOOL) die;
@end



//----------------------------------------------------------
// Class:  HelperServer
//
// this is a singleton that hangs out waiting to here from our
// helper app and dispatches accordingly.
//----------------------------------------------------------
@interface HostsEditorServer : NSObject <HostsEditorServerProtocol>
{
    NSConnection *          server;
    BOOL                    stayAlive;
}

@property (readonly) BOOL stayAlive;

// required for our protocol.
- (BOOL) writeLine:(in bycopy NSString *)line;
- (BOOL) clearLines;
- (BOOL) die;

// notification of a client dying
- (void) connectionDidDie:(id)ignore;

// access to our singleton
+ (HostsEditorServer *) sharedServer;


@end
