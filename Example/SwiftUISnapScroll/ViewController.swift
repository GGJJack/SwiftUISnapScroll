//
//  ViewController.swift
//  SwiftUISnapScroll
//
//  Created by GGJJack on 01/04/2022.
//  Copyright (c) 2022 ggaljjak. All rights reserved.
//

import UIKit
import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: BasicUseView()) {
                    Text("Basic use")
                }
                NavigationLink(destination: FullSizeView()) {
                    Text("Full Size")
                }
            }
            .navigationBarTitle("Home")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
        MainView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let contentViewController = UIHostingController(rootView: MainView())
        self.addChildViewController(contentViewController)
        self.view.addSubview(contentViewController.view)
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

