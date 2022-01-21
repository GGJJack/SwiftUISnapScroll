//
//  Cell.swift
//  SwiftUISnapScroll
//
//  Created by GGJJack on 2022/01/04.
//

import UIKit.UICollectionView
import UIKit.UICollectionViewCell
import SwiftUI

final class HostingController<Content: View>: UIHostingController<Content> {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.setNeedsUpdateConstraints()
    }
    
    //Reference from https://defagos.github.io/swiftui_collection_part3/
    convenience public init(rootView: Content, ignoreSafeArea: Bool) {
        self.init(rootView: rootView)
        
        if ignoreSafeArea {
            disableSafeArea()
        }
    }
    
    func disableSafeArea() {
        guard let viewClass = object_getClass(view) else { return }
        
        let viewSubclassName = String(cString: class_getName(viewClass)).appending("_IgnoreSafeArea")
        if let viewSubclass = NSClassFromString(viewSubclassName) {
            object_setClass(view, viewSubclass)
        }
        else {
            guard let viewClassNameUtf8 = (viewSubclassName as NSString).utf8String else { return }
            guard let viewSubclass = objc_allocateClassPair(viewClass, viewClassNameUtf8, 0) else { return }
            
            if let method = class_getInstanceMethod(UIView.self, #selector(getter: UIView.safeAreaInsets)) {
                let safeAreaInsets: @convention(block) (AnyObject) -> UIEdgeInsets = { _ in
                    return .zero
                }
                class_addMethod(viewSubclass, #selector(getter: UIView.safeAreaInsets), imp_implementationWithBlock(safeAreaInsets), method_getTypeEncoding(method))
            }
            
            objc_registerClassPair(viewSubclass)
            object_setClass(view, viewSubclass)
        }
    }
}

class SwiftUISnapScrollCell: UICollectionViewCell {
    let hostingView = HostingController(rootView: AnyView(EmptyView()), ignoreSafeArea: true)
    
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
        NSLayoutConstraint.activate([
            hostingView.view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            hostingView.view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            hostingView.view.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            hostingView.view.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    public func setView(_ view: AnyView) {
        hostingView.rootView = view
    }
}
