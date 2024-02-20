import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GolemsRecord extends FirestoreRecord {
  GolemsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  bool hasType() => _type != null;

  // "level" field.
  int? _level;
  int get level => _level ?? 0;
  bool hasLevel() => _level != null;

  // "owner" field.
  DocumentReference? _owner;
  DocumentReference? get owner => _owner;
  bool hasOwner() => _owner != null;

  // "steps" field.
  int? _steps;
  int get steps => _steps ?? 0;
  bool hasSteps() => _steps != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  bool hasStatus() => _status != null;

  // "strength" field.
  double? _strength;
  double get strength => _strength ?? 0.0;
  bool hasStrength() => _strength != null;

  // "typeIcon" field.
  String? _typeIcon;
  String get typeIcon => _typeIcon ?? '';
  bool hasTypeIcon() => _typeIcon != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  bool hasImage() => _image != null;

  // "stepsReset" field.
  int? _stepsReset;
  int get stepsReset => _stepsReset ?? 0;
  bool hasStepsReset() => _stepsReset != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _type = snapshotData['type'] as String?;
    _level = castToType<int>(snapshotData['level']);
    _owner = snapshotData['owner'] as DocumentReference?;
    _steps = castToType<int>(snapshotData['steps']);
    _status = snapshotData['status'] as String?;
    _strength = castToType<double>(snapshotData['strength']);
    _typeIcon = snapshotData['typeIcon'] as String?;
    _image = snapshotData['image'] as String?;
    _stepsReset = castToType<int>(snapshotData['stepsReset']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('golems');

  static Stream<GolemsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GolemsRecord.fromSnapshot(s));

  static Future<GolemsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GolemsRecord.fromSnapshot(s));

  static GolemsRecord fromSnapshot(DocumentSnapshot snapshot) => GolemsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GolemsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GolemsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GolemsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GolemsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGolemsRecordData({
  String? name,
  String? type,
  int? level,
  DocumentReference? owner,
  int? steps,
  String? status,
  double? strength,
  String? typeIcon,
  String? image,
  int? stepsReset,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'type': type,
      'level': level,
      'owner': owner,
      'steps': steps,
      'status': status,
      'strength': strength,
      'typeIcon': typeIcon,
      'image': image,
      'stepsReset': stepsReset,
    }.withoutNulls,
  );

  return firestoreData;
}

class GolemsRecordDocumentEquality implements Equality<GolemsRecord> {
  const GolemsRecordDocumentEquality();

  @override
  bool equals(GolemsRecord? e1, GolemsRecord? e2) {
    return e1?.name == e2?.name &&
        e1?.type == e2?.type &&
        e1?.level == e2?.level &&
        e1?.owner == e2?.owner &&
        e1?.steps == e2?.steps &&
        e1?.status == e2?.status &&
        e1?.strength == e2?.strength &&
        e1?.typeIcon == e2?.typeIcon &&
        e1?.image == e2?.image &&
        e1?.stepsReset == e2?.stepsReset;
  }

  @override
  int hash(GolemsRecord? e) => const ListEquality().hash([
        e?.name,
        e?.type,
        e?.level,
        e?.owner,
        e?.steps,
        e?.status,
        e?.strength,
        e?.typeIcon,
        e?.image,
        e?.stepsReset
      ]);

  @override
  bool isValidKey(Object? o) => o is GolemsRecord;
}
