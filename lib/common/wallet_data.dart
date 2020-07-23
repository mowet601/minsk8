import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:minsk8/import.dart';

class WalletData extends SourceList<WalletItem> {
  WalletData(
    GraphQLClient client,
  ) : super(client);

  String _nextDate;

  @override
  bool get isInfinite => true;

  @override
  QueryOptions get options {
    final variables = {'next_created_at': nextCreatedAt};
    return QueryOptions(
      documentNode: Queries.getMyPayments,
      variables: variables,
      fetchPolicy: FetchPolicy.noCache,
    );
  }

  @override
  List<WalletItem> getItems(data) {
    final dataItems = [...data['payments'] as List];
    // сначала наполняю буфер items, если есть ошибки в PaymentModel.fromJson
    final items = <WalletItem>[];
    final hasMore = dataItems.length == kGraphQLPaymentsLimit;
    this.hasMore = hasMore;
    if (hasMore) {
      final payment = PaymentModel.fromJson(dataItems.removeLast());
      nextCreatedAt = payment.createdAt.toUtc().toIso8601String();
    }
    for (final dataItem in dataItems) {
      final payment = PaymentModel.fromJson(dataItem);
      final date =
          payment.createdAt.toLocal().toIso8601String().substring(0, 10);
      if (_nextDate != date) {
        _nextDate = date;
        items.add(
          WalletItem(
            // TODO: locale autodetect
            displayDate: DateFormat.yMMMMd('ru_RU').format(
              DateTime.parse(date),
            ),
          ),
        );
      }
      items.add(WalletItem(payment: payment));
    }
    return items;
  }
}

class WalletItem {
  WalletItem({this.displayDate, this.payment})
      : assert((displayDate != null || payment != null) &&
            !(displayDate != null && payment != null));

  String displayDate;
  PaymentModel payment;
}
