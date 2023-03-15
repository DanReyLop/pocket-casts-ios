import Foundation

public enum PodcastSorter {
    /**
     A case insensitive string comparison that ignores the word "The" at the start of the title.
     - Parameter title1 String
     - Parameter title2 String
     - Returns true when title1 is alphabetically before title2, false otherwise
     */
    public static func titleSort(title1: String, title2: String) -> Bool {

        var convertedTitle1 = title1.trimmingThePrefix()
        var convertedTitle2 = title2.trimmingThePrefix()

        convertedTitle1 = convertToPinyinIfNeeded(convertedTitle1)
        convertedTitle2 = convertToPinyinIfNeeded(convertedTitle2)

        return convertedTitle1.localizedLowercase.compare(convertedTitle2.localizedLowercase) == .orderedAscending
    }

    /**
     A simple integer comparison function
     - Parameter order1 Int32
     - Parameter order2 Int32
     - Returns true when order2 is greater than order1, false otherwise
     */
    public static func customSort(order1: Int32, order2: Int32) -> Bool {
        return order2 > order1
    }

    /**
     A simple date comparison function
     - Parameter order1 Int32
     - Parameter order2 Int32
     - Returns true when date2 is greater than date1, false otherwise
     */
    public static func dateAddedSort(date1: Date, date2: Date) -> Bool {
        return date1.compare(date2) == .orderedAscending
    }

    /**
     Converts Chinese characters to their Pinyin equivalent
     - Returns Pinyin string
     */
    private static func convertToPinyinIfNeeded(_ string: String) -> String {
        let range = NSRange(location: 0, length: string.utf16.count)
        let regex = try! NSRegularExpression(pattern: "[\\u4e00-\\u9fff]+")
        let hasChineseCharacter = regex.firstMatch(in: string, options: [], range: range) != nil

        if hasChineseCharacter {
            let mutableString = NSMutableString(string: string) as CFMutableString
            CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
            CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
            return mutableString as String
        } else {
            return string
        }
    }
}

private extension String {
    func trimmingThePrefix() -> String {
        guard let range = range(of: "^the ", options: [.regularExpression, .caseInsensitive]) else {
            return self
        }

        return String(self[range.upperBound...])
    }
}
