import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

String? newCustomFunction(String? image) {
  return image;
}

String generateName() {
  List<String> prefixes = [
    'Aero',
    'Aether',
    'Arcane',
    'Celest',
    'Eldri',
    'Fae',
    'Gala',
    'Lumi',
    'Mystra',
    'Nebul',
    'Ora',
    'Pyro',
    'Quasi',
    'Rune',
    'Sylvan',
    'Thal',
    'Vortex',
    'Wraith',
    'Xylo',
    'Zephyr'
  ];
  List<String> suffixes = [
    'dor',
    'felle',
    'gorn',
    'hyme',
    'ion',
    'jor',
    'kell',
    'lyre',
    'mor',
    'nor',
    'phel',
    'quill',
    'rune',
    'sor',
    'theer',
    'urn',
    'veil',
    'wyn',
    'xius',
    'yarl',
    'zephyr'
  ];

  var now = DateTime.now();
  int prefixIndex = now.millisecond % prefixes.length;
  int suffixIndex = now.second % suffixes.length;

  return '${prefixes[prefixIndex]}${suffixes[suffixIndex]}';
}

String generateTip(String lang) {
  if (lang == "en") {
    List<String> ecoFriendlyTips = [
      'Implement Smart Thermostats: Install a smart thermostat that can learn your schedule and preferences. These devices can adjust the heating and cooling of your home more efficiently than traditional thermostats. They can lower or turn off heating and cooling when you\'re asleep or away from home, and bring the temperature back to your preferred level when you\'re due to return.',
      'Upgrade to Energy-Efficient Appliances: Replace older appliances with energy-efficient models. Look for the ENERGY STAR label when purchasing new appliances, as these are certified to be more efficient. This includes refrigerators, dishwashers, washing machines, and dryers. Although the upfront cost can be higher, the energy savings over time will compensate for this.',
      'Optimize Water Heating: Water heating can be a significant energy expense. Lowering the water heater\'s temperature to 120 degrees Fahrenheit (49 degrees Celsius) can reduce energy use. Also, consider insulating your water heater and the first six feet of hot and cold water pipes connected to the unit.',
      'Use LED Lighting: Replace incandescent bulbs with LED bulbs, which use at least 75% less energy and last 25 times longer. Also, consider using smart lighting solutions that can be controlled remotely to ensure lights are off when not needed.',
      'Adopt Solar Power: If feasible, invest in solar panels for your home. This can significantly reduce your dependence on the grid and lower your electricity bills. Many regions offer tax incentives or rebates for solar panel installation.',
      'Enhance Insulation and Seal Leaks: Improving your home\'s insulation in the attic, walls, and floors can make a big difference. Also, seal any leaks around windows, doors, and electrical outlets to prevent warm or cool air from escaping, reducing the load on your heating and cooling systems.',
      'Utilize Natural Lighting and Passive Solar Heating: Make the most of natural light during the day instead of using artificial lighting. During colder months, open curtains on south-facing windows during the day to allow sunlight to naturally heat your home and close them at night to reduce the chill from cold windows.',
      'Invest in Energy-Efficient Windows: Double-glazed or triple-glazed windows, as well as those with low-emissivity (low-E) coatings, can significantly reduce heat loss in winter and heat gain in summer, thereby saving on heating and cooling costs.',
      'Practice Efficient Cooking and Baking: Use lids on pots to reduce cooking time, and avoid opening the oven door frequently as it lowers the temperature inside. Using a microwave or toaster oven for small meals can be more energy-efficient than heating a full-size oven.',
      'Implement a Home Energy Audit: Conduct or hire a professional to perform a home energy audit. This assessment can pinpoint specific areas where your home is losing energy and recommend measures to improve efficiency. This can include adding insulation, sealing leaks, or upgrading appliances.'
    ];

    var now = DateTime.now();
    int index = now.millisecond % ecoFriendlyTips.length;
    return ecoFriendlyTips[index];
  } else {
    List<String> ecoFriendlyTips = [
      'スマートサーモスタットの導入：スケジュールや好みを学習できるスマートサーモスタットを設置します。これらのデバイスは従来のサーモスタットよりも効率的にあなたの家の暖房と冷房を調整できます。眠っている時や家を離れている時には暖房や冷房を下げたり切ったりでき、戻る時には好みの温度に戻すことができます。',
      'エネルギー効率の高い家電製品へのアップグレード：古い家電製品をエネルギー効率の高いモデルに交換します。新しい家電製品を購入する際は、エネルギー効率が認証されたENERGY STARラベルを探してください。これには冷蔵庫、食器洗い機、洗濯機、乾燥機が含まれます。初期費用は高くなるかもしれませんが、時間とともにエネルギー節約がこれを補います。',
      '給湯の最適化：給湯は大きなエネルギーの出費となり得ます。給湯器の温度を120度ファーレンハイト（49度セルシウス）に下げることでエネルギー使用量を減らすことができます。また、給湯器とそれに接続された熱いおよび冷たい水のパイプの最初の6フィートを断熱することも検討してください。',
      'LED照明の使用：白熱電球をLED電球に交換します。これらは少なくとも75%エネルギーを節約し、25倍長持ちします。また、必要のない時にライトを消すために、遠隔操作できるスマート照明ソリューションを使用することも検討してください。',
      '太陽光発電の採用：可能であれば、自宅用の太陽光パネルに投資します。これにより、電力網への依存度を大幅に減らし、電気代を下げることができます。多くの地域では、太陽光パネルの設置に対する税控除やリベートが提供されています。',
      '断熱の強化と漏れの封じ込め：屋根裏、壁、床の断熱を改善することが大きな違いを生むことがあります。また、窓、ドア、電気コンセント周辺の漏れを封じることで、暖かいまたは涼しい空気の逃げを防ぎ、暖房および冷房システムへの負荷を減らします。',
      '自然光と受動的太陽熱利用：昼間は人工照明の代わりに自然光を最大限に利用します。寒い月には、昼間に南向きの窓のカーテンを開けて自然に家を暖め、夜には冷たい窓からの寒さを減らすために閉じます。',
      'エネルギー効率の高い窓への投資：二重ガラスまたは三重ガラスの窓、および低放射率（low-E）コーティングのある窓は、冬の熱損失と夏の熱獲得を大幅に減らすことができ、それにより暖房および冷房コストの節約につながります。',
      '効率的な調理および焼き方の実践：調理時間を短縮するために鍋に蓋を使用し、オーブンのドアを頻繁に開けることを避けてください。それは内部の温度を下げます。小さな食事にはマイクロ波またはトースターオーブンを使用することが、フルサイズのオーブンを加熱するよりもエネルギー効率が高いかもしれません。',
      'ホームエネルギー監査の実施：自宅のエネルギー監査を行うか、専門家を雇って行います。この評価により、家がエネルギーを失っている特定の領域を特定し、効率を改善するための措置を推奨することができます。これには断熱材の追加、漏れの封じ込め、家電製品のアップグレードが含まれることがあります。'
    ];

    var now = DateTime.now();
    int index = now.millisecond % ecoFriendlyTips.length;
    return ecoFriendlyTips[index];
  }
}
