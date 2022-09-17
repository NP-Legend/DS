/// Palindrome.swift
/// Nikunj Prajapati
/// ================

// Given a string, determine whether any permutation of it is a palindrome. 
// For example, "abcdcba" should return true, since it can be reversed and still spell "abcdcba". 
// "abcdefg" should return false, since there's no rearrangement that can form a palindrome. 
// (Hint: In order to be a palindrome, the word, phrase, or sequence has to read the same backward as it does forward)

import Foundation

// Solution 1
/// Simple: word == String(word.reversed())
func checkPalindrome(_ word: String) -> Bool {
    let wordOne = word.lowercased() /// this might not be there becuse it ignor chat and test case failed
    let wordTwo = String(wordOne.reversed())
    
    if !word.isEmpty() && wordOne == wordTwo {
        return true
    } else {
        return false
    }
}

// Solution 2
// Range | .. opeartor
extension String {
    var length: Int { return characters.count }

    subscript(index: Int) -> Character {
        return self[startIndex.advancedBy(index)]
    }

    subscript(range: Range<Int>) -> String {
        return self[Range<Index>(start: startIndex.advancedBy(range.startIndex), end: startIndex.advancedBy(range.endIndex))]
    }
}

func checkPalindrome(word: String) -> Bool {
    if word.length < 2 {
        return true
    } 

    if word.characters.first != word.characters.last {
        return false
    }

    return checkPalindrome(word[1..<word.length - 1])
}

/// Solution 3
func palindrome(string: String)-> Bool{
    let char = Array(string)
    for i in 0..<char.count / 2 {
        if char[i] != char[char.count - 1 - i] {
            return false
        }
    }
    return true
}

/// This solution is not recursive,
/// but it is a O(n) pure index based solution without filtering anything and without creating new objects. 
/// Non-letter characters are ignored as well.
/// It uses two indexes and walks outside in from both sides.

extension StringProtocol where Self: RangeReplaceableCollection {
    var isPalindrome : Bool {
        if isEmpty { return false }
        if index(after: startIndex) == endIndex { return true }
        var forward = startIndex
        var backward = endIndex
        while forward < backward {
            repeat { formIndex(before: &backward) } while !self[backward].isLetter
            if self[forward].lowercased() != self[backward].lowercased() { return false }
            repeat { formIndex(after: &forward) } while !self[forward].isLetter
        }
        return true
    }
}
