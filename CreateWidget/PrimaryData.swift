//
//  PrimaryData.swift
//  CreateWidget
//
//  Created by Issei Ueda on 2022/11/27.
//

import SwiftUI
import WidgetKit

struct PrimaryData {
    @AppStorage("CreateWidget", store: UserDefaults(suiteName: "group.isseiueda")) var primaryData : Data = Data()
    let storeData : StoreData
    
    func encodeData() {
        guard let data = try? JSONEncoder().encode(storeData) else {
            return
        }
        primaryData = data
        WidgetCenter.shared.reloadAllTimelines()
    }
    
}
