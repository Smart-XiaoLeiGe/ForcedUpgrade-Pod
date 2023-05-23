import SwiftUI

@available(iOS 13.0, *)
public struct ForcedUpgrade {
    public init() {}

    public func alertView(response json: String) -> AlertView? {
        let logic = CheckLogic()
        let result = logic.checkUpgrade(response: json)
        if result.showAlertView {
            return AlertView(showModel: result)
        } else {
            return nil
        }
    }
}
