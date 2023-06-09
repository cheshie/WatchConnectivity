import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    var shared = Shared()

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(user: "")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context,
                     completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(user: "")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context,
                     completion: @escaping (Timeline<Entry>) -> Void) {
        shared.fetchData { user in
            let entries = [
                SimpleEntry(user: user)
            ]
            let timeline = Timeline(entries: entries, policy: .never)
            completion(timeline)
        }
    }

    func recommendations() -> [IntentRecommendation<ConfigurationIntent>] {
        return [
            IntentRecommendation(intent: ConfigurationIntent(), description: "My Intent Widget")
        ]
    }
}

struct SimpleEntry: TimelineEntry {
    let date = Date()
    let user: String
    let configuration = ConfigurationIntent()
}

struct HourWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        if entry.user == "" {
            Text("Check iPhone app.")
        } else {
            Text("Hello \(entry.user)")
        }
    }
}

@main
struct ExampleWidget: Widget {
    let kind: String = "ExampleWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            HourWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
