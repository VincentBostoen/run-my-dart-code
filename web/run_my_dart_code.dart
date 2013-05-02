import 'dart:html';
import 'dart:async';
import 'dart:collection';

void main() {
  window.requestFileSystem(1024*1024).then((FileSystem filesystem){
    window.console.log("Access to file system granted");
    filesystem.root.createFile('test.txt', exclusive: false).then((FileEntry fileEntry) {
      fileEntry.createWriter().then(_writeContentToFile);
    });
  });
}

void _writeContentToFile(FileWriter fileWriter){
    window.console.log("Writing content to file");
    var aFileParts = ["This is my file content !"];
    Blob blob = new Blob(aFileParts);
    
    fileWriter.write(blob);
}

void _handleError(FileError e) {
  var msg = '';
  switch (e.code) {
    case FileError.QUOTA_EXCEEDED_ERR:
      msg = 'QUOTA_EXCEEDED_ERR';
      break;
    case FileError.NOT_FOUND_ERR:
      msg = 'NOT_FOUND_ERR';
      break;
    case FileError.SECURITY_ERR:
      msg = 'SECURITY_ERR';
      break;
    case FileError.INVALID_MODIFICATION_ERR:
      msg = 'INVALID_MODIFICATION_ERR';
      break;
    case FileError.INVALID_STATE_ERR:
      msg = 'INVALID_STATE_ERR';
      break;
    default:
      msg = 'Unknown Error';
      break;
  }
}