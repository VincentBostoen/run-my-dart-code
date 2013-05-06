import 'dart:html';
import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

void main() {
  var runCodeButton = document.getElementById("run-code");
  runCodeButton.onClick.listen((event) => saveAndRunCode());
}

void saveAndRunCode(){
  String _codeContentFileURI;
  window.requestFileSystem(1024*1024).then((FileSystem filesystem){
    window.console.log("Access to file system granted");
    filesystem.root.createFile('source.txt', exclusive: false).then((FileEntry fileEntry) {
      fileEntry.createWriter().then((FileWriter fileWriter){
        _writeContentToFile(fileWriter);
        _codeContentFileURI = fileEntry.toUrl();
        window.console.log("Running content of $_codeContentFileURI");
        var sendPort = spawnUri(_codeContentFileURI);
//        sendPort.call(getPluginMetadata).then((reply) {print(reply);});
      });
    });
  });  
}

void _writeContentToFile(FileWriter fileWriter){
    window.console.log("Writing content to file");
    var aFileParts = [document.getElementById("code-editor").text];
    Blob blob = new Blob(aFileParts);
    fileWriter.write(blob);
}
