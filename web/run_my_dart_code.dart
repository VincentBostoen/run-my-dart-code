import 'dart:html';
import 'dart:async';
import 'dart:collection';
import 'dart:isolate';

void main() {
  String _codeContentFileURI;
  window.requestFileSystem(1024*1024).then((FileSystem filesystem){
    window.console.log("Access to file system granted");
    filesystem.root.createFile('source.txt', exclusive: false).then((FileEntry fileEntry) {
      fileEntry.createWriter().then((FileWriter fileWriter){
        _writeContentToFile(fileWriter);
        _codeContentFileURI = fileEntry.toUrl();
        window.console.log("Running content of $_codeContentFileURI");
        spawnUri(_codeContentFileURI);
      });
    });
  });
}

void _writeContentToFile(FileWriter fileWriter){
    window.console.log("Writing content to file");
    var aFileParts = ["void main() {print('hello from an isolate!');}"];
    Blob blob = new Blob(aFileParts);
    fileWriter.write(blob);
}
