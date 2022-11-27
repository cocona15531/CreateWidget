//
//  WidgetExtensionBundle.swift
//  WidgetExtension
//
//  Created by Issei Ueda on 2022/11/27.
//

import WidgetKit
import SwiftUI

@main
struct WidgetExtensionBundle: WidgetBundle {
    var body: some Widget {
        WidgetExtension()
        WidgetExtensionLiveActivity()
    }
}
