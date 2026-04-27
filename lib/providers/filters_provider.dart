import 'package:flutter_riverpod/legacy.dart';

// ignore: camel_case_types
enum filter { gluetenFree, lactoseFree, vegetarian, vegan }

class FiltersNotifier extends StateNotifier<Map<filter, bool>> {
  FiltersNotifier()
    : super({
        filter.gluetenFree: false,
        filter.lactoseFree: false,
        filter.vegetarian: false,
        filter.vegan: false,
      });

  void setFilters(Map<filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<filter, bool>>(
      (Ref) => FiltersNotifier(),
    );
