//
//  AFUserDefault.swift
//  AFSwift
//
//  Created by Fazal Ellahi on 02/03/2025.
//

import Foundation

@propertyWrapper struct UserDefault<T: Codable> {
    var defaultValue: T
    var key: String
    var container = UserDefaults.standard
    var wrappedValue: T {
        set {
            let defaults = UserDefaults()
            let enodedVal = try? JSONEncoder().encode(newValue)
            container.set(enodedVal, forKey: key)
            container.synchronize()
        }
        get {
            let defaults = UserDefaults()
            let value = defaults.value(forKey: key)
            guard let _ = value else {return defaultValue}
            let data = try? JSONDecoder().decode(T.self, from: value as! Data)
            return data ?? defaultValue
        }
    }
}
