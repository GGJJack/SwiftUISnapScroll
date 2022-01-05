//
//  FullSizeView.swift
//  SwiftUISnapScroll_Example
//
//  Created by GGJJack on 2022/01/04.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUISnapScroll

struct FullSizeView: View {
    @State var position1: Int = 0
    @State var items1 = [Int].init(1...20)
    // @ObservedObject var controller: CalendarController = CalendarController(orientation: .vertical)
    
    var body: some View {
        GeometryReader { reader in
            HStack {
                SwiftUISnapScrollView(position: $position1, items: $items1) { item in
                    ZStack(alignment: .center) {
                        Text("Hello Jack \(item)")
                    }
                    .frame(width: reader.size.width * 0.8, height: reader.size.height - 10, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.4), radius: 2, x: 1, y: 1)
                }
                .itemSpacing(margin: 10)
                .itemWidth(width: reader.size.width * 0.8)
                .scrollDecelerationRate(rate: .Fast)
                // .frame(height: 100, alignment: .leading)
            }
            .navigationBarTitle("Full Size use")
        }
    }
}

struct FullSizeView_Previews: PreviewProvider {
    static var previews: some View {
        FullSizeView()
    }
}
