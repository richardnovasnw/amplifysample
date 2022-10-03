/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'UserModel.dart';

/** This is an auto generated class representing the Auth type in your schema. */
@immutable
class Auth extends Model {
  static const classType = const _AuthModelType();
  final String id;
  final UserModel? _email;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;
  final String? _authEmailId;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  UserModel? get email {
    return _email;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  String? get authEmailId {
    return _authEmailId;
  }

  const Auth._internal(
      {required this.id, email, createdAt, updatedAt, authEmailId})
      : _email = email,
        _createdAt = createdAt,
        _updatedAt = updatedAt,
        _authEmailId = authEmailId;

  factory Auth({String? id, UserModel? email, String? authEmailId}) {
    return Auth._internal(
        id: id == null ? UUID.getUUID() : id,
        email: email,
        authEmailId: authEmailId);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Auth &&
        id == other.id &&
        _email == other._email &&
        _authEmailId == other._authEmailId;
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Auth {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write("updatedAt=" +
        (_updatedAt != null ? _updatedAt!.format() : "null") +
        ", ");
    buffer.write("authEmailId=" + "$_authEmailId");
    buffer.write("}");

    return buffer.toString();
  }

  Auth copyWith({String? id, UserModel? email, String? authEmailId}) {
    return Auth._internal(
        id: id ?? this.id,
        email: email ?? this.email,
        authEmailId: authEmailId ?? this.authEmailId);
  }

  Auth.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _email = json['email']?['serializedData'] != null
            ? UserModel.fromJson(
                new Map<String, dynamic>.from(json['email']['serializedData']))
            : null,
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null,
        _authEmailId = json['authEmailId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': _email?.toJson(),
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format(),
        'authEmailId': _authEmailId
      };

  static final QueryField ID = QueryField(fieldName: "auth.id");
  static final QueryField EMAIL = QueryField(
      fieldName: "email",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (UserModel).toString()));
  static final QueryField AUTHEMAILID = QueryField(fieldName: "authEmailId");
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Auth";
    modelSchemaDefinition.pluralName = "Auths";

    modelSchemaDefinition.authRules = [
      AuthRule(authStrategy: AuthStrategy.PUBLIC, operations: [
        ModelOperation.CREATE,
        ModelOperation.UPDATE,
        ModelOperation.DELETE,
        ModelOperation.READ
      ])
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
        key: Auth.EMAIL,
        isRequired: false,
        ofModelName: (UserModel).toString(),
        associatedKey: UserModel.ID));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: Auth.AUTHEMAILID,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));
  });
}

class _AuthModelType extends ModelType<Auth> {
  const _AuthModelType();

  @override
  Auth fromJson(Map<String, dynamic> jsonData) {
    return Auth.fromJson(jsonData);
  }
}
