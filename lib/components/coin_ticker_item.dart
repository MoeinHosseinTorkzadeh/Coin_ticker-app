import 'package:flutter/material.dart';

class CoinTickerItem extends StatelessWidget {
  const CoinTickerItem(
      {super.key,
      required this.price,
      required this.selectedCurrency,
      required this.selectedCrypto});

  final String? price;
  final String selectedCurrency;
  final String selectedCrypto;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 7.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ${selectedCrypto} = ${price} ${selectedCurrency.toUpperCase()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
