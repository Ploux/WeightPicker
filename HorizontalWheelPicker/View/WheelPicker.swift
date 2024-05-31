//
//  WheelPicker.swift
//  HorizontalWheelPicker
//
//  Created by Peter Loux on 5/31/24.
//

import SwiftUI

struct WheelPicker: View {
    // config
    var config: Config
    @Binding var value: CGFloat
    
    // view properties
    @State private var isLoaded: Bool = false
    var body: some View {
        GeometryReader {
            let size = $0.size
            let horizontalPadding = (size.width / 2)
            
            ScrollView(.horizontal) {
                HStack(spacing: config.spacing) {
                    let totalSteps = config.steps * config.count
                    
                    ForEach(0...totalSteps, id: \.self) { index in
                        let remainder = index % config.steps
                        
                        Divider()
                            .background(remainder == 0 ? Color.primary : .gray)
                            .frame(width: 0, height: remainder == 0 ? 20 : 10, alignment: .center)
                            .frame(maxHeight: 20, alignment: .bottom)
                            .overlay(alignment: .bottom) {
                                if remainder == 0 && config.showsText {
                                    Text("\((index / config.steps) * config.multiplier)")
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .textScale(.secondary)
                                    .fixedSize()
                                    .offset(y: 20)
                                }
                                
                            } // end overlay
                    } // end foreach
                } // end hstack
                .frame(height: size.height)
                .scrollTargetLayout()
            } // end scrollview
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: .init(get: {
                let position: Int? = isLoaded ? (Int(value) * config.steps) / config.multiplier : nil
                return position
            }, set: { newValue in
                if let newValue {
                    value = (CGFloat(newValue) / CGFloat(config.steps)) * CGFloat(config.multiplier)
                }
            }))
            .overlay(alignment: .center, content: {
                Rectangle()
                    .frame(width: 1, height: 40)
                    .padding(.bottom, 20)
            })
            .safeAreaPadding(.horizontal, horizontalPadding)
            .onAppear {
                if !isLoaded { isLoaded = true }
            }
        } // end geometry
    } // end body
    
    struct Config: Equatable {
        var count: Int
        var steps: Int = 10
        var spacing: CGFloat = 5
        var multiplier: Int = 10
        var showsText: Bool = true
        
    }
    
} // end WheelPicker

#Preview {
    ContentView()
}
