//
//  SwiftuISnapScrollCoordinator.swift
//  SwiftUISnapScroll
//
//  Created by GGJJack on 2022/01/04.
//

import UIKit
import SwiftUI

public class SwiftUISnapScrollCoordinator<T, ContentView: View>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @Binding private var items: [T]
    private let contentView: (T) -> ContentView
    private var collectionView: UICollectionView? = nil
    var itemWidth: CGFloat = 100
    var itemSpacing: CGFloat = 0
    var itemCount: Int = 0

    public init(items: Binding<[T]>, @ViewBuilder contentView: @escaping (T) -> ContentView) {
        self._items = items
        self.contentView = contentView
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Sample", for: indexPath) as? SwiftUISnapScrollCell
        let height = collectionView.frame.height
        let width = itemWidth //(collectionView.frame.width - itemSpacing) / CGFloat(visibleCount)
        cell?.setView(AnyView(self.contentView(self.items[indexPath.row]).frame(width: width, height: height, alignment: .center)))
        return cell ?? SwiftUISnapScrollCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let width = itemWidth //(collectionView.frame.width - itemSpacing) / CGFloat(visibleCount)
        return .init(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 //5
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return itemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // .init(top: 5, left: 5, bottom: 5, right: 5)
        .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        // self.collectionView?.autoSnapping(velocity: velocity, targetOffset: targetContentOffset)
    }
    
    public func setCollectionView(_ view: UICollectionView) {
        self.collectionView = view
    }
}
