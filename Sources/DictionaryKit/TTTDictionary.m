// TTTDictionary.m
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

#import "TTTDictionary.h"
#include <CoreFoundation/CFArray.h>
#include <CoreFoundation/CFBase.h>

#import <CoreServices/CoreServices.h>

typedef NS_ENUM(NSInteger, TTTDictionaryRecordVersion) {
    TTTDictionaryVersionHTML = 0,
    TTTDictionaryVersionHTMLWithAppCSS = 1,
    TTTDictionaryVersionHTMLWithPopoverCSS = 2,
    TTTDictionaryVersionText = 3,
};

#pragma mark -

extern CFArrayRef DCSCopyAvailableDictionaries();
extern CFStringRef DCSDictionaryGetName(DCSDictionaryRef dictionary);
extern CFStringRef DCSDictionaryGetShortName(DCSDictionaryRef dictionary);
extern DCSDictionaryRef DCSDictionaryCreate(CFURLRef url);
extern CFStringRef DCSDictionaryGetIdentifier(DCSDictionaryRef dictionary);
extern CFStringRef DCSDictionaryGetPrimaryLanguage(DCSDictionaryRef dictionary);
extern CFArrayRef DCSCopyRecordsForSearchString(DCSDictionaryRef dictionary, CFStringRef string, void *, void *);

extern CFDictionaryRef DCSCopyDefinitionMarkup(DCSDictionaryRef dictionary, CFStringRef record);
extern CFStringRef DCSRecordCopyData(CFTypeRef record, long version);
extern CFStringRef DCSRecordCopyDataURL(CFTypeRef record);
extern CFStringRef DCSRecordGetAnchor(CFTypeRef record);
extern CFStringRef DCSRecordGetAssociatedObj(CFTypeRef record);
extern CFStringRef DCSRecordGetHeadword(CFTypeRef record);
extern CFStringRef DCSRecordGetRawHeadword(CFTypeRef record);
extern CFStringRef DCSRecordGetString(CFTypeRef record);
extern DCSDictionaryRef DCSRecordGetSubDictionary(CFTypeRef record);
extern CFStringRef DCSRecordGetTitle(CFTypeRef record);

#pragma mark -

@interface TTTDictionaryEntry ()
@property (readwrite, nonatomic, copy) NSString *headword;
@property (readwrite, nonatomic, copy) NSString *text;
@property (readwrite, nonatomic, copy) NSString *HTML;
@end

@implementation TTTDictionaryEntry

- (instancetype)initWithRecordRef:(CFTypeRef)record
                    dictionaryRef:(DCSDictionaryRef)dictionary
{
    self = [self init];
    if (!self && record) {
        return nil;
    }

    self.headword = (__bridge NSString *)DCSRecordGetHeadword(record);
    if (self.headword) {
        self.text = (__bridge_transfer NSString*)DCSRecordCopyData(record, TTTDictionaryVersionText);
    }

    self.HTML = (__bridge_transfer NSString *)DCSRecordCopyData(record, (long)TTTDictionaryVersionHTMLWithPopoverCSS);

    return self;
}

@end

@interface TTTDictionary ()
@property (readwrite, nonatomic, assign) DCSDictionaryRef dictionary;
@property (readwrite, nonatomic, copy) NSString *identifier;
@property (readwrite, nonatomic, copy) NSString *name;
@property (readwrite, nonatomic, copy) NSString *shortName;
@property (readwrite, nonatomic, copy) NSString *primaryLanguage;
@end

@implementation TTTDictionary

+ (NSSet *)availableDictionaries {
    static NSSet *_availableDictionaries = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableSet *mutableDictionaries = [NSMutableSet set];
        for (id dictionary in (__bridge_transfer NSArray *)DCSCopyAvailableDictionaries()) {
            [mutableDictionaries addObject:[[TTTDictionary alloc] initWithDictionaryRef:(__bridge DCSDictionaryRef)dictionary]];
        }

        _availableDictionaries = [NSSet setWithSet:mutableDictionaries];
    });

    return _availableDictionaries;
}

+ (instancetype)dictionaryWithIdentifier:(DCSDictionaryIdentifier)identifier {
    static NSDictionary *_availableDictionariesKeyedByIdentifier = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *mutableAvailableDictionariesKeyedByIdentifier = [NSMutableDictionary dictionaryWithCapacity:[[self availableDictionaries] count]];
        for (TTTDictionary *dictionary in [self availableDictionaries]) {
            mutableAvailableDictionariesKeyedByIdentifier[dictionary.identifier] = dictionary;
        }

        _availableDictionariesKeyedByIdentifier = [NSDictionary dictionaryWithDictionary:mutableAvailableDictionariesKeyedByIdentifier];
    });

    return _availableDictionariesKeyedByIdentifier[identifier];
}

- (instancetype)initWithDictionaryRef:(DCSDictionaryRef)dictionary {
    self = [self init];
    if (!self || !dictionary) {
        return nil;
    }

    self.dictionary = dictionary;
    self.identifier = (__bridge NSString *)DCSDictionaryGetIdentifier(self.dictionary);
    self.name = (__bridge NSString *)DCSDictionaryGetName(self.dictionary);
    self.shortName = (__bridge NSString *)DCSDictionaryGetShortName(self.dictionary);
    self.primaryLanguage = (__bridge NSString *)DCSDictionaryGetPrimaryLanguage(self.dictionary);

    return self;
}

- (NSArray *)entriesForSearchTerm:(NSString *)term {
    CFRange termRange = DCSGetTermRangeInString(self.dictionary, (__bridge CFStringRef)term, 0);
    if (termRange.location == kCFNotFound) {
        return @[];
    }

    term = [term substringWithRange:NSMakeRange(termRange.location, termRange.length)];

    NSArray *records = (__bridge_transfer NSArray *)DCSCopyRecordsForSearchString(self.dictionary, (__bridge CFStringRef)term, NULL, NULL);
    if ([records count] == 0) {
        return @[];
    }

    NSMutableArray *mutableEntries = [NSMutableArray arrayWithCapacity:[records count]];
    for (id record in records) {
        TTTDictionaryEntry *entry = [[TTTDictionaryEntry alloc] initWithRecordRef:(__bridge CFTypeRef)record dictionaryRef:self.dictionary];
        if (entry) {
            [mutableEntries addObject:entry];
        }
    }

    return [NSArray arrayWithArray:mutableEntries];
}

- (BOOL)containsSearchTerm:(NSString *)term {
    CFRange termRange = DCSGetTermRangeInString(self.dictionary, (__bridge CFStringRef)term, 0);
    if (termRange.location == kCFNotFound) {
        return NO;
    }

    term = [term substringWithRange:NSMakeRange(termRange.location, termRange.length)];

    CFArrayRef records = DCSCopyRecordsForSearchString(self.dictionary, (__bridge CFStringRef)term, NULL, NULL);
    BOOL hasRecords = records && CFArrayGetCount(records) > 0;

    if (records) {
        CFRelease(records);
    }

    return hasRecords;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[TTTDictionary class]]) {
        return NO;
    }

    return [self.name isEqualToString:[(TTTDictionary *)object name]];
}

- (NSUInteger)hash {
    return [self.name hash];
}

@end

DCSDictionaryIdentifier const DCSDictionaryNewOxfordAmerican =                  @"com.apple.dictionary.NOAD";
DCSDictionaryIdentifier const DCSDictionaryPrismaDutch =                        @"com.apple.dictionary.nl.Prisma";
DCSDictionaryIdentifier const DCSDictionaryOxfordRussian =                      @"com.apple.dictionary.ru.oup";
DCSDictionaryIdentifier const DCSDictionaryWisdomJapaneseEnglish =              @"com.apple.dictionary.ja-en.WISDOM";
DCSDictionaryIdentifier const DCSDictionaryOxfordUkrainianEnglish =             @"com.apple.dictionary.uk-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordRussianEnglish =               @"com.apple.dictionary.OxfordRussian";
DCSDictionaryIdentifier const DCSDictionaryOxfordPortugueseEnglish =            @"com.apple.dictionary.pt-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordAmericanWritersThesaurus =     @"com.apple.dictionary.OAWT";
DCSDictionaryIdentifier const DCSDictionaryNationalencyklopedinEnglishSwedish = @"com.apple.dictionary.sv-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordPunjabiEnglish =               @"com.apple.dictionary.pa-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordPolishEnglish =                @"com.apple.dictionary.pl-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordArabicEnglish =                @"com.apple.dictionary.ar-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordItalian =                      @"com.apple.dictionary.OxfordItalian";
DCSDictionaryIdentifier const DCSDictionaryLacVietVietnamese =                  @"com.apple.dictionary.vi-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordKazakhEnglish =                @"com.apple.dictionary.kk-en.oup";
DCSDictionaryIdentifier const DCSDictionaryDaijirinJapanese =                   @"com.apple.dictionary.ja.Daijirin";
DCSDictionaryIdentifier const DCSDictionaryOxfordThaiEnglish =                  @"com.apple.dictionary.th-en.oup";
DCSDictionaryIdentifier const DCSDictionaryDevotoOliItalian =                   @"com.apple.dictionary.it.Devoto-Oli";
DCSDictionaryIdentifier const DCSDictionaryMultidictionnaireFrench =            @"com.apple.dictionary.fr.Multi";
DCSDictionaryIdentifier const DCSDictionaryOxfordGreekEnglish =                 @"com.apple.dictionary.el-en.oup";
DCSDictionaryIdentifier const DCSDictionaryArkadasTurkish =                     @"com.apple.dictionary.tr.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordCroatianEnglish =              @"com.apple.dictionary.hr-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordMalay =                        @"com.apple.dictionary.ms.oup";
DCSDictionaryIdentifier const DCSDictionaryHongKongChinese =                    @"com.apple.dictionary.zh_HK.common";
DCSDictionaryIdentifier const DCSDictionaryChineseIdioms =                      @"com.apple.dictionary.zh_CN.idioms";
DCSDictionaryIdentifier const DCSDictionaryPonsFrenchGerman =                   @"com.apple.dictionary.fr-de.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordMalayEnglish =                 @"com.apple.dictionary.ms-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordDanishEnglish =                @"com.apple.dictionary.da-en.oup";
DCSDictionaryIdentifier const DCSDictionaryChineseThesaurus =                   @"com.apple.dictionary.zh_CN.thes";
DCSDictionaryIdentifier const DCSDictionaryLarousseSpanish =                    @"com.apple.dictionary.es.DGLEV";
DCSDictionaryIdentifier const DCSDictionaryOxfordBulgarian =                    @"com.apple.dictionary.bg.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordIndonesianEnglish =            @"com.apple.dictionary.id-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordBengaliEnglish =               @"com.apple.dictionary.bn-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordHungarianEnglish =             @"com.apple.dictionary.hu-en.oup";
DCSDictionaryIdentifier const DCSDictionaryMotFinnishEnglish =                  @"com.apple.dictionary.fi-en.oup";
DCSDictionaryIdentifier const DCSDictionaryNationalencyklopedinSwedish =        @"com.apple.dictionary.sv.oup";
DCSDictionaryIdentifier const DCSDictionaryCantoneseEnglish =                   @"com.apple.dictionary.yue-en.cp";
DCSDictionaryIdentifier const DCSDictionaryModernGreek =                        @"com.apple.dictionary.el.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordCzechEnglish =                 @"com.apple.dictionary.cs-en.oup";
DCSDictionaryIdentifier const DCSDictionaryWikipedia =                          @"com.apple.dictionary.Wikipedia";
DCSDictionaryIdentifier const DCSDictionaryOxfordTurkishEnglish =               @"com.apple.dictionary.tr-en.oup";
DCSDictionaryIdentifier const DCSDictionaryModernChinese =                      @"com.apple.dictionary.zh_CN.SDCC";
DCSDictionaryIdentifier const DCSDictionaryOxfordCantoneseEnglish =             @"com.apple.dictionary.yue-en.oup";
DCSDictionaryIdentifier const DCSDictionaryDudenGerman =                        @"com.apple.dictionary.de.DDDSI";
DCSDictionaryIdentifier const DCSDictionaryOxfordTamilEnglish =                 @"com.apple.dictionary.ta-en.oup";
DCSDictionaryIdentifier const DCSDictionaryHongKongChineseEnglishIdioms =       @"com.apple.dictionary.zh_HK-en.idioms.cp";
DCSDictionaryIdentifier const DCSDictionaryLarousseCatalan =                    @"com.apple.dictionary.ca.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordDictionaryOfEnglish =          @"com.apple.dictionary.ODE";
DCSDictionaryIdentifier const DCSDictionaryOxfordMalayalamEnglish =             @"com.apple.dictionary.ml-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordKannadaEnglish =               @"com.apple.dictionary.kn-en.oup";
DCSDictionaryIdentifier const DCSDictionaryApple =                              @"com.apple.dictionary.AppleDictionary";
DCSDictionaryIdentifier const DCSDictionaryOxfordSlovakEnglish =                @"com.apple.dictionary.sk-en.oup";
DCSDictionaryIdentifier const DCSDictionaryTaiwaneseChinese =                   @"com.apple.dictionary.zh_TW.wn";
DCSDictionaryIdentifier const DCSDictionaryOxfordUrduEnglish =                  @"com.apple.dictionary.ur-en.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordTeluguEnglish =                @"com.apple.dictionary.te-en.oup";
DCSDictionaryIdentifier const DCSDictionaryRajpalHindi =                        @"com.apple.dictionary.hi.oup";
DCSDictionaryIdentifier const DCSDictionaryNorwegian =                          @"com.apple.dictionary.no.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordHindiEnglish =                 @"com.apple.dictionary.hi-en.oup";
DCSDictionaryIdentifier const DCSDictionaryThai =                               @"com.apple.dictionary.th.oup";
DCSDictionaryIdentifier const DCSDictionaryCrownChineseJapanese =               @"com.apple.dictionary.zhs-ja.Crown";
DCSDictionaryIdentifier const DCSDictionaryPolish =                             @"com.apple.dictionary.pl.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordGerman =                       @"com.apple.dictionary.OxfordGerman";
DCSDictionaryIdentifier const DCSDictionaryOxfordChineseEnglish =               @"com.apple.dictionary.zh_CN-en.OCD";
DCSDictionaryIdentifier const DCSDictionaryDanish =                             @"com.apple.dictionary.da.oup";
DCSDictionaryIdentifier const DCSDictionaryRomanian =                           @"com.apple.dictionary.ro.oup";
DCSDictionaryIdentifier const DCSDictionaryOxfordFrench =                       @"com.apple.dictionary.OxfordFrench";
DCSDictionaryIdentifier const DCSDictionaryPrismaEnglish =                      @"com.apple.dictionary.nl-en.oup";
DCSDictionaryIdentifier const DCSDictionaryDrEyeChineseEnglish =                @"com.apple.dictionary.zh_TW-en.DrEye";
DCSDictionaryIdentifier const DCSDictionaryCroatian =                           @"com.apple.dictionary.hr.oup";
DCSDictionaryIdentifier const DCSDictionaryNorwegianEnglish =                   @"com.apple.dictionary.no-en.oup";
DCSDictionaryIdentifier const DCSDictionaryEvenShoshanHebrew =                  @"com.apple.dictionary.he.oup";
DCSDictionaryIdentifier const DCSDictionaryNewAceKorean =                       @"com.apple.dictionary.ko.NewAce";
DCSDictionaryIdentifier const DCSDictionaryNewAceKoreanEnglish =                @"com.apple.dictionary.ko-en.NewAce";
DCSDictionaryIdentifier const DCSDictionaryOxfordThesaurusOfEnglish =           @"com.apple.dictionary.OTE";
DCSDictionaryIdentifier const DCSDictionaryOxfordGujaratiEnglish =              @"com.apple.dictionary.gu-en.oup";
DCSDictionaryIdentifier const DCSDictionaryTTY =                                @"com.apple.accessibility.dictionary.TTY";
DCSDictionaryIdentifier const DCSDictionaryOxfordSpanish =                      @"com.apple.dictionary.OxfordSpanish";
DCSDictionaryIdentifier const DCSDictionaryPortuguese =                         @"com.apple.dictionary.pt.oup";
