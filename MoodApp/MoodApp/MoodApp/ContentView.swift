import SwiftUI

struct ContentView: View {
    @State private var isSunny = false
    @State private var showTip = false
    @State private var selectedMood = "😊"

    private let moods = ["😊", "😢", "😡", "😴"]
    @Namespace private var moodAnimation

    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {
                    Text("ჩემი განწყობა")
                        .font(.largeTitle.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 18) {
                        Text("მზე")
                            .font(.title2.bold())

                        Circle()
                            .fill(isSunny ? Color.yellow : Color.gray.opacity(0.55))
                            .frame(width: isSunny ? 150 : 100, height: isSunny ? 150 : 100)
                            .rotationEffect(.degrees(isSunny ? 45 : 0))
                            .shadow(color: isSunny ? .yellow.opacity(0.5) : .clear, radius: 18)

                        Button(isSunny ? "ჩააქრე" : "გაანათე") {
                            withAnimation(.spring(response: 0.45, dampingFraction: 0.55)) {
                                isSunny.toggle()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(.background, in: RoundedRectangle(cornerRadius: 20))

                    VStack(spacing: 16) {
                        Text("დღის რჩევა")
                            .font(.title2.bold())

                        if showTip {
                            HStack(spacing: 12) {
                                Text("💧")
                                    .font(.largeTitle)
                                Text("დალიე წყალი")
                                    .font(.headline)
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.cyan.opacity(0.2), in: RoundedRectangle(cornerRadius: 16))
                            .transition(.move(edge: .top).combined(with: .opacity))
                        }

                        Button(showTip ? "დამალე" : "დღის რჩევა") {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                showTip.toggle()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(.background, in: RoundedRectangle(cornerRadius: 20))

                    VStack(spacing: 18) {
                        Text("აირჩიე განწყობა")
                            .font(.title2.bold())

                        HStack(spacing: 16) {
                            ForEach(moods, id: \.self) { mood in
                                Button {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                                        selectedMood = mood
                                    }
                                } label: {
                                    ZStack {
                                        if selectedMood == mood {
                                            Circle()
                                                .fill(Color.purple.opacity(0.22))
                                                .matchedGeometryEffect(id: "selectedMood", in: moodAnimation)
                                                .frame(width: 54, height: 54)
                                        }

                                        Text(mood)
                                            .font(.system(size: 30))
                                            .frame(width: 54, height: 54)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        Text("დღეს ჩემი განწყობაა: \(selectedMood)")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(.background, in: RoundedRectangle(cornerRadius: 20))
                }
                .padding()
            }
        }
    }
}
