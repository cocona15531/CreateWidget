//
//  WidgetExtension.swift
//  WidgetExtension
//
//  Created by Issei Ueda on 2022/11/27.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    @AppStorage("CreateWidget", store: UserDefaults(suiteName: "group.isseiueda")) var primaryData : Data = Data()
    func placeholder(in context: Context) -> SimpleEntry {
        let storeData = StoreData(showText: "-")
        return SimpleEntry(storeData : storeData, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let storeData = try? JSONDecoder().decode(StoreData.self, from: primaryData) else {
            return
        }
        let entry = SimpleEntry(storeData: storeData, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
        guard let storeData = try? JSONDecoder().decode(StoreData.self, from: primaryData) else {
            return
        }
        let entry = SimpleEntry(storeData: storeData, configuration: configuration)
        
        let timeline = Timeline(entries: [entry], policy: .never)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date = Date()
    let storeData : StoreData
    let configuration: ConfigurationIntent
}

struct WidgetExtensionEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.storeData.showText)
    }
}

struct WidgetExtension: Widget {
    let kind: String = "WidgetExtension"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WidgetExtensionEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WidgetExtension_Previews: PreviewProvider {
    static let storeData =  StoreData(showText: "-")
    static var previews: some View {
        WidgetExtensionEntryView(entry: SimpleEntry(storeData: storeData, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
