import MarkovModel
import Foundation
//import XCPlayground
import PlaygroundSupport

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


//var firstWord = "We're"
//let randomText = buildText(starting: firstWord, length: 20000, file: "rickroll.txt")
//print(randomText)

var urlString = playgroundSharedDataDirectory.appendingPathComponent("userinput.txt")
var fileContents: String?
do {
    fileContents = try String(contentsOf: urlString)
    print(fileContents!)
    var firstWord2 = ""
    if let first = fileContents!.components(separatedBy: " ").first {
        firstWord2 = first

        let randText2 = buildText(starting: firstWord2, length: 200, file: "userinput.txt")
        print(randText2)
        //"~/Documents/Shared Playground Data/userinput.txt"
    }
} catch {
    print("error reading contents: \(error)")
}

//let text2 = try URL(fileURLWithPath: "")
//    //String(contentsOf: "file:///Users/lsiegle/Documents/userinput.txt", encoding: .utf8)
//print(text2)
//var firstWord2 = "Nice"
