//
//  Device.m
//  DeviceName
//
//  Created by Wisemen on 13/01/2017.
//
//

#import "DeviceName.h"
#import<AdSupport/ASIdentifierManager.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <CoreFoundation/CoreFoundation.h>
#import <Security/Security.h>
#include <Accounts/Accounts.h>
#include <Foundation/Foundation.h>
#import <objc/runtime.h>
#include <MobileCoreServices/MobileCoreServices.h>
#include <Security/SecBase.h>
#include <Security/SecAccessControl.h>
#include <CoreFoundation/CFArray.h>
#include "KeychainItemWrapper.h"





@implementation DeviceName
@synthesize callbackId;


-(void) GetDevice:(CDVInvokedUrlCommand *)command

{
    
    self.callbackId = command.callbackId;
    
    
    NSString *DeviceName ;
    NSString * uuid;
    
    NSUUID *Devid;
    
    UIDevice *deviceInfo = [UIDevice currentDevice];
    
    Devid = [[UIDevice currentDevice] identifierForVendor];
    
    DeviceName = deviceInfo.name;
    
    NSString *devicevid = [Devid UUIDString];
    
    NSString *str = [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
    
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"YourAppLogin" accessGroup:nil];
    
   NSString *password = [keychainItem objectForKey:kSecValueData];
 //   NSString *username = [keychainItem objectForKey:kSecAttrAccount];
    
    
    [keychainItem setObject:@"password you are saving" forKey:kSecValueData];
  // [keychainItem setObject:@"username you are saving" forKey:kSecAttrAccount];
    
    NSString *te = @"test";
    
   
    // uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
  //  NSString *macid = [self getMacAddress];
    
    //DeviceName = [DeviceName stringByAppendingString:@","];
    
   // DeviceName = [DeviceName stringByAppendingString:uuid
    
    
                 // ];
  //  if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
  //  {
      //  [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
      //  [[UIApplication sharedApplication] registerForRemoteNotifications];
   // }
  //  else
  //  {
     //   [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
      //   (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
   // }
    
 
    
    
    // Use default keychain
                                          

    
                                            
                                            
                                                          // Uninterested in item reference
                                            
    
  //  OSStatus  SecKeychainAddGenericPassword( NULL, service.length, service ,account.length, [account UTF8String],  password.length, passwordData, NULL);
                                           

                                            
                                           
                                            
                                           
    //
     //      OSStatus status;                                      // Uninterested in item reference
    
  //status =  StorePasswordKeychain (@"passwordData", 12);

                                  

    NSString *TOKEN = [[NSUserDefaults standardUserDefaults] stringForKey:@"_Device_token"];
    
    CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:TOKEN];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
    
    
}
//OSStatus StorePasswordKeychain ( void* password,UInt32 passwordLength)
//{
 //   OSStatus status;
   // status = SecKeychainAddGenericPassword (
   //                                         NULL,            // default keychain
   //                                         10,              // length of service name
   ///                                         "SurfWriter",    // service name
   //                                         10,              // length of account name
   //                                         "MyUserAcct",    // account name
   //                                         passwordLength,  // length of password
    //                                        password,        // pointer to password data
    //                                        NULL             // the item reference
    //                                       );
    //return (status);
//}

//-(void) Setkey:(CDVInvokedUrlCommand *)command:(CDVInvokedUrlCommand *)command{
  //  NSString* service = @"myService";
  //  NSString* account = @"username";
 //   NSString* password = @"somethingSecret";
 //   const void* passwordData = [[password dataUsingEncoding:NSUTF8StringEncoding] bytes];
 ////   const char * serviceName = [service UTF8String];
 //   const char * accountName = [account UTF8String];
 //   const char * password1 = [password UTF8String];
 //   OSStatus SecKeychainAddGenericPassword ();
    
 //   OSStatus status;
 //   status = SecKeychainAddGenericPassword(NULL,
                                     //      strlen(serviceName), serviceName,
                                     ////      strlen(accountName), accountName,
                                      //     strlen(password1), password1,
                                     //      NULL);
//
//}
//-(void) Getkey:(CDVInvokedUrlCommand *)command:(CDVInvokedUrlCommand *)command{




//}



- (NSString *)getMacAddress
{
    int mgmtInfoBase[6];
    char *msgBuffer = NULL;
    NSString *errorFlag = NULL;
    size_t length;
    // Setup the management Information Base (mib)
    mgmtInfoBase[0] = CTL_NET; // Request network subsystem
    mgmtInfoBase[1] = AF_ROUTE; // Routing table info
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK; // Request link layer information
    mgmtInfoBase[4] = NET_RT_IFLIST; // Request all configured interfaces
    // With all configured interfaces requested, get handle index
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    // Get the size of the data available (store in len)
    else if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
        errorFlag = @"sysctl mgmtInfoBase failure";
    // Alloc memory based on above call
    else if ((msgBuffer = malloc(length)) == NULL)
        errorFlag = @"buffer allocation failure";
    // Get system information, store in buffer
    else if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0) {
        free(msgBuffer);
        errorFlag = @"sysctl msgBuffer failure";
    } else {
        // Map msgbuffer to interface message structure
        struct if_msghdr *interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
        // Map to link-level socket structure
        struct sockaddr_dl *socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
        // Copy link layer address data in socket structure to an array
        unsigned char macAddress[6];
        memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
        // Read from char array into a string object, into traditional Mac address format
        NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                      macAddress[0], macAddress[1], macAddress[2], macAddress[3], macAddress[4], macAddress[5]];
        NSLog(@"Mac Address: %@", macAddressString);
        // Release the buffer memory
        free(msgBuffer);
        return macAddressString;
    }
    NSLog(@"Error: %@", errorFlag);
    return nil;
}
@end

