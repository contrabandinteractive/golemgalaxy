import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ja'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? jaText = '',
  }) =>
      [enText, jaText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // CreateAccount
  {
    '0m6jvrti': {
      'en': 'Create an account',
      'ja': 'アカウントを作成する',
    },
    '8bvp35xg': {
      'en': 'Let\'s get started by filling out the form below.',
      'ja': '以下のフォームに記入して始めましょう。',
    },
    '5yke0qcb': {
      'en': 'Email',
      'ja': 'Eメール',
    },
    'bdi0250q': {
      'en': 'Password',
      'ja': 'パスワード',
    },
    't06xv8vz': {
      'en': 'Confirm Password',
      'ja': 'パスワードを認証する',
    },
    '4ajhfrls': {
      'en': 'Create Account',
      'ja': 'アカウントを作成する',
    },
    'jbfttdjp': {
      'en': 'Already have an account? ',
      'ja': 'すでにアカウントをお持ちですか？',
    },
    'aeabtz2o': {
      'en': 'Sign In here',
      'ja': 'ここからサインインしてください',
    },
    'a0grpu2x': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // Summon
  {
    'b6ujqigr': {
      'en': 'Forge a Golem',
      'ja': 'ゴーレムを鍛造する',
    },
    'k1ov14d7': {
      'en': 'Choose an Element: Wind, Solar, Water, Fire or Earth.',
      'ja': '要素を選択します: 風、太陽、水、火、土。',
    },
    'x5gslp72': {
      'en': 'Golem Galaxy',
      'ja': 'ゴーレムギャラクシー',
    },
    'bt4ofqi8': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // Generating
  {
    'a0jqqfum': {
      'en': 'Your golem is being summoned...',
      'ja': 'あなたのゴーレムが召喚されています...',
    },
    'd4zp66m4': {
      'en': 'Please wait a moment.',
      'ja': 'しばらくお待ちください。',
    },
    '2kxqvet9': {
      'en': 'Floracandia Luminastra!',
      'ja': 'フロラカンディア ルミナストラ！',
    },
    '1hhckbw8': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // NameGolem
  {
    'yxy158g2': {
      'en': 'What would you like to call your Golem?',
      'ja': 'あなたのゴーレムを何と呼びたいですか?',
    },
    '306p0ud0': {
      'en': 'Enter a Name...',
      'ja': '名前を入力してください...',
    },
    '8ksnitkb': {
      'en': 'Random Name',
      'ja': 'ランダムな名前',
    },
    'w75v7rjp': {
      'en': 'Go',
      'ja': '行く',
    },
    's497i1em': {
      'en': 'Golem Summoned!',
      'ja': 'ゴーレム召喚！',
    },
    'g1zbzom7': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // Dashboard
  {
    '648zbyld': {
      'en': 'Simulate Step!',
      'ja': 'ステップをシミュレート!',
    },
    'lblhdrlp': {
      'en': 'Strength',
      'ja': '強さ',
    },
    'k51sk0f4': {
      'en': 'Trade',
      'ja': '貿易',
    },
    '33l5u21j': {
      'en': 'Offer Sacrifice',
      'ja': '犠牲を捧げる',
    },
    'xvedrbkn': {
      'en': 'Eco Tips',
      'ja': 'エコのヒント',
    },
    'kvrz2ym5': {
      'en': 'Info',
      'ja': '情報',
    },
    'pbj4jpvg': {
      'en': 'Logout',
      'ja': 'ログアウト',
    },
    'r1b59id9': {
      'en': 'Golem Galaxy',
      'ja': 'ゴーレムギャラクシー',
    },
    '0y0qrar2': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // Trade
  {
    '4atc2sfw': {
      'en': 'Here, you can trade Golems using Google Wallet.',
      'ja': 'ここでは、Google ウォレットを使用してゴーレムを取引できます。',
    },
    '7fypldv0': {
      'en':
          'Tap the button below to generate a pass that will allow you to swap golems with other users.',
      'ja': '下のボタンをタップして、他のユーザーとゴーレムを交換できるパスを生成します。',
    },
    'anclirr3': {
      'en': 'Generate Golem Pass',
      'ja': 'ゴーレムパスを生成する',
    },
    '4vuz9tch': {
      'en': 'Powered by',
      'ja': '搭載',
    },
    '2h7003pm': {
      'en': 'Trade',
      'ja': '貿易',
    },
    'd9aq5qia': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // Sacrifice
  {
    '76haud1p': {
      'en':
          'Did you know? You can \"offer sacrifices\" to your golem by scanning bar codes of recyclable items using your phone\'s camera as a scanner. The more items you recycle, the stronger your golem becomes.',
      'ja':
          '知っていましたか？携帯電話のカメラをスキャナーとして使用してリサイクル可能なアイテムのバーコードをスキャンすることで、ゴーレムに「生贄を捧げる」ことができます。アイテムをリサイクルすればするほど、ゴーレムは強くなります。',
    },
    'b36ulv1e': {
      'en': 'Scan Bar Code',
      'ja': 'バーコードをスキャンします',
    },
    'qoedc40m': {
      'en': 'Cancel',
      'ja': 'キャンセル',
    },
    'd6xldi0w': {
      'en': 'Offer Sacrifice',
      'ja': '犠牲を捧げる',
    },
    'vwnlqz99': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // Login
  {
    '193eza29': {
      'en': 'Welcome Back',
      'ja': 'おかえり',
    },
    'lqhdsi1q': {
      'en': 'Let\'s get started by filling out the form below.',
      'ja': '以下のフォームに記入して始めましょう。',
    },
    'hutt0z78': {
      'en': 'Email',
      'ja': 'Eメール',
    },
    'i05eb1ox': {
      'en': 'Password',
      'ja': 'パスワード',
    },
    '66xy1umf': {
      'en': 'Sign In',
      'ja': 'サインイン',
    },
    'he425io9': {
      'en': 'Don\'t have an account? ',
      'ja': 'アカウントをお持ちでない場合は、',
    },
    'lmi0d3kx': {
      'en': ' Sign Up here',
      'ja': 'ここからサインアップしてください',
    },
    'e1d4iiqm': {
      'en': 'Home',
      'ja': '家',
    },
  },
  // Miscellaneous
  {
    'vaxl5c8h': {
      'en': '',
      'ja': '',
    },
    'm71avpa7': {
      'en': '',
      'ja': '',
    },
    'ah9f359d': {
      'en': '',
      'ja': '',
    },
    'mgqngmur': {
      'en': '',
      'ja': '',
    },
    'c2335qo8': {
      'en': '',
      'ja': '',
    },
    'u0n9n4uf': {
      'en': '',
      'ja': '',
    },
    'crygx0y2': {
      'en': '',
      'ja': '',
    },
    'ns4x6jl3': {
      'en': '',
      'ja': '',
    },
    'ztna25za': {
      'en': '',
      'ja': '',
    },
    'sc8t8c3a': {
      'en': '',
      'ja': '',
    },
    'jl2iw6bq': {
      'en': '',
      'ja': '',
    },
    'xpe0ph3h': {
      'en': '',
      'ja': '',
    },
    'ld3v1wvc': {
      'en': '',
      'ja': '',
    },
    'pv2nax09': {
      'en': '',
      'ja': '',
    },
    '25hr5167': {
      'en': '',
      'ja': '',
    },
    'on3tnljw': {
      'en': '',
      'ja': '',
    },
    'sextbu65': {
      'en': '',
      'ja': '',
    },
    'vd1uz17a': {
      'en': '',
      'ja': '',
    },
    'sbl25t3x': {
      'en': '',
      'ja': '',
    },
    'vyvdy0w9': {
      'en': '',
      'ja': '',
    },
    'sm485z4v': {
      'en': '',
      'ja': '',
    },
    'ft606qk5': {
      'en': '',
      'ja': '',
    },
    'u8vc0twy': {
      'en': '',
      'ja': '',
    },
    'ab1zoi8a': {
      'en': '',
      'ja': '',
    },
    'ce8cpqq2': {
      'en': '',
      'ja': '',
    },
    'f4bacuuw': {
      'en': '',
      'ja': '',
    },
  },
].reduce((a, b) => a..addAll(b));
