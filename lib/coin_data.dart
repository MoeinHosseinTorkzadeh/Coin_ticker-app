import 'services/networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String websiteURL =
    'https://api.coingecko.com/api/v3/simple/price?';
const String apiKey = 'CG-fjYY3kWESYBF56agB4uFbb6V';

class CoinData {
  Future<dynamic> getCoinData(String crypto, String? currency) async {
    String url =
        '${websiteURL}ids=${crypto}&vs_currencies=${currency}&x_cg_demo_api_key=${apiKey}';

    NetworkHelper networkHelper = NetworkHelper(url);

    var cryptoData = await networkHelper.getData();
    return cryptoData;
  }
}
