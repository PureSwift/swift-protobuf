import Foundation

import FuzzCommon

import SwiftProtobuf

@_cdecl("LLVMFuzzerTestOneInput")
public func FuzzJSON(_ start: UnsafeRawPointer, _ count: Int) -> CInt {
  let bytes = UnsafeRawBufferPointer(start: start, count: count)
  var msg: SwiftProtoTesting_Fuzz_Message?
  do {
    msg = try SwiftProtoTesting_Fuzz_Message(
      jsonUTF8Data: Data(bytes),
      extensions: SwiftProtoTesting_Fuzz_FuzzTesting_Extensions)
  } catch {
    // Error parsing are to be expected since not all input will be well formed.
  }
  // Test serialization for completeness.
  // If a message was parsed, it should not fail to serialize, so assert as such.
  let _ = try! msg?.jsonString()
  return 0
}
