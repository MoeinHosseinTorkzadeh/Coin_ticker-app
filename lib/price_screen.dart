import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'components/coin_ticker_item.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'usd'; //to show selected currency

  String? btcPrice;
  String? ethPrice;
  String? ltcPrice;

  CoinData coinData = CoinData();

  Future<dynamic> updateHelper() async {
    var btcData =
        await coinData.getCoinData('bitcoin', selectedCurrency);
    var ethData =
        await coinData.getCoinData('ethereum', selectedCurrency);
    var ltcData =
        await coinData.getCoinData('litecoin', selectedCurrency);

    updateBTC(btcData, selectedCurrency);
    updateETH(ethData, selectedCurrency);
    updateLTC(ltcData, selectedCurrency);
  }

  @override
  void initState() {
    super.initState();
    updateHelper();
  }

  void updateBTC(dynamic cryptoData, String userCurrency) {
    setState(() {
      if (cryptoData == null) {
        btcPrice = '0';
        return;
      } else {
        btcPrice = cryptoData['bitcoin'][userCurrency].toString();
      }
    });
  }

  void updateETH(dynamic cryptoData, String userCurrency) {
    setState(() {
      if (cryptoData == null) {
        btcPrice = '0';
        return;
      } else {
        ethPrice = cryptoData['ethereum'][userCurrency].toString();
      }
    });
  }

  void updateLTC(dynamic cryptoData, String userCurrency) {
    setState(() {
      if (cryptoData == null) {
        btcPrice = '0';
        return;
      } else {
        ltcPrice = cryptoData['litecoin'][userCurrency].toString();
      }
    });
  }

  CupertinoPicker iosPicker() {
    List<Text> listOfAllCurrencies = [];
    for (String currency in currenciesList) {
      listOfAllCurrencies.add(
        Text(currency),
      );
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency =
              currenciesList[selectedIndex].toLowerCase();
          updateHelper();
        });
      },
      children: listOfAllCurrencies,
    );
  }

  DropdownButton<String> getAndroidDropDown() {
    List<DropdownMenuItem<String>> listOfCurrencies = [];
    for (String currency in currenciesList) {
      listOfCurrencies.add(
        DropdownMenuItem(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: selectedCurrency.toUpperCase(),
      items:
          listOfCurrencies, //We pass the function to create each currency
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value!.toLowerCase();
            updateHelper();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CoinTickerItem(
            price: btcPrice,
            selectedCurrency: selectedCurrency,
            selectedCrypto: 'BTC',
          ),
          CoinTickerItem(
            price: ethPrice,
            selectedCurrency: selectedCurrency,
            selectedCrypto: 'ETH',
          ),
          CoinTickerItem(
            price: ltcPrice,
            selectedCurrency: selectedCurrency,
            selectedCrypto: 'LTC',
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 150,
        color: Colors.lightBlue,
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 30.0),
          color: Colors.lightBlue,
          child: Platform.isIOS ? iosPicker() : getAndroidDropDown(),
        ),
      ),
    );
  }
}
