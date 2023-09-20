import 'dart:io' as io;
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';

void bailOut(HookContext context, Exit exit) {
  context.logger.err('Execute this brick from a Flutter Project root');
  exit(69);
}

typedef Exit = void Function(int code);

Future<void> preGen(
  HookContext context, [
  Exit exit = io.exit,
]) async {
  final cwd = io.Directory.current;
  final pubspecFile = io.File(path.join(cwd.path, 'pubspec.yaml'));

  if (!pubspecFile.existsSync()) {
    return bailOut(context, exit);
  }

  final pubspec = Pubspec.parse(pubspecFile.readAsStringSync());

  final isFlutterProject =
      pubspec.dependencies.keys.any((element) => element == 'flutter');

  if (!isFlutterProject) {
    return bailOut(context, exit);
  }
}
