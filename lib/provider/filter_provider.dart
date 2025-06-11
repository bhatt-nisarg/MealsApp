import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meal_provider.dart';

enum Filter { glutanFree, lactoseFree, vegetarian, vegan }

/// mutating in state is not allowed while using state management we have to
/// initialize new state or assign new state to it
/// For example here
/// state[filter] = isActive in setFilter method not allowed because it is mutating the state
class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  // set initial state it
  FiltersNotifier()
      : super({
          Filter.glutanFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false
        });

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }

  // for single filter set
  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive; // not allowed => mutating state
    state = {
      ...state,
      filter:
          isActive // this will change current key if it is exist in map other wise add new key
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filterdMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutanFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
