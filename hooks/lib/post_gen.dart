import 'dart:io' as io;
import 'package:mason/mason.dart';
import 'package:path/path.dart' as path;
import 'package:yaml_edit/yaml_edit.dart';

Future<void> postGen(HookContext context) async {
  final logger = context.logger;
  final vars = context.vars;
  final snakeNamed = (vars['name'] as String).snakeCase;

  logger.info('GLSL File created at shaders/$snakeNamed.glsl');

  final cwd = io.Directory.current;
  final pubspecFile = io.File(path.join(cwd.path, 'pubspec.yaml'));
  final yaml = pubspecFile.readAsStringSync();
  final editor = YamlEditor(yaml)
    ..appendToList(['flutter', 'shaders'], 'shaders/$snakeNamed.glsl');

  pubspecFile.writeAsStringSync(editor.toString());

  logger.info('Shader added to pubspec.yaml');
}
