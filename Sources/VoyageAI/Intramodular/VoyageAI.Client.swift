//
// Copyright (c) Vatsal Manot
//

import CorePersistence
import LargeLanguageModels
import Merge
import NetworkKit
import Swallow

extension VoyageAI {
    @RuntimeDiscoverable
    public final class Client: HTTPClient, _StaticSwift.Namespace {
        public static var persistentTypeRepresentation: some IdentityRepresentation {
            _MIServiceTypeIdentifier._VoyageAI
        }
        
        public let interface: APISpecification
        public let session: HTTPSession
        
        public init(interface: APISpecification, session: HTTPSession) {
            self.interface = interface
            self.session = session
        }
        
        public convenience init(apiKey: String) {
            self.init(
                interface: .init(configuration: .init(apiKey: apiKey)),
                session: .shared
            )
        }
    }
}

extension VoyageAI.Client: _MIService {
    public convenience init(
        account: (any _MIServiceAccount)?
    ) async throws {
        let account: any _MIServiceAccount = try account.unwrap()
        let serviceIdentifier: _MIServiceTypeIdentifier = account.serviceIdentifier

        guard serviceIdentifier == _MIServiceTypeIdentifier._VoyageAI else {
            throw _MIServiceError.serviceTypeIncompatible(serviceIdentifier)
        }
        
        guard let credential = account.credential as? _MIServiceAPIKeyCredential else {
            throw _MIServiceError.invalidCredentials(account.credential)
        }
        
        self.init(apiKey: credential.apiKey)
    }
}

extension VoyageAI.Client {
    public func createEmbeddings(
        for model: VoyageAI.Model,
        input: [String],
        inputType: String? = nil,
        truncation: Bool = true,
        encodingFormat: VoyageAI.APISpecification.RequestBodies.CreateEmbedding.EncodingFormat? = nil
    ) async throws -> VoyageAI.Embeddings {
        try await run(
            \.createEmbeddings,
             with: .init(
                model: model,
                input: input,
                inputType: inputType,
                truncation: truncation,
                encodingFormat: encodingFormat
             )
        )
    }
}
