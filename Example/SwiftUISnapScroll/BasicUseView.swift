//
//  BasicUseView.swift
//  SwiftUISnapScroll_Example
//
//  Created by GGJJack on 2022/01/04.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUISnapScroll

struct BasicUseView: View {
    
    // @ObservedObject var controller: CalendarController = CalendarController(orientation: .vertical)
    @State var position1: Int = 0
    @State var items1 = [Int].init(1...50)

    @State var position2: Int = 0
    @State var items2 = [Int].init(1...20)

    @State var position3: Int = 0
    @State var items3 = [Int].init(1...20)
    
    var body: some View {
        GeometryReader { reader in
            VStack(alignment: .leading) {
                Text("Basic")
                    .font(.title)
                SwiftUISnapScrollView(position: $position1, items: $items1) { item in
                    VStack(alignment: .center) {
                        Circle()
                            .fill(Color.red.opacity(0.8))
                            .frame(width: 50, height: 50)
                        Text("User \(item)")
                    }
                }
                .itemWidth(width: reader.size.width / 6)
                .scrollDecelerationRate(rate: .Normal)
                .frame(height: 100, alignment: .leading)
                
                Text("With left padding")
                    .font(.title)
                SwiftUISnapScrollView(position: $position2, items: $items2) { item in
                    ZStack(alignment: .center) {
                        Color.green.opacity(0.8)
                        Text("Card \(item)")
                    }
                }
                .itemSpacing(margin: 20)
                .itemWidth(width: reader.size.width / 4)
                .edgeInsets(leading: 10, trailing: 10)
                .frame(height: 100, alignment: .leading)

                Text("Card")
                        .font(.title)
                SwiftUISnapScrollView(position: $position3, items: $items3) { item in
                    GeometryReader { card in
                        VStack(alignment: .leading) {
                            Rectangle()
                                    .fill(Color.blue.opacity(0.8))
                                    .frame(width: card.size.width, height: 100)
                            Text("Title \(item)").font(Font.headline)
                            Text("Content \(item)").font(Font.caption)
                        }
                    }
                    .padding()
                    .frame(width: reader.size.width / 2.5, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color.black, radius: 2, x: 1, y: 1)
                    .padding()
                }
                .itemSpacing(margin: 10)
                .itemWidth(width: reader.size.width / 2.5)
                .edgeInsets(leading: 10, trailing: 10)
                .frame(height: 200, alignment: .leading)
            }
            .navigationBarTitle("Basic use")
        }
    }
}

struct BasicUseView_Previews: PreviewProvider {
    static var previews: some View {
        BasicUseView()
    }
}
