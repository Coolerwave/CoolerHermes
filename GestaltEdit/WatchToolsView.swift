import SwiftUI

struct WatchToolsSections: View {
    @EnvironmentObject private var viewModel: GestaltViewModel

    private func setTweak(_ id: String, enabled: Bool) {
        if enabled {
            viewModel.selectedWatchTweaks.insert(id)
        } else {
            viewModel.selectedWatchTweaks.remove(id)
            if id == "ultra" {
                viewModel.watchUltraFaceClass = viewModel.currentWatchUltraFaceClass
                    ?? viewModel.watchUltraFaceClassOptions.first ?? 29
            }
        }
    }

    private func binding(_ id: String) -> Binding<Bool> {
        Binding(
            get: { viewModel.selectedWatchTweaks.contains(id) },
            set: { setTweak(id, enabled: $0) }
        )
    }

    var body: some View {
        facesSection

        Section {
            Toggle("Enable Siri AI", isOn: binding("intelligence"))
        } header: {
            Text("Apple Intelligence")
        } footer: {
            Text("Automatically adjusts unsupported regions to the United States.")
        }

        ForEach(WatchTweakGroup.allCases.filter { $0 != .intelligence && $0 != .faces }) { group in
            Section {
                ForEach(WatchTweakCatalog.definitions.filter { $0.group == group }) { definition in
                    Toggle(definition.title, isOn: binding(definition.id))
                }
            } header: {
                Text(group.title)
            } footer: {
                if group == .sensors {
                    Text("Capability flags do not add missing sensors or override Health permissions.")
                }
            }
        }

        Section("Watch Region") {
            Picker("Region Code", selection: $viewModel.watchRegionCode) {
                Text("No Change").tag("")
                ForEach(WatchTweakCatalog.regions, id: \.1) { region in
                    Text(region.0).tag(region.1)
                }
            }
            Picker("Sales Region", selection: $viewModel.watchSalesRegion) {
                Text("No Change").tag("")
                ForEach(WatchTweakCatalog.regions, id: \.2) { region in
                    Text(region.0).tag(region.2)
                }
            }
        }
        Section("Watch Resolution") {
            Picker("Screen Resolution", selection: $viewModel.watchResolution) {
                Text("No Change").tag(-1)
                ForEach(WatchTweakCatalog.resolutions.indices, id: \.self) { index in
                    let resolution = WatchTweakCatalog.resolutions[index]
                    Text("\(resolution.0) · \(resolution.1) × \(resolution.2)").tag(index)
                }
            }
        }
    }

    @ViewBuilder
    private var facesSection: some View {
        Section {
            HStack(spacing: 12) {
                FaceCard(
                    title: "Hermès",
                    subtitle: "Signature faces",
                    symbol: "applewatch.watchface",
                    colors: [Color(red: 0.10, green: 0.80, blue: 0.78), Color(red: 0.10, green: 0.50, blue: 0.85)],
                    isOn: binding("hermes"),
                    isEnabled: viewModel.supportsWatchFaces
                )
                FaceCard(
                    title: "Ultra",
                    subtitle: "Ultra faces",
                    symbol: "applewatch",
                    colors: [Color(red: 0.30, green: 0.45, blue: 0.95), Color(red: 0.40, green: 0.22, blue: 0.85)],
                    isOn: binding("ultra"),
                    isEnabled: viewModel.supportsWatchFaces
                )
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .listRowBackground(Color.clear)

            if viewModel.watchUltraFaceClassOptions.count > 1 &&
                (viewModel.selectedWatchTweaks.contains("ultra") || viewModel.currentWatchUltraFaceClass != nil) {
                Picker("Ultra Face Layout", selection: Binding(
                    get: { viewModel.watchUltraFaceClass },
                    set: { layout in
                        viewModel.watchUltraFaceClass = layout
                        viewModel.selectedWatchTweaks.insert("ultra")
                    }
                )) {
                    ForEach(viewModel.watchUltraFaceClassOptions, id: \.self) { layout in
                        Text("Class \(layout)").tag(layout)
                    }
                }
            }
        } header: {
            Text("Watch faces")
        } footer: {
            if !viewModel.supportsWatchFaces {
                Text("Watch face changes are unavailable on this watchOS build.")
            } else {
                Text("Tap a card to select it, then press Apply. Ultra faces can prevent the Hermès Faubourg Party face from working.")
                if viewModel.watchUltraFaceClassOptions.count > 1 {
                    Text("A larger Ultra layout may affect other watch faces and complications.")
                }
            }
        }
    }
}

private struct FaceCard: View {
    let title: String
    let subtitle: String
    let symbol: String
    let colors: [Color]
    @Binding var isOn: Bool
    let isEnabled: Bool

    var body: some View {
        Button {
            isOn.toggle()
        } label: {
            VStack(alignment: .leading, spacing: 6) {
                HStack {
                    Image(systemName: symbol)
                        .font(.title2.weight(.semibold))
                    Spacer()
                    Image(systemName: isOn ? "checkmark.circle.fill" : "circle")
                        .font(.title3)
                }
                Spacer(minLength: 12)
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.caption)
                    .opacity(0.85)
            }
            .foregroundStyle(.white)
            .padding(14)
            .frame(maxWidth: .infinity, minHeight: 120, alignment: .leading)
            .background(
                LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    .opacity(isOn ? 1 : 0.55),
                in: RoundedRectangle(cornerRadius: 20, style: .continuous)
            )
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .opacity(isEnabled ? 1 : 0.5)
        .accessibilityLabel(title)
        .accessibilityValue(isOn ? "On" : "Off")
    }
}
