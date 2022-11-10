//
//  Formatter.swift
//  MiniProject
//
//  Created by 최다혜 on 2022/11/10.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
