import SwiftUI
import UIKit.UICollectionView
import Combine

public enum ScrollDecelerationRate {
    case Fast, Normal
}

public struct SwiftUISnapScrollView<T, ContentView>: UIViewRepresentable where ContentView: View {

    @Binding var position: Int
    @Binding var items: [T]
    @State private var lastItemCount: Int = 0
    private var itemWidth: CGFloat = 100
    private var itemSpacing: CGFloat = 0
    private var scrollDecelerationRate: ScrollDecelerationRate = .Fast
    private var snapPosition: HorizontalAlignment = .leading
    private var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    private let contentView: (T) -> ContentView
    private let layout: SwiftUISnapScrollCollectionViewFlowLayout
    // private let layout: UICollectionViewCompositionalLayout
    // layout = UICollectionViewCompositionalLayout(sectionProvider: {
    //     (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
    //
    //     let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
    //     let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //     item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    //
    //     let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalHeight(1), heightDimension: .fractionalHeight(1))
    //     let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    //
    //     let section = NSCollectionLayoutSection(group: group)
    //     // section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.none
    //     section.orthogonalScrollingBehavior = UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPagingCentered
    //
    //     return section
    // })
    // self.layout.scrollDirection = .horizontal
    
    public init(position: Binding<Int>, items: Binding<[T]>, @ViewBuilder contentView: @escaping (T) -> ContentView) {
        self._position = position
        self._items = items
        self.contentView = contentView
        self.layout = SwiftUISnapScrollCollectionViewFlowLayout()
        self.layout.scrollDirection = .horizontal
        // self.onChange(of: position.wrappedValue) { newValue in
        //     print("New Position", position, "newValue", newValue)
        // }
        // self.onReceive(Just(position)) { newValue in
        //     print("New Position", position, "newValue", newValue)
        // }
    }
    
    public func makeUIView(context: Context) -> UICollectionView {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        context.coordinator.setCollectionView(view)
        view.register(SwiftUISnapScrollCell.self, forCellWithReuseIdentifier: "Sample")
        view.dataSource = context.coordinator
        view.delegate = context.coordinator
        view.backgroundColor = UIColor.clear
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        return view
    }
 
    public func updateUIView(_ uiView: UICollectionView, context: Context) {
        context.coordinator.itemWidth = self.itemWidth
        context.coordinator.itemSpacing = self.itemSpacing
        // layout.snapPosition = self.snapPosition
        layout.collectionView?.decelerationRate = scrollDecelerationRate == .Fast ? UIScrollViewDecelerationRateFast : UIScrollViewDecelerationRateNormal
        layout.collectionView?.contentInset = edgeInsets
        if items.count == context.coordinator.itemCount {
            if let items = layout.collectionView?.indexPathsForSelectedItems {
                layout.collectionView?.reloadItems(at: items)
            }
        } else {
            uiView.reloadData()
        }
        context.coordinator.itemCount = items.count
    }
    
    public func makeCoordinator() -> SwiftUISnapScrollCoordinator<T, ContentView> {
        return SwiftUISnapScrollCoordinator(items: $items, contentView: contentView)
    }
    
    public func itemWidth(width itemWidth: CGFloat) -> Self {
        var new = self
        new.itemWidth = itemWidth
        return new
    }
    
    public func itemSpacing(margin: CGFloat) -> Self {
        var new = self
        new.itemSpacing = margin
        return new
    }
    
    public func scrollDecelerationRate(rate: ScrollDecelerationRate) -> Self {
        var new = self
        new.scrollDecelerationRate = rate
        return new
    }
    
    // public func snapPosition(snap: HorizontalAlignment) -> Self {
    //     var new = self
    //     new.snapPosition = snap
    //     return new
    // }
    
    public func edgeInsets(leading: CGFloat, trailing: CGFloat) -> Self {
        var new = self
        new.edgeInsets = UIEdgeInsets(top: 0, left: leading, bottom: 0, right: trailing)
        return new
    }
    
    public func edgeInsets(_ edgeInsets: UIEdgeInsets) -> Self {
        var new = self
        new.edgeInsets = edgeInsets
        return new
    }
    
    public func edgeInsets(_ edgeInsets: EdgeInsets) -> Self {
        var new = self
        new.edgeInsets = UIEdgeInsets(top: edgeInsets.top, left: edgeInsets.leading, bottom: edgeInsets.bottom, right: edgeInsets.trailing)
        return new
    }
}
 
