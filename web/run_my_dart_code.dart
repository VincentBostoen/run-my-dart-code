import 'dart:html';

void main() {
  window.requestFileSystem(1024*1024).then((FileSystem) => _requestFileSystemCallback);
}

void _requestFileSystemCallback(FileSystem filesystem) {
  FileSystem _filesystem = filesystem;
  
  _filesystem.root.getFile('test.txt',options: {'create': true, 'exclusive': true}, successCallback: (FileEntry fileEntry) {
        fileEntry.createWriter((FileWriter fileWriter) {
          fileWriter.onError.listen(_handleError);
          
          var aFileParts = ["This is my file content"];
          Blob blob = new Blob(aFileParts, { "type" : "text\/xml" });
          
          fileWriter.write(blob);
        }, _handleError);
      },errorCallback: _handleError);
  
  _filesystem.root.getFile('test.txt',options: {'create': true, 'exclusive': true}, successCallback: (FileEntry fileEntry) {
    window.alert(fileEntry.toUrl());
  },  errorCallback: _handleError);
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