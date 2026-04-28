import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:project4/providers/meals_provider.dart';

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

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  return meals.where((meal) {
    if (activeFilters[filter.gluetenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
