import PerfectHTTP
import PerfectHTTPServer
import Foundation


var routes = Routes()
func writeToFile(urlString: String) {
    let file = "userinput.txt"
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let path = dir.appendingPathComponent("/Shared Playground Data/" + file)
        print(path)
        do {
            try urlString.write(to: path, atomically: false, encoding: String.Encoding.utf8)
        }
        catch {/* error handling here */}
    }
}

func getString(array : [String]) -> String {
    let stringArray = array.map{ String($0) }
    return stringArray.joined(separator: ".")
}
var inputArr: [String] = []
routes.add(method: .post, uri: "/sms", handler: {
    request, response in
    response.setHeader(.contentType, value: "text/xml")
    
    var body = request.param(name: "Body", defaultValue: "")
    if let bod = body {
        inputArr.append(bod)
        let respStr = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><Response><Message><Body>Got your message!</Body></Message></Response>"
        response.appendBody(string: respStr )
            .completed()
    }
    var joinedArr = getString(array: inputArr)
    print(joinedArr)
    writeToFile(urlString: joinedArr)
})

do {
    // Launch the HTTP server.
    try HTTPServer.launch(
        .server(name: "http://lizzie.ngrok.io", port: 8181, routes: routes))
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}

