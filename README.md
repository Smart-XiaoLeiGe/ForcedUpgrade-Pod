# ForcedUpgrade

[![CI Status](https://img.shields.io/travis/Lei/ForcedUpgrade.svg?style=flat)](https://travis-ci.org/Smart-XiaoLeiGe/ForcedUpgrade-Pod)
[![Version](https://img.shields.io/cocoapods/v/ForcedUpgrade.svg?style=flat)](https://cocoapods.org/pods/ForcedUpgrade)
[![License](https://img.shields.io/cocoapods/l/ForcedUpgrade.svg?style=flat)](https://cocoapods.org/pods/ForcedUpgrade)
[![Platform](https://img.shields.io/cocoapods/p/ForcedUpgrade.svg?style=flat)](https://cocoapods.org/pods/ForcedUpgrade)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Functions
1. Check app version from backend service(need implement by backend team), data structure is CheckUpgradeResponseModel
2. Show alert page to remind user new version by backend api data, only one upgrade button if need 'forcedUpgrade' feature
3. If user select cancel button, will remind user again after three days
4. If user select confirm button, jump to app store 

## Use it in UIKit

Find AppDelegate file of the repo, you will find the following code. Copy to same position in you project, Replace with your appId, serverUrl and token if you need.
```
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let window = UIApplication.shared.windows.first { $0.isKeyWindow }
        ForcedUpgrade.shared.checkUpgrade((window?.rootViewController)!, appId: "1142110895", serverUrl: "https://jsonplaceholder.typicode.com/users", checkModel: CheckUpgradeModel(token: "token")) { _ in
        }
    }
```
## Use it in SwiftUI
1. add `@Environment(\.scenePhase) var scenePhase` to App
2. add `onChange` modifier
3. add the code following `print("App is active")` into enum case .active

```
import SwiftUI
import XLGForcedUpgrade

@main
struct TestPodApp: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
                if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                    let window = scene.windows.filter { $0.isKeyWindow }.first
                    let rootViewController = window?.rootViewController
                    // 使用 rootViewController
                    ForcedUpgrade.shared.checkUpgrade((window?.rootViewController)!, appId: "1142110895", serverUrl: "https://jsonplaceholder.typicode.com/users", checkModel: CheckUpgradeModel(token: "token")) { _ in
                    }
                }
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
}
```



## Installation

ForcedUpgrade is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'XLGForcedUpgrade' 
```

## Author

Lei, wanglei_sh163@163.com

## License

ForcedUpgrade is available under the MIT license. See the LICENSE file for more info.
