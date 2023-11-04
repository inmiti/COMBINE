//
//  Extension+URLResponse.swift
//  ListaBootMVVMv1
//
//  Created by ibautista on 3/11/23.
//

import Foundation

extension URLResponse {
    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
