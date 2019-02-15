import MarkovModel
import Foundation

func buildText(starting: String, length: Int, file: String) -> String {
    let filename = file.split(separator: ".")
    var text = starting
    let filePath = Bundle.main.path(forResource: String(filename[0]), ofType: String(filename[1])) //get file from Resources
    let data = FileManager.default.contents(atPath: filePath!)
    let content = String(data: data!, encoding: .utf8)!
    let strings = content.replacingOccurrences(of: "\n", with: " ").components(separatedBy: " ")
    
    //train model and work on it all at once in a closure
    MarkovModel.process(transitions: strings) { matrix in
        buildWords(with: &text, length: length, chain: matrix)
    }
    
    return text
}

func buildWords(with text: inout String, length: Int, chain: Matrix<String>) {
    var word = text
    (0...length).forEach { _ in
        if let next = chain.next(given: word, process: .weightedRandom) {
            text.append(" \(next)")
            word = next
        }
    }
}
//[We're: rickroll.txt, CHAPTER: hp1.txt, Let's: illmakeamanoutofyou.txt, I: myshot.txt, Hey: helpless.txt, Hakuna: hakunamatata.txt, Thought: thankunext.txt]
var firstWord = "We're"
let randomText = buildText(starting: firstWord, length: 20000, file: "rickroll.txt")
print(randomText)
print("here")
