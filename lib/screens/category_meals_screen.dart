import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/caterory-Screen';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);


  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

 @override
  void didChangeDependencies() {
    if(!_loadedInitData){final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id']; //WHY DO I GET AN ERROR IF I DONT MAKE IT FINAL?
    displayedMeals =widget.availableMeals.where((meal){
      return meal.categories.contains(categoryId); }).toList();
      _loadedInitData=true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(mealId){
    setState(() {
      displayedMeals.removeWhere((meal)=> meal.id==mealId);
    });

  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx,index){
          return MealItem(
            id: displayedMeals[index].id,
            title:displayedMeals[index].title,
            imageUrl:displayedMeals[index].imageUrl,
            affordability:displayedMeals[index].affordability,
            complexity:displayedMeals[index].complexity,
            duration:displayedMeals[index].duration,
           // removeItem: _removeMeal, we used that with .pop around 170-180 videos
            );
        
        }, 
        itemCount:displayedMeals.length ,)
    );
  }
}
