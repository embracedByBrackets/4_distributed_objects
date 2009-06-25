//
//  __distributed_objectsAppDelegate.m
//  4_distributed_objects
//

#import "AppDelegate.h"
#import "BLAuthentication.h"


@implementation AppDelegate

@synthesize window;
@synthesize line;

//------------------------------------------------------------------------------
// applicationDidFinishLaunching
//------------------------------------------------------------------------------
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
    
    // are we already running?
    server = [NSConnection rootProxyForConnectionWithRegisteredName:@"HostsEditor" host:nil];
    
    if (server == nil) {
        // launch the server
        if ([[BLAuthentication sharedInstance] executeCommand:[[NSBundle mainBundle] pathForAuxiliaryExecutable:@"HostsEditorServer"] withArgs:[NSArray array]] == NO) {
            NSLog(@"can't do anything without root permision!");
            exit(0);
        }
        
        while (server == nil) {
            server = [NSConnection rootProxyForConnectionWithRegisteredName:@"HostsEditor" host:nil];
            sleep(1); // hackety hack, don't talk back.
                      // beach ball!!!!
                      // put this in a thread of somepin
        }
    }
    
    NSLog(@"good to go %@", server);

}




//------------------------------------------------------------------------------
// writeLine
//------------------------------------------------------------------------------
- (IBAction) writeLine:(id)sender
{
    [server writeLine:line];
}



//------------------------------------------------------------------------------
// clearLines
//------------------------------------------------------------------------------
- (IBAction) clearLines:(id)sender
{
    [server clearLines];
}



//------------------------------------------------------------------------------
// killServer
//------------------------------------------------------------------------------
- (IBAction) killServer:(id)sender
{
    [server die];
}

@end
