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

typedef NSString * DCSDictionaryIdentifier NS_STRING_ENUM;

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
+ (nullable instancetype)dictionaryWithIdentifier:(nonnull DCSDictionaryIdentifier)identifier;
- (nonnull NSArray<TTTDictionaryEntry *> *)entriesForSearchTerm:(nonnull NSString *)term;
- (BOOL)containsSearchTerm:(nonnull NSString *)term NS_SWIFT_NAME(contains(searchTerm:));

@end

extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryNewOxfordAmerican;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryPrismaDutch;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordRussian;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryWisdomJapaneseEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordUkrainianEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordRussianEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordPortugueseEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordAmericanWritersThesaurus;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryNationalencyklopedinEnglishSwedish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordPunjabiEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordPolishEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordArabicEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordItalian;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryLacVietVietnamese;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordKazakhEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryDaijirinJapanese;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordThaiEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryDevotoOliItalian;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryMultidictionnaireFrench;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordGreekEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryArkadasTurkish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordCroatianEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordMalay;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryHongKongChinese;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryChineseIdioms;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryPonsFrenchGerman;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordMalayEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordDanishEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryChineseThesaurus;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryLarousseSpanish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordBulgarian;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordIndonesianEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordBengaliEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordHungarianEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryMotFinnishEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryNationalencyklopedinSwedish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryCantoneseEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryModernGreek;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordCzechEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryWikipedia;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordTurkishEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryModernChinese;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordCantoneseEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryDudenGerman;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordTamilEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryHongKongChineseEnglishIdioms;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryLarousseCatalan;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordDictionaryOfEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordMalayalamEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordKannadaEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryApple;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordSlovakEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryTaiwaneseChinese;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordUrduEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordTeluguEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryRajpalHindi;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryNorwegian;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordHindiEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryThai;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryCrownChineseJapanese;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryPolish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordGerman;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordChineseEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryDanish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryRomanian;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordFrench;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryPrismaEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryDrEyeChineseEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryCroatian;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryNorwegianEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryEvenShoshanHebrew;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryNewAceKorean;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryNewAceKoreanEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordThesaurusOfEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordGujaratiEnglish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryTTY;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryOxfordSpanish;
extern DCSDictionaryIdentifier const _Nonnull DCSDictionaryPortuguese;
