// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:casino_test/src/presentation/widgets.dart/design_back_button.dart';
import 'package:casino_test/src/presentation/widgets.dart/design_scaffold.dart';
import 'package:casino_test/src/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'package:casino_test/src/data/models/character.dart';
import 'package:palette_generator/palette_generator.dart';

class CharacterDetailScreen extends StatefulWidget {
  const CharacterDetailScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  final Character character;

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  late List<PaletteColor> _bgColors;

  @override
  void initState() {
    super.initState();
    _bgColors = [];
    _updatePalette();
  }

  _updatePalette() async {
    PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
      CachedNetworkImageProvider(widget.character.image),
      size: const Size(200, 100),
    );

    palette.darkMutedColor != null
        ? _bgColors.add(
            palette.darkVibrantColor!,
          )
        : _bgColors.add(
            PaletteColor(Colors.blue, 6),
          );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      color: _bgColors.isNotEmpty ? _bgColors.first.color : Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              DesignBackButton(),
              const RelativeXBox(width: 0.012),
              Text(
                'Home',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const RelativeXBox(width: 0.02),
              Container(
                height: 15,
                width: 2,
                color: Colors.white,
              ),
              const RelativeXBox(width: 0.02),
              Text(
                'Status',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const RelativeXBox(width: 0.02),
              Container(
                height: 15,
                width: 2,
                color: Colors.white,
              ),
              const RelativeXBox(width: 0.02),
              Text(
                'Rick & Morty',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const RelativeYBox(height: 0.02),
          CachedNetworkImage(
            imageUrl: widget.character.image,
            errorWidget: (context, url, error) => const Icon(
              Icons.person,
            ),
          ),
          const RelativeYBox(height: 0.02),
          Text(
            'Rick & Morty',
            style: TextStyle(
              fontSize: 28,
              color: getBodyColor,
            ),
          ),
          Text(
            widget.character.name,
            style: TextStyle(
              fontSize: 30,
              color: getBodyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const RelativeYBox(height: 0.02),
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildItemRow(
                  title: 'Status:',
                  description: widget.character.status,
                ),
                const RelativeYBox(height: 0.015),
                _buildItemRow(
                  title: 'Species:',
                  description: widget.character.species,
                ),
                const RelativeYBox(height: 0.015),
                _buildItemRow(
                  title: 'Gender:',
                  description: widget.character.gender,
                ),
                const RelativeYBox(height: 0.015),
                _buildItemRow(
                  title: 'Origin:',
                  description: widget.character.origin.name,
                ),
                const RelativeYBox(height: 0.015),
                _buildItemRow(
                  title: 'Location:',
                  description: widget.character.location.name,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Color get getTitleColor =>
      _bgColors.isNotEmpty ? _bgColors.first.titleTextColor : Colors.white;

  Color get getBodyColor =>
      _bgColors.isNotEmpty ? _bgColors.first.bodyTextColor : Colors.white;

  Widget _buildItemRow({required String title, required String description}) {
    return Wrap(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: getBodyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const RelativeXBox(width: 0.01),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: getTitleColor,
          ),
        ),
      ],
    );
  }
}
