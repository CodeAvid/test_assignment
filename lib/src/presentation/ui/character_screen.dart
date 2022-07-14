import 'package:cached_network_image/cached_network_image.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/character_detail_screen.dart';
import 'package:casino_test/src/presentation/widgets.dart/design_scaffold.dart';
import 'package:casino_test/src/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shimmer/shimmer.dart';

@immutable
class CharactersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DesignScaffold(
      isScrollable: false,
      body: BlocProvider(
        create: (context) => MainPageBloc(
          InitialMainPageState(),
          GetIt.I.get<CharactersRepository>(),
        )..add(const GetTestDataOnMainPageEvent(1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rick and Morty App',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            BlocConsumer<MainPageBloc, MainPageState>(
              listener: (context, state) {},
              builder: (blocContext, state) {
                if (state is LoadingMainPageState) {
                  return _loadingWidget(context);
                } else if (state is SuccessfulMainPageState) {
                  return _successfulWidget(context, state);
                } else {
                  return Center(child: const Text("error"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return Expanded(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          itemCount: 10,
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.only(top: 20),
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.only(right: 16),
            height: screenHeight(context) * 0.1,
            width: screenWidth(context) * 0.3,
            color: Colors.grey[300],
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
        ),
      ),
    );
  }

  Widget _successfulWidget(
      BuildContext context, SuccessfulMainPageState state) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.only(top: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
        cacheExtent: double.maxFinite,
        itemCount: state.characters.length,
        itemBuilder: (context, index) {
          return _characterWidget(context, state.characters[index]);
        },
      ),
    );
  }

  Widget _characterWidget(BuildContext context, Character character) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(
              character: character,
            ),
          ),
        );
      },
      child: Container(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: character.image,
                width: double.infinity,
                fit: BoxFit.cover,
                height: 180,
                errorWidget: (context, url, error) => const Icon(
                  Icons.person,
                ),
              ),
            ),
            Text(
              character.name,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${character.species}, ",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  character.status.toLowerCase(),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
