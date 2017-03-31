/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  DeviceName
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
   // self.viewController = [[MainViewController alloc] init];
   // return [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
 
    
    
    
    
    
}
- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    
    NSString *AppDeviceToken=[[NSString alloc] initWithFormat:@"%@",deviceToken];
    //NSLog(@"My token is: %@", self.AppDeviceToken);
    
    AppDeviceToken = [AppDeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
     AppDeviceToken = [AppDeviceToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
     AppDeviceToken = [AppDeviceToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    [[NSUserDefaults standardUserDefaults] setObject:AppDeviceToken forKey:@"_Device_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@'s Device Token is : %@",[[UIDevice currentDevice] name],AppDeviceToken);
}
- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

@end
