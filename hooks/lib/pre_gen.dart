import 'dart:io' as io;
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_parse/pubspec_parse.dart';

Never bailOut(HookContext context) {
  context.logger.err('Execute this brick from a Flutter Project root');
  io.exit(69);
}

Future<void> preGen(HookContext context) async {
  final cwd = io.Directory.current;
  final pubspecFile = io.File(path.join(cwd.path, 'pubspec.yaml'));

  if (!pubspecFile.existsSync()) {
    bailOut(context);
  }

  final pubspec = Pubspec.parse(pubspecFile.readAsStringSync());

  final isFlutterProject =
      pubspec.dependencies.keys.any((element) => element == 'flutter');

  if (!isFlutterProject) {
    bailOut(context);
  }
}
