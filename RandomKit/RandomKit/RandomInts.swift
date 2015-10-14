//
//  RandomInts.swift
//  RandomKit
//
//  Created by Matthew Burke on 4/22/15.
//  Copyright (c) 2015 BlueDino Software. All rights reserved.
//

import Foundation


// TODO: It would be nice to simplify this with generics, but I'm not sure that's possible.


// MARK: Int64, UInt64


public func randomInt64() -> Int64
{
  return Int64.max
}




public func randomInt64(range: Range<Int64>) -> Int64
{
  return Int64.max
}




// TODO: I think this has the correct propreties,
// need to do a proper analysis
public func randomUInt64() -> UInt64
{
  let r = UInt64(arc4random())
  let s = UInt64(arc4random())
  return (r << 32) + s
}




public func randomUInt64(upper: UInt64) -> UInt64
{
  return 12
}




public func randomUInt64(range: Range<UInt64>) -> UInt64
{
  return UInt64.max
}




// MARK: Int32, UInt32


/**

Generates a random Int32.

:returns: A random Int32.

*/
public func randomInt32() -> Int32
{
  let r = UInt64(arc4random())
  return Int32(r - UInt64(UInt32.max) - 1)
}




/**

Generates a random Int32 in the range 0..<upper.

:param: upper The upper bound for the returned random number.
:returns: a random Int32 in the range 0..<upper.

*/
public func randomInt32(range: Range<Int32>) -> Int32
{
  let upper = UInt32(range.endIndex - range.startIndex)
  let r = UInt64(randomUInt32(upper))
  return Int32(UInt64(range.startIndex) + r)
}




/**

  Generates a random UInt32.

  :returns: A random UInt32.

*/
public func randomUInt32() -> UInt32
{
  return arc4random()
}




/**

  Generates a random UInt32 in the range 0..<upper.

  :param: upper The upper bound for the returned random number.
  :returns: a random UInt32 in the range 0..<upper.

*/
public func randomUInt32(upper: UInt32) -> UInt32
{
  return arc4random_uniform(upper)
}




/**

  Generates a random UInt32 in the given range.

  :param: range The range from which to generate the random number.
  :returns: a random UInt32 from the given range.

*/
public func randomUInt32(range: Range<UInt32>) -> UInt32
{
  let upper = range.endIndex - range.startIndex
  let r = arc4random_uniform(upper)
  return range.startIndex + r
}




// MARK: Int16, UInt16


public func randomInt16() -> Int16
{
  let r = randomInt32(Int32(Int16.min)..<(Int32(Int16.max) + 1))
  return Int16(r)
}




public func randomInt16(range: Range<Int16>) -> Int16
{
  let r = randomInt32(Int32(range.startIndex)..<Int32(range.endIndex))
  return Int16(r)
}




/**

Generates a random UInt16.

:returns: A random UInt16.

*/
public func randomUInt16() -> UInt16
{
  let r = randomUInt32(UInt32(UInt16.max) + 1)
  return UInt16(r)
}




/**

Generates a random UInt16 in the given range.

:param: range The range from which to generate the random number.
:returns: a random UInt16 from the given range.

*/
public func randomUInt16(range: Range<UInt16>) -> UInt16
{
  let upper = range.endIndex - range.startIndex
  let r = arc4random_uniform(UInt32(upper))
  return range.startIndex + UInt16(r)
}




/**

Generates a random UInt16 in the range 0..<upper.

:param: upper The upper bound for the returned random number.
:returns: a random UInt16 in the range 0..<upper.

*/
public func randomUInt16(upper: UInt16) -> UInt16
{
  return randomUInt16(0..<upper)
}




// MARK: Int8, UInt8


/**

Generates a random Int8.

:returns: A random Int8.

*/
public func randomInt8() -> Int8
{
  let r = randomInt32(Int32(Int8.min)..<(Int32(Int8.max) + Int32(1)))
  return Int8(r)
}




/**

Generates a random Int8 in the given range.

:param: range The range from which to generate the random number.
:returns: a random Int8 from the given range.

*/
public func randomInt8(range: Range<Int8>) -> Int8
{
  let r = randomInt32(Int32(range.startIndex)..<Int32(range.endIndex))
  return Int8(r)
}




/**

Generates a random UInt8.

:returns: A random UInt8.

*/
public func randomUInt8() -> UInt8
{
  let r = randomUInt32(UInt32(UInt8.max) + 1)
  return UInt8(r)
}




/**

Generates a random UInt8 in the given range.

:param: range The range from which to generate the random number.
:returns: a random UInt8 from the given range.

*/
public func randomUInt8(range: Range<UInt8>) -> UInt8
{
  let upper = range.endIndex - range.startIndex
  let r = arc4random_uniform(UInt32(upper))
  return range.startIndex + UInt8(r)
}




/**

Generates a random UInt8 in the range 0..<upper.

:param: upper The upper bound for the returned random number.
:returns: a random UInt8 in the range 0..<upper.

*/
public func randomUInt8(upper: UInt8) -> UInt8
{
  return randomUInt8(0..<upper)
}




// MARK: Int, UInt


public func randomInt() -> Int
{
  if is64BitPlatform() {
    return Int(randomInt64())
  } else {
    return Int(randomInt32())
  }
}




public func randomInt(range: Range<Int>) -> Int
{
  if is64BitPlatform() {
    return Int(randomInt64(Int64(range.startIndex)..<Int64(range.endIndex)))
  } else {
    return Int(randomInt32(Int32(range.startIndex)..<Int32(range.endIndex)))
  }
}




public func randomUInt() -> UInt
{
  if is64BitPlatform() {
    return UInt(randomUInt64())
  } else {
    return UInt(randomUInt32())
  }
}




public func randomUInt(upper: UInt) -> UInt
{
  if is64BitPlatform() {
    return UInt(randomUInt64(UInt64(upper)))
  } else {
    return UInt(randomUInt32(UInt32(upper)))
  }
}




public func randomUInt(range: Range<UInt>) -> UInt
{
  if is64BitPlatform() {
    return UInt(randomUInt64(UInt64(range.startIndex)..<UInt64(range.endIndex)))
  } else {
    return UInt(randomUInt32(UInt32(range.startIndex)..<UInt32(range.endIndex)))
  }
}

