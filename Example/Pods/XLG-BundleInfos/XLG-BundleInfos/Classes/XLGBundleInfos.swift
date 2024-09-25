import Foundation

protocol InfoDictionaryParseable {
    var value: String {get}
}

extension CFString : InfoDictionaryParseable {
    public var value: String {
        return Bundle.main.infoDictionary?[self as String] as! String
    }
}
extension String: InfoDictionaryParseable {
    public var value: String {
        return Bundle.main.infoDictionary?[self] as! String
    }
}



public struct XLGBundleInfos {
    public init() {
        
    }
    
    public let cfBundleSupportedPlatforms = "CFBundleSupportedPlatforms"
    public let cfBundleInfoDictionaryVersion = "CFBundleInfoDictionaryVersion"
    public let cfBundleDevelopmentRegion = "CFBundleDevelopmentRegion"
    public let cfBundleNumericVersion = "CFBundleNumericVersion"
    public let cfBundleIdentifier = "CFBundleIdentifier"
    public let cfBundleShortVersionString = "CFBundleShortVersionString"
    public let cfBundleExecutable = "CFBundleExecutable"
    public let cfBundlePackageType = "CFBundlePackageType"
    public let cfBundleName = "CFBundleName"
    public let cfBundleVersion = "CFBundleVersion"
}
