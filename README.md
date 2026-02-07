# DictionaryKit

**An Objective-C Wrapper for _Private_ Dictionary Services on Mac OS X**

> This library accesses private OS X APIs, making it unsuitable for apps submitted to the App Store.

## Modifications

This is a fork of the original [DictionaryKit](https://github.com/NSHipster/DictionaryKit). Here's a list of some notable things that have changed:
 - Added/modified type information for a better Swift interop experience
 - Swapped the API to use dictionary identifiers instead of names
 - Added some additional QOL methods for making certain tasks easier/faster

## Usage

```objective-c
#import "DictionaryKit.h"

TTTDictionary *dictionary = [TTTDictionary dictionaryWithIdentifier:DCSDictionaryApple];
NSLog(@"%@\n", dictionary.name);

NSString *term = @"apple";
for (TTTDictionaryEntry *entry in [dictionary entriesForSearchTerm:term]) {
    NSLog(@"%@", entry.text);
}
```

## Available Dictionaries
These are the known dictionary options, which may or may not be available on all systems.

| Constant                                          | Identifier                                | Name                                                                               |
| ------------------------------------------------- | ----------------------------------------- | ---------------------------------------------------------------------------------- |
| `DCSDictionaryNewOxfordAmerican`                  | `com.apple.dictionary.NOAD`               | New Oxford American Dictionary                                                     |
| `DCSDictionaryPrismaDutch`                        | `com.apple.dictionary.nl.Prisma`          | Prisma woordenboek Nederlands                                                      |
| `DCSDictionaryOxfordRussian`                      | `com.apple.dictionary.ru.oup`             | Толковый словарь русского языка                                                    |
| `DCSDictionaryWisdomJapaneseEnglish`              | `com.apple.dictionary.ja-en.WISDOM`       | ウィズダム英和辞典 / ウィズダム和英辞典                                                   |
| `DCSDictionaryOxfordUkrainianEnglish`             | `com.apple.dictionary.uk-en.oup`          | Українсько-Англійський Словник                                                     |
| `DCSDictionaryOxfordRussianEnglish`               | `com.apple.dictionary.OxfordRussian`      | Oxford Russian Dictionary - Русско-Английский • Англо-Русский                      |
| `DCSDictionaryOxfordPortugueseEnglish`            | `com.apple.dictionary.pt-en.oup`          | Oxford Portuguese Dictionary - Português-Inglês • Inglês-Português                 |
| `DCSDictionaryOxfordAmericanWritersThesaurus`     | `com.apple.dictionary.OAWT`               | Oxford American Writer’s Thesaurus                                                 |
| `DCSDictionaryNationalencyklopedinEnglishSwedish` | `com.apple.dictionary.sv-en.oup`          | NE Nationalencyklopedin AB Professional English-Swedish / Svensk-Engelska          |
| `DCSDictionaryOxfordPunjabiEnglish`               | `com.apple.dictionary.pa-en.oup`          | Oxford Punjabi Dictionaries - ਪੰਜਾਬੀ ਅੰਗਰੇਜ਼ੀ ਕੋਸ਼ • پنجابی انگریزی لغت                    |
| `DCSDictionaryOxfordPolishEnglish`                | `com.apple.dictionary.pl-en.oup`          | Oxford PWN Polish-English Dictionary / Wielki słownik polsko-angielski             |
| `DCSDictionaryOxfordArabicEnglish`                | `com.apple.dictionary.ar-en.oup`          | Oxford Arabic Dictionary - عربي-إنجليزي • إنجليزي-عربي                             |
| `DCSDictionaryOxfordItalian`                      | `com.apple.dictionary.OxfordItalian`      | Oxford Paravia Il Dizionario inglese - italiano/italiano - inglese                 |
| `DCSDictionaryLacVietVietnamese`                  | `com.apple.dictionary.vi-en.oup`          | Từ điển Lạc Việt                                                                   |
| `DCSDictionaryOxfordKazakhEnglish`                | `com.apple.dictionary.kk-en.oup`          | Оксфорд Қазақ Cөздігі                                                              |
| `DCSDictionaryDaijirinJapanese`                   | `com.apple.dictionary.ja.Daijirin`        | スーパー大辞林                                                                        |
| `DCSDictionaryOxfordThaiEnglish`                  | `com.apple.dictionary.th-en.oup`          | พจนานุกรมอังกฤษ-ไทย & ไทย-อังกฤษ ฉบับทันสมัยและสมบูรณ์ที่สุด                                   |
| `DCSDictionaryDevotoOliItalian`                   | `com.apple.dictionary.it.Devoto-Oli`      | Dizionario italiano da un affiliato di Oxford University Press                     |
| `DCSDictionaryMultidictionnaireFrench`            | `com.apple.dictionary.fr.Multi`           | Multidictionnaire de la langue française                                           |
| `DCSDictionaryOxfordGreekEnglish`                 | `com.apple.dictionary.el-en.oup`          | Stavropoulos Oxford Greek-English Learners Dictionary                              |
| `DCSDictionaryArkadasTurkish`                     | `com.apple.dictionary.tr.oup`             | Arkadaş Türkçe Sözlük                                                              |
| `DCSDictionaryOxfordCroatianEnglish`              | `com.apple.dictionary.hr-en.oup`          | Praktický Anglicko-Chorvatský Slovník                                              |
| `DCSDictionaryOxfordMalay`                        | `com.apple.dictionary.ms.oup`             | Kamus Komprehensif Bahasa Melayu - Malay Monolingual Dictionary, Oxford Fajar      |
| `DCSDictionaryHongKongChinese`                    | `com.apple.dictionary.zh_HK.common`       | 商務新詞典（全新版）                                                                  |
| `DCSDictionaryChineseIdioms`                      | `com.apple.dictionary.zh_CN.idioms`       | 汉语成语词典                                                                         |
| `DCSDictionaryPonsFrenchGerman`                   | `com.apple.dictionary.fr-de.oup`          | PONS Großwörterbuch Französisch Deutsch                                            |
| `DCSDictionaryOxfordMalayEnglish`                 | `com.apple.dictionary.ms-en.oup`          | Kamus Dwibahasa Melayu/Inggeris - English/Malay Bilingual Dictionary, Oxford Fajar |
| `DCSDictionaryOxfordDanishEnglish`                | `com.apple.dictionary.da-en.oup`          | Praktisk Engelsk-Dansk Ordbog                                                      |
| `DCSDictionaryChineseThesaurus`                   | `com.apple.dictionary.zh_CN.thes`         | 现代汉语同义词典                                                                      |
| `DCSDictionaryLarousseSpanish`                    | `com.apple.dictionary.es.DGLEV`           | Larousse Editorial Diccionario General de la Lengua Española                       |
| `DCSDictionaryOxfordBulgarian`                    | `com.apple.dictionary.bg.oup`             | Тълковен речник на съвременния български език                                      |
| `DCSDictionaryOxfordIndonesianEnglish`            | `com.apple.dictionary.id-en.oup`          | Oxford Study Indonesian Dictionary - Inggris-Indonesia • Indonesia-Inggris         |
| `DCSDictionaryOxfordBengaliEnglish`               | `com.apple.dictionary.bn-en.oup`          | Oxford Bengali Dictionaries - বাংলা-ইংরেজি • ইংরেজি-বাংলা                               |
| `DCSDictionaryOxfordHungarianEnglish`             | `com.apple.dictionary.hu-en.oup`          | Magay Tamás szótár - Magyar-Angol • Angol-Magyar                                   |
| `DCSDictionaryMotFinnishEnglish`                  | `com.apple.dictionary.fi-en.oup`          | MOT sanakirja suomi-englanti, englanti-suomi                                       |
| `DCSDictionaryNationalencyklopedinSwedish`        | `com.apple.dictionary.sv.oup`             | NE Ordbok                                                                          |
| `DCSDictionaryCantoneseEnglish`                   | `com.apple.dictionary.yue-en.cp`          | 英譯廣東口語詞典                                                                      |
| `DCSDictionaryModernGreek`                        | `com.apple.dictionary.el.oup`             | Λεξικό της κοινής νεοελληνικής                                                     |
| `DCSDictionaryOxfordCzechEnglish`                 | `com.apple.dictionary.cs-en.oup`          | Velký anglicko-český a česko-anglický slovník                                      |
| `DCSDictionaryWikipedia`                          | `com.apple.dictionary.Wikipedia`          | Wikipedia                                                                          |
| `DCSDictionaryOxfordTurkishEnglish`               | `com.apple.dictionary.tr-en.oup`          | Oxford Turkish Dictionary - Türkçe-İngilizce • İngilizce-Türkçe                    |
| `DCSDictionaryModernChinese`                      | `com.apple.dictionary.zh_CN.SDCC`         | 现代汉语规范词典                                                                      |
| `DCSDictionaryOxfordCantoneseEnglish`             | `com.apple.dictionary.yue-en.oup`         | 牛津粵英雙語詞典                                                                      |
| `DCSDictionaryDudenGerman`                        | `com.apple.dictionary.de.DDDSI`           | Duden-Wissensnetz deutsche Sprache                                                 |
| `DCSDictionaryOxfordTamilEnglish`                 | `com.apple.dictionary.ta-en.oup`          | Oxford Tamil Dictionaries - தமிழ்-ஆங்கிலம் • ஆங்கிலம்-தமிழ்                             |
| `DCSDictionaryHongKongChineseEnglishIdioms`       | `com.apple.dictionary.zh_HK-en.idioms.cp` | 漢英對照成語詞典                                                                      |
| `DCSDictionaryLarousseCatalan`                    | `com.apple.dictionary.ca.oup`             | Larousse Editorial Diccionari Manual de la llengua catalana                        |
| `DCSDictionaryOxfordDictionaryOfEnglish`          | `com.apple.dictionary.ODE`                | Oxford Dictionary of English                                                       |
| `DCSDictionaryOxfordMalayalamEnglish`             | `com.apple.dictionary.ml-en.oup`          | Oxford Malayalam Dictionaries - മലയാളം-ഇംഗ്ലീഷ് • ഇംഗ്ലീഷ്-മലയാളം                       |
| `DCSDictionaryOxfordKannadaEnglish`               | `com.apple.dictionary.kn-en.oup`          | Oxford Kannada Dictionaries - ಇಂಗ್ಲಿಷ್-ಕನ್ನಡ • ಕನ್ನಡ-ಇಂಗ್ಲಿಷ್                               |
| `DCSDictionaryApple`                              | `com.apple.dictionary.AppleDictionary`    | Apple Dictionary                                                                   |
| `DCSDictionaryOxfordSlovakEnglish`                | `com.apple.dictionary.sk-en.oup`          | Veľký Anglicko-Slovenský Slovník                                                   |
| `DCSDictionaryTaiwaneseChinese`                   | `com.apple.dictionary.zh_TW.wn`           | 五南國語活用辭典                                                                      |
| `DCSDictionaryOxfordUrduEnglish`                  | `com.apple.dictionary.ur-en.oup`          | Oxford Urdu Dictionaries - اردو۔انگریزی • انگریزی-اردو                             |
| `DCSDictionaryOxfordTeluguEnglish`                | `com.apple.dictionary.te-en.oup`          | Oxford Telugu Dictionaries - తెలుగు-ఇంగ్లీష్ • ఇంగ్లీష్-తెలుగు                              |
| `DCSDictionaryRajpalHindi`                        | `com.apple.dictionary.hi.oup`             | राजपाल हिन्दी शब्दकोश                                                                   |
| `DCSDictionaryNorwegian`                          | `com.apple.dictionary.no.oup`             | Norsk Ordbok                                                                       |
| `DCSDictionaryOxfordHindiEnglish`                 | `com.apple.dictionary.hi-en.oup`          | Oxford Hindi Dictionaries - हिन्दी-अंग्रेज़ी • अंग्रेज़ी-हिन्दी                                    |
| `DCSDictionaryThai`                               | `com.apple.dictionary.th.oup`             | พจนานุกรมไทย ฉบับทันสมัยและสมบูรณ์                                                       |
| `DCSDictionaryCrownChineseJapanese`               | `com.apple.dictionary.zhs-ja.Crown`       | 超級クラウン中日辞典 / クラウン日中辞典                                                  |
| `DCSDictionaryPolish`                             | `com.apple.dictionary.pl.oup`             | Uniwersalny słownik języka polskiego                                               |
| `DCSDictionaryOxfordGerman`                       | `com.apple.dictionary.OxfordGerman`       | Oxford German Dictionary                                                           |
| `DCSDictionaryOxfordChineseEnglish`               | `com.apple.dictionary.zh_CN-en.OCD`       | 牛津英汉汉英词典                                                                      |
| `DCSDictionaryDanish`                             | `com.apple.dictionary.da.oup`             | Politikens Nudansk Ordbog                                                          |
| `DCSDictionaryRomanian`                           | `com.apple.dictionary.ro.oup`             | Dicţionarul explicativ al limbii române                                            |
| `DCSDictionaryOxfordFrench`                       | `com.apple.dictionary.OxfordFrench`       | Oxford-Hachette French Dictionary                                                  |
| `DCSDictionaryPrismaEnglish`                      | `com.apple.dictionary.nl-en.oup`          | Prisma Handwoordenboek Engels                                                      |
| `DCSDictionaryDrEyeChineseEnglish`                | `com.apple.dictionary.zh_TW-en.DrEye`     | 譯典通英漢雙向字典                                                                    |
| `DCSDictionaryCroatian`                           | `com.apple.dictionary.hr.oup`             | Hrvatski Enciklopedijski Rječnik                                                   |
| `DCSDictionaryNorwegianEnglish`                   | `com.apple.dictionary.no-en.oup`          | Engelsk Ordbok                                                                     |
| `DCSDictionaryEvenShoshanHebrew`                  | `com.apple.dictionary.he.oup`             | מילון אבן-שושן מחודש ומותאם לשנות האלפיים                                          |
| `DCSDictionaryNewAceKorean`                       | `com.apple.dictionary.ko.NewAce`          | 뉴에이스 국어사전                                                                       |
| `DCSDictionaryNewAceKoreanEnglish`                | `com.apple.dictionary.ko-en.NewAce`       | 뉴에이스 영한사전 / 뉴에이스 한영사전                                                       |
| `DCSDictionaryOxfordThesaurusOfEnglish`           | `com.apple.dictionary.OTE`                | Oxford Thesaurus of English                                                        |
| `DCSDictionaryOxfordGujaratiEnglish`              | `com.apple.dictionary.gu-en.oup`          | Oxford Gujarati Dictionaries - ગુજરાતી-અંગ્રેજી • અંગ્રેજી-ગુજરાતી                             |
| `DCSDictionaryTTY`                                | `com.apple.accessibility.dictionary.TTY`  | TTY Dictionary                                                                     |
| `DCSDictionaryOxfordSpanish`                      | `com.apple.dictionary.OxfordSpanish`      | Gran Diccionario Oxford - Español-Inglés • Inglés-Español                          |
| `DCSDictionaryPortuguese`                         | `com.apple.dictionary.pt.oup`             | Dicionário de Português licenciado para Oxford University Press                    |

### Original Author

Mattt ([@mattt](https://twitter.com/mattt))

## License

DictionaryKit is available under the MIT license. See the LICENSE file for more info.
