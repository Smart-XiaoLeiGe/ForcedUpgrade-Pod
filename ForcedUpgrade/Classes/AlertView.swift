//
//  File.swift
//
//
//  Created by Devin on 2023/4/17.
//

import SwiftUI

public struct AlertView: View {
    var showModel: CheckUpgradeResponseModel
    let cancelAction: () -> Void
    let confirmAction: () -> Void
    
    public init(showModel: CheckUpgradeResponseModel, cancelAction: @escaping () -> Void,  confirmAction: @escaping () -> Void) {
        self.showModel = showModel
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
    
    public var body: some View {
        VStack {
            Text(showModel.title)
                .foregroundColor(.blue)
                .font(.title)
            
            Text(showModel.description).padding(EdgeInsets.init(top: 20, leading: 0, bottom: 30, trailing: 0))
            Divider()
            HStack {
                if showModel.forcedUpgrade == false {
                    Button {
                        cancelAction()
                    } label: {
                        Text("Cancel")
                    }
                }
                Spacer()
                Button {
                    confirmAction()
                    
                } label: {
                    Text("Confirm")
                }
            }.padding(EdgeInsets(top: 20, leading: 20, bottom: 50, trailing: 20))
        }.padding(EdgeInsets(top: 20, leading: 50, bottom: 50, trailing: 50))
    }
}

struct AlertView_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        AlertView(showModel: CheckUpgradeResponseModel(forcedUpgrade: true, newVersion: "1.2.3", title: "123", description: "456")) {
            
        } confirmAction: {
            
        }

    }
}
