//
//  ContentView.swift
//  HorizontalWheelPicker
//
//  Created by Peter Loux on 5/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var config: WheelPicker.Config = .init(count: 30, steps: 5, spacing: 15, multiplier: 10)
    @State private var value: CGFloat = 10
    var body: some View {
        NavigationStack {
            
            VStack {
                Spacer(minLength: 40)
                HStack(alignment: .lastTextBaseline, spacing: 5, content: {
                    Text(verbatim: "\(value)")
                        .font(.largeTitle.bold())
                        .contentTransition(.numericText(value: value))
                        .animation(.snappy, value: value)
                    
                    Text("lbs")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
//                    Button ("Update") {
//                        withAnimation {
//                            value = 12
//                        }
//                    }
                    
                })
                .padding(.bottom, 30)
                
                WheelPicker(config: config, value: $value )
                    .frame(height: 60)
                
                Form {
                    Section ("Configuration") {
                        // count
                        Stepper("Segments: \(config.count)", value: $config.count, in: 1...100)
                        
                        // segmented picker for multiplier
                        Text("Multiplier")
                        Picker("Multiplier", selection: $config.multiplier) {
                            ForEach([1,10], id: \.self) { index in
                                Text("\(index)")
                            }
                        }
                        .pickerStyle(.segmented)
                        
                        // max
                        Text("Max Weight: \(config.count * config.multiplier)")
                    }
                    
                    // segmented picker for multiplier
                    Section ("Appearance") {
                        Text("Divisions per Segment")
                    Picker("Multiplier", selection: $config.steps) {
                        ForEach([5,10], id: \.self) { index in
                            Text("\(index)")
                        }
                    }
                    .pickerStyle(.segmented)

                    // slider bar for spacing
                    Text("Spacing")
                    Slider(value: $config.spacing, in: 1...100)
               

                    // showsText
                    Toggle("Show Text", isOn: $config.showsText)
                    }
                }
            }
            .navigationTitle("Weight Picker")
        }
    }
}

#Preview {
    ContentView()
}
