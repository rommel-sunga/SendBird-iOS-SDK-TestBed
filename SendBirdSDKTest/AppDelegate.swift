//
//  AppDelegate.swift
//  SendBirdSDKTest
//
//  Created by Rommel Sunga on 7/12/19.
//  Copyright © 2019 Rommel Sunga. All rights reserved.
//

import UIKit
import SendBirdSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var test_user_name:String = "test_user_1"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        
        print("TestBed Start")
        print("test_user = " + test_user_name)
        SBDMain.initWithApplicationId("FDD6A004-3FD5-478C-937A-B3ECA5BAEB61")
        SBDMain.connect(withUserId: self.test_user_name) { (user, error) in
            guard error == nil else {   // Error.
                return
            }
            
            // Create Empty Channel
            /*SBDGroupChannel.createChannel(withUserIds: [self.test_user_name], isDistinct: false) { (groupChannel, error) in
                guard error == nil else {   // Error.
                    print("Error Creating Channel")
                    return
                }
                
                guard let params = SBDUserMessageParams(message: "test") else { return }
                
                /*groupChannel?.sendUserMessage(with: params, completionHandler: { (userMessage, error) in
                    guard error == nil else {   // Error.
                        print("Error Sending Message")
                        return
                    }
                })*/
                
            }*/
            
            
            let query = SBDGroupChannel.createMyGroupChannelListQuery()
            query?.includeEmptyChannel = false
            query?.order = .latestLastMessage
            query?.limit = 15
            
            query?.loadNextPage(completionHandler: { (groupChannels, error) in
                guard error == nil else {   // Error.
                    print("Error Loading Channel List")

                    return
                }
                
                for groupChannel in groupChannels! {
                    print(groupChannel)
                    let previousMessageQuery = groupChannel.createPreviousMessageListQuery()
                    
                        
                    // Retrieving previous messages.
                    previousMessageQuery?.loadPreviousMessages(withLimit: 10, reverse: true, completionHandler: { (messages, error) in
                        guard error == nil else {   // Error.
                            print("Error Loading Channel Messages")
                            return
                        }
                        print("group channel url = " + String(groupChannel.channelUrl))
                        for message in messages! {
                            print("message ID = " + String(message.messageId))
                        }
                        
                    })
                }
                
            })
        }
        
        print("TestBed End")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

