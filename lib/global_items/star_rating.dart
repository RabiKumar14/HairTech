import 'package:hair_salon/global_items/package_export.dart';

class StarRating extends StatelessWidget {
  final void Function(int index) onChanged;
  final int value;
  final IconData filledStar;
  final IconData unfilledStar;
  final double size;
  const StarRating({
    Key key,
    this.value = 0,
    this.filledStar,
    this.unfilledStar,
    this.onChanged,
    this.size,
  })  : assert(value != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: onChanged != null
              ? () {
                  onChanged(value == index + 1 ? index : index + 1);
                }
              : null,
          child: Icon(
            index < value
                ? filledStar ?? Icons.star
                : unfilledStar ?? Icons.star_border,
            color: index < value ? color : null,
            size: size,
          ),
        );
      }),
    );
  }
}

class PressStarRating extends StatelessWidget {
  final double size;

  const PressStarRating({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int rating = 0;
    return StatefulBuilder(
      builder: (context, setState) {
        return StarRating(
          size: size,
          onChanged: (index) {
            setState(() {
              rating = index;
            });
          },
          value: rating,
        );
      },
    );
  }
}
