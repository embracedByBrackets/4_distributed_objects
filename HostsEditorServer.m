//
//  HostsEditorServer.m
//  4_distributed_objects
//
//  Created by Brian Cooke on 6/24/09.
//  Copyright 2009 roobasoft, LLC. All rights reserved.
//

#import "HostsEditorServer.h"


@implementation HostsEditorServer
@synthesize stayAlive;

//------------------------------------------------------------------------------
// init
//------------------------------------------------------------------------------
- (id) init
{
    [super init];
    
    // setup the listening object
    NSLog(@"initializing server");
    
    server = [NSConnection defaultConnection];
    
    [server setRootObject:self];
    if ([server registerName:@"HostsEditor"] == NO) 
    {
		NSLog(@"Failed to register name");
        stayAlive = NO;
        return self;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionDidDie:) name:NSConnectionDidDieNotification object:server];
    
    stayAlive = YES;
    [server setDelegate:self];
    NSLog(@"registered.\n");
    
    
    return self;
}



//------------------------------------------------------------------------------
// writeLine
//------------------------------------------------------------------------------
- (BOOL) writeLine:(in bycopy NSString *)line
{
    NSLog(@"writing %@", line);
    
    NSMutableString *file = [NSMutableString stringWithContentsOfFile:@"/etc/hosts" encoding: NSUTF8StringEncoding error: NULL];
    
    BOOL hasBlock = ([file rangeOfString:@"# START DOTEST BLOCK"].location != NSNotFound);
    
    if (!hasBlock)
    {
        [file appendString:@"\n# START DOTEST BLOCK\n"];        
        [file appendString:@"\n# STOP DOTEST BLOCK\n"];
    }
    
    NSRange end = [file rangeOfString:@"\n# STOP DOTEST BLOCK\n"];
    
    [file insertString:[NSString stringWithFormat:@"%@\n", line] atIndex:end.location];
    
    
    [file writeToFile:@"/etc/hosts" atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    return YES;
}



//------------------------------------------------------------------------------
// clearLines
//------------------------------------------------------------------------------
- (BOOL) clearLines
{
    NSLog(@"clearing");
    NSMutableString *file = [NSMutableString stringWithContentsOfFile:@"/etc/hosts" encoding: NSUTF8StringEncoding error: NULL];

    NSRange startRange = [file rangeOfString:@"# START DOTEST BLOCK"];
    NSRange endRange = [file rangeOfString:@"# STOP DOTEST BLOCK"];
    
    NSRange deleteRange = NSMakeRange(startRange.location - 1, ((endRange.location + endRange.length) - startRange.location) + 2);
    
    [file deleteCharactersInRange: deleteRange];    
    
    [file writeToFile:@"/etc/hosts" atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    return YES;
}



//------------------------------------------------------------------------------
// die
//------------------------------------------------------------------------------
- (BOOL) die
{
    stayAlive = NO;
    return YES;
}



//------------------------------------------------------------------------------
// connectionDidDie
//------------------------------------------------------------------------------
- (void) connectionDidDie:(id)ignore
{
    NSLog(@"notification that connection died!");
}



HostsEditorServer *sharedServer;

//------------------------------------------------------------------------------
// helperServer
//------------------------------------------------------------------------------
+ (HostsEditorServer *) sharedServer
{
    if( sharedServer == nil )
    {
        sharedServer = [[HostsEditorServer alloc] init];
    }
    
    return sharedServer;
}



@end
