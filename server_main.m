//
//  server_main.m
//  
#import <Cocoa/Cocoa.h>
#import "HostsEditorServer.h"


int main(int argc, char *argv[])
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSLog(@"server app is go");

    HostsEditorServer *server = [HostsEditorServer sharedServer];
    
    while (server.stayAlive) {
        // just twiddle our thumbs here
        // probably something smarter we can do?
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    }
    
    NSLog(@"dieing");
	[pool release];
    return 0;
}