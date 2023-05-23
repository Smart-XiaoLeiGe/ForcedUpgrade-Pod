//
//  File.swift
//
//
//  Created by Devin on 2023/4/18.
//

import Foundation
import SwiftUI

struct ShowModel: Hashable, Codable {
    var showAlertView: Bool = false
    var forceUpgrade: Bool = false
    var title: String = ""
    var description: String = ""
}
