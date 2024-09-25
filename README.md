# ForcedUpgrade

[![CI Status](https://img.shields.io/travis/Lei/ForcedUpgrade.svg?style=flat)](https://travis-ci.org/Smart-XiaoLeiGe/ForcedUpgrade-Pod)
[![Version](https://img.shields.io/cocoapods/v/ForcedUpgrade.svg?style=flat)](https://cocoapods.org/pods/ForcedUpgrade)
[![License](https://img.shields.io/cocoapods/l/ForcedUpgrade.svg?style=flat)](https://cocoapods.org/pods/ForcedUpgrade)
[![Platform](https://img.shields.io/cocoapods/p/ForcedUpgrade.svg?style=flat)](https://cocoapods.org/pods/ForcedUpgrade)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

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


## Installation

ForcedUpgrade is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ForcedUpgrade'
```

## Author

Lei, wanglei_sh163@163.com

## License

ForcedUpgrade is available under the MIT license. See the LICENSE file for more info.
