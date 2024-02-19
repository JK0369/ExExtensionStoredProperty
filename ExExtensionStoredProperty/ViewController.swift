//
//  ViewController.swift
//  ExExtensionStoredProperty
//
//  Created by 김종권 on 2023/01/17.
//

import UIKit

class ViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.text = "jake iOS app 알아가기 \n\n example text \n\n\n 123 \n\n\n example1 jake iOS app 알아가기 \n\n example text \n\n\n 123 \n\n\n example1 jake iOS app 알아가기 \n\n example text \n\n\n 123 \n\n\n example1 jake iOS app 알아가기 \n\n example text \n\n\n 123 \n\n\n example1 jake iOS app 알아가기 \n\n example text \n\n\n 123 \n\n\n example1 \n\n example text \n\n\n 123 \n\n\n example1 jake iOS app 알아가기 \n\n example text \n\n\n 123 \n\n\n example1"
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(scrollView)
        scrollView.addSubview(label)
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            label.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            label.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            label.topAnchor.constraint(equalTo: scrollView.topAnchor),
            label.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        scrollView.delegate = self
     
        var someClass: SomeClass? = scrollView.someClass
        someClass = nil // DEINIT: SomeClass
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        defer { scrollView.lastOffsetY = scrollView.contentOffset.y }
        
        guard scrollView.lastOffsetY != 0 else {
            print("more scroll")
            return
        }
        
        if scrollView.lastOffsetY < scrollView.contentOffset.y {
            print("more scroll")
        } else {
            print("less scroll")
        }
        
    }
}

private struct AssociatedKeys {
    static var lastOffsetY = "lastOffsetY"
    static var someClass = "someClass"
}

extension UIScrollView {
    var lastOffsetY: CGFloat {
        get {
            (objc_getAssociatedObject(self, &AssociatedKeys.lastOffsetY) as? CGFloat) ?? 0.0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.lastOffsetY, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var someClass: SomeClass {
        get {
            (objc_getAssociatedObject(self, &AssociatedKeys.someClass) as? SomeClass) ?? SomeClass()
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.someClass, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class SomeClass {
    init() { print("INIT") }
    deinit { print("DEINIT: SomeClass") }
}
