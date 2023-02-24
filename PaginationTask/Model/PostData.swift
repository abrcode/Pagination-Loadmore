//
//  PostData.swift
//  PaginationTask
//
//  Created by Aniket Rao on 23/12/21.
//

import Foundation

// MARK: - Welcome
class Posts : Codable{
    var hits: [Hit]?
    var nbHits, page, nbPages, hitsPerPage: Int?
    var exhaustiveNbHits, exhaustiveTypo: Bool?
    var exhaustive: Exhaustive?
    var query, params: String?
    var processingTimeMS: Int?
    var processingTimingsMS: ProcessingTimingsMS?
    var serverTimeMS: Int?
}

// MARK: - Exhaustive
class Exhaustive: Codable {
    var nbHits, typo: Bool?

}

// MARK: - Hit
class Hit : Codable{
    var createdAt, title: String?
    var url: String?
    var author: String?
    var points: Int?
    var storyText: String?
    var commentText: String?
    var numComments: Int?
    var storyID, storyTitle, storyURL, parentID: String?
    var createdAtI: Int?
    var tags: [String]?
    var objectID: String?
    var highlightResult: HighlightResult?
}

// MARK: - HighlightResult
class HighlightResult : Codable{
    var title, url, author, storyText: Author?

}

// MARK: - Author
class Author : Codable{
    var value: String?
    var matchLevel: MatchLevel?
    var matchedWords: [String?]?

}

enum MatchLevel : Codable{
    case none
}

// MARK: - ProcessingTimingsMS
class ProcessingTimingsMS : Codable{
    var afterFetch: AfterFetch?
    var request: Request?
    var total: Int?
}

// MARK: - AfterFetch
class AfterFetch: Codable {
    var total: Int?
}

// MARK: - Request
class Request : Codable{
    var roundTrip: Int?
}
