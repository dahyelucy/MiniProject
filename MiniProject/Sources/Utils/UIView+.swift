//
//  UIView+.swift
//  MiniProject
//
//  Created by 최다혜 on 2022/11/10.
//

import UIKit

extension UIView {
    func safeAreaTopInset() -> CGFloat {
        let window = UIApplication.shared.windows.first
        let topPadding = window?.safeAreaInsets.top
        return topPadding ?? 0
    }
    
    func safeAreaBottomInset() -> CGFloat {
        let window = UIApplication.shared.windows.first
        let bottomPadding = window?.safeAreaInsets.bottom
        return bottomPadding ?? 0
    }
}
