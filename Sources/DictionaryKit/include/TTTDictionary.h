// TTTDictionary.h
//
// Copyright (c) 2014 Mattt Thompson
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

@interface TTTDictionaryEntry : NSObject

@property (readonly, nonatomic, copy, nullable) NSString *headword;
@property (readonly, nonatomic, copy, nullable) NSString *text;
@property (readonly, nonatomic, copy, nullable) NSString *HTML;

@end

#pragma mark -

@interface TTTDictionary : NSObject

@property (readonly, nonatomic, copy, nullable) NSString *identifier;
@property (readonly, nonatomic, copy, nullable) NSString *name;
@property (readonly, nonatomic, copy, nullable) NSString *shortName;
@property (readonly, nonatomic, copy, nullable) NSString *primaryLanguage;

+ (nonnull NSSet<TTTDictionary *> *)availableDictionaries;
+ (nullable instancetype)dictionaryNamed:(nonnull NSString *)name;
- (nonnull NSArray<TTTDictionaryEntry *> *)entriesForSearchTerm:(nonnull NSString *)term;
- (BOOL)containsSearchTerm:(nonnull NSString *)term NS_SWIFT_NAME(contains(searchTerm:));

@end

/// @name Constants

extern NSString * const _Nonnull DCSAppleDictionaryName;
extern NSString * const _Nonnull DCSDutchDictionaryName;
extern NSString * const _Nonnull DCSFrenchDictionaryName;
extern NSString * const _Nonnull DCSGermanDictionaryName;
extern NSString * const _Nonnull DCSItalianDictionaryName;
extern NSString * const _Nonnull DCSJapaneseDictionaryName;
extern NSString * const _Nonnull DCSJapaneseSupaDaijirinDictionaryName;
extern NSString * const _Nonnull DCSJapanese_EnglishDictionaryName;
extern NSString * const _Nonnull DCSKoreanDictionaryName;
extern NSString * const _Nonnull DCSKorean_EnglishDictionaryName;
extern NSString * const _Nonnull DCSNewOxfordAmericanDictionaryName;
extern NSString * const _Nonnull DCSOxfordAmericanWritersThesaurus;
extern NSString * const _Nonnull DCSOxfordDictionaryOfEnglish;
extern NSString * const _Nonnull DCSOxfordThesaurusOfEnglish;
extern NSString * const _Nonnull DCSSimplifiedChineseDictionaryName;
extern NSString * const _Nonnull DCSSimplifiedChinese_EnglishDictionaryName;
extern NSString * const _Nonnull DCSSpanishDictionaryName;
extern NSString * const _Nonnull DCSWikipediaDictionaryName;
