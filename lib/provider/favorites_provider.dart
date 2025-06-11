import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

/// make provider class for notifier
class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  //supere key work is used for its supper class inheritance
  FavoriteMealsNotifier() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((m) => m.id != meal.id).toList();
      // if it removed then return false
      return false;
    } else {
      state = [...state, meal];
      // if  it added then return true
      return true;
    }
  }
}

// state notifire provider class is worked with state object class same as StateNotifierProvider work with state object
final favouriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>((red) {
  return FavoriteMealsNotifier();
});
