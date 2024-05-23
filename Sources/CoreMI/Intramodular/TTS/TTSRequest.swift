//
// Copyright (c) Vatsal Manot
//

import Foundation
import Merge
import Swift

public protocol TTSRequest: _MIRequest {
    
}

public struct NaiveTTSRequest: Codable, Hashable, Sendable, TTSRequest {
    public let text: String
}

extension NaiveTTSRequest {
    public struct Result {
        public let data: Data
    }
}
