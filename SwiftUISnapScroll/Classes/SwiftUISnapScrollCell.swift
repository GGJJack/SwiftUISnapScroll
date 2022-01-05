//
//  Cell.swift
//  SwiftUISnapScroll
//
//  Created by GGJJack on 2022/01/04.
//

import UIKit.UICollectionView
import UIKit.UICollectionViewCell
import SwiftUI

class SwiftUISnapScrollCell: UICollectionViewCell {
    private let hostingView = UIHostingController(rootView: AnyView(EmptyView()))
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        addSubview(hostingView.view)
        hostingView.view.translatesAutoresizingMaskIntoConstraints = false
        hostingView.view.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        hostingView.view.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    public func setView(_ view: AnyView) {
        hostingView.rootView = view
    }
}
