import SwiftUI
import XLG_BundleInfos
import UIKit

public struct CheckUpgradeModel: Codable {
    var bundleId: String {
        XLGBundleInfos().cfBundleIdentifier.value
    }
    var version: String {
        XLGBundleInfos().cfBundleShortVersionString.value
    }
    var token: String
    
    public init(token: String) {
        self.token = token
    }
}

public struct CheckUpgradeResponseModel: Codable {
    var forcedUpgrade: Bool
    var newVersion: String
    var title: String
    var description: String
}

public class ForcedUpgrade {
    var stackView : UIStackView = UIStackView()
    var appId: String = ""
    var serverUrl: String = ""
    var checkModel: CheckUpgradeModel?
    
    let LastCheckKey = "LastTapDate"
    
    public var enablePeriodCheck:Bool{
        get {
            return  UserDefaults.standard.object(forKey: LastCheckKey) != nil
        }
        
        set {
            if newValue {
                UserDefaults.standard.set(Date(), forKey: LastCheckKey)
            }else{
                UserDefaults.standard.removeObject(forKey: LastCheckKey)
            }
        }
    }
    var checkPeriod: Int = 3 //3 days
    
    var checkAppUpgradeString:String {
        "itms-apps://apps.apple.com/cn/app/id\(appId)"
    }
    
    private init(){
    }
    // 公有的静态属性，用于获取实例
    static public let shared = ForcedUpgrade()
    
    
    public func checkCanOpen()->Bool{
//        return false
        // 尝试创建 URL 对象
        guard let appStoreURL = URL(string: self.checkAppUpgradeString) else {
            print("Invalid URL string.")
            return false
        }
        // 使用 UIApplication 的 open 方法打开 URL
        return UIApplication.shared.canOpenURL(appStoreURL)
    }
    
    public func goToAppStore() {
        guard let appStoreURL = URL(string: self.checkAppUpgradeString) else {
            print("Invalid URL string.")
            return
        }
        
        UIApplication.shared.open(appStoreURL)
    }
    
    //Whole upgrade process = checkCanOpen & goToAppStore
    public func upgradeApp() -> Bool {
        // 尝试创建 URL 对象
        guard let appStoreURL = URL(string: self.checkAppUpgradeString) else {
            print("Invalid URL string.")
            return false
        }
        // 使用 UIApplication 的 open 方法打开 URL
        if UIApplication.shared.canOpenURL(appStoreURL) {
            UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
            return true
        } else{
            return false
        }
    }
    
     func checkOverDue() -> Bool {
        let lastTapDate = UserDefaults.standard.object(forKey: "LastTapDate") as? Date ?? Date.distantPast
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: lastTapDate, to: Date())
        let daysElapsed = components.day ?? 0

        return daysElapsed >= checkPeriod
    }
    
    
    /**
     send network request to server, check response
     */
    public func checkUpgrade(_ viewController:UIViewController, appId:String = "", serverUrl: String = "", checkModel: CheckUpgradeModel = CheckUpgradeModel(token: ""), completionHandler: @escaping (Result<CheckUpgradeResponseModel, Error>) -> Void) {
        self.appId = appId
        self.serverUrl = serverUrl
        self.checkModel = checkModel
        
        if self.enablePeriodCheck && !self.checkOverDue() {
            return
        }
        
        // 发请求
        // 将参数转换为 JSON 数据
        let jsonData = try? JSONEncoder().encode(checkModel)
            
        // 创建请求
        var request = URLRequest(url: URL(string: serverUrl)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
            
        // 执行异步请求
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                // 处理错误
                completionHandler(.failure(error))
                return
            }
                
            guard let data = data else {
                // 如果没有收到数据，返回错误
                completionHandler(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
                
            do {
                // 尝试将 JSON 数据解码为模型
                let model : CheckUpgradeResponseModel = try JSONDecoder().decode(CheckUpgradeResponseModel.self, from: data)
//                let model : CheckUpgradeResponseModel = CheckUpgradeResponseModel(forcedUpgrade: false, newVersion: "5.2.2", title: "New version is coming!", description: "New version, New way to live!")
                if checkModel.version < model.newVersion {
                    completionHandler(.success(model))
                    DispatchQueue.main.async {
                        self.addAlert(viewController: viewController, model: model)
                    }
                    
                }
            } catch {
                // 解码失败，返回错误
                completionHandler(.failure(error))
            }
        }
            
        // 启动任务
        task.resume()
    }
    
    func addAlert(viewController:UIViewController, model:CheckUpgradeResponseModel) {
        //when alert appear,should remove last period tag
        ForcedUpgrade.shared.enablePeriodCheck = false
        let hostingController = UIHostingController(rootView: AlertView(showModel: model, cancelAction: {
            self.stackView.removeFromSuperview()
            //if you want to use the "OverDueNotice" feature, you can add the following code.
            ForcedUpgrade.shared.enablePeriodCheck = true
        }, confirmAction: {
            self.stackView.removeFromSuperview()
            if ForcedUpgrade.shared.checkCanOpen() {
                ForcedUpgrade.shared.goToAppStore()
            }else{
                let alert = UIAlertController(title: "Update Available", message: "Please update your app through the App Store.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                viewController.present(alert, animated: true)
            }
        }))
        viewController.addChild(hostingController)
        let spacing = 10.0
        stackView = UIStackView(arrangedSubviews: [hostingController.view])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = spacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: viewController.view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: viewController.view.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: viewController.view.layoutMarginsGuide.topAnchor, constant: spacing)
        ])
        hostingController.didMove(toParent: viewController)
    }
}
