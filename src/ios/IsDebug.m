/********* IsDebug.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "IsDebug.h"

@implementation IsDebug

- (void)getIsDebug:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    BOOL hasDebugDefinition = false;
    BOOL isDebug = false;

    // Check preprocessor definition
    #ifdef DEBUG
        hasDebugDefinition = true;
    #else
        hasDebugDefinition = false;
    #endif

    // check sandbox
    // https://stackoverflow.com/questions/26081543/how-to-tell-at-runtime-whether-an-ios-app-is-running-through-a-testflight-beta-i
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    NSString *receiptURLString = [receiptURL path];
    BOOL hasSandbox = ([receiptURLString rangeOfString:@"sandboxReceipt"].location != NSNotFound);

    isDebug = hasDebugDefinition || hasSandbox;
    
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK  messageAsBool:(isDebug)];

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end