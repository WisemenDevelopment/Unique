//
//  Device.h
//  DeviceName
//
//  Created by Wisemen on 13/01/2017.
//
//

#import <Cordova/CDV.h>
#import <Foundation/Foundation.h>


@interface DeviceName : CDVPlugin
{
    NSString* callbackId;
}
@property (nonatomic,copy) NSString* callbackId;

- (void)GetDevice:(CDVInvokedUrlCommand*)command;

//- (void)Getkey:(CDVInvokedUrlCommand*)command;
//- (void)Setkey:(CDVInvokedUrlCommand*)command;

@end
