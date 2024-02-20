import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'generating_model.dart';
export 'generating_model.dart';

class GeneratingWidget extends StatefulWidget {
  const GeneratingWidget({
    super.key,
    required this.type,
    required this.typeIcon,
  });

  final String? type;
  final String? typeIcon;

  @override
  State<GeneratingWidget> createState() => _GeneratingWidgetState();
}

class _GeneratingWidgetState extends State<GeneratingWidget>
    with TickerProviderStateMixin {
  late GeneratingModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'imageOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
    'textOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
        RotateEffect(
          curve: Curves.easeInOut,
          delay: 600.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GeneratingModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultrqf = await GetImgCall.call(
        prompt: 'a ${widget.type} golem',
      );
      if ((_model.apiResultrqf?.succeeded ?? true)) {
        await Future.delayed(const Duration(milliseconds: 10000));
        _model.apiResultma3 = await GetPredictionCall.call(
          prediction: getJsonField(
            (_model.apiResultrqf?.jsonBody ?? ''),
            r'''$.id''',
          ).toString().toString(),
        );
        if ((_model.apiResultma3?.succeeded ?? true)) {
          setState(() {
            FFAppState().predictionStatus = getJsonField(
              (_model.apiResultma3?.jsonBody ?? ''),
              r'''$.status''',
            ).toString().toString();
          });
          if (FFAppState().predictionStatus == 'succeeded') {
            await GolemsRecord.collection.doc().set(createGolemsRecordData(
                  type: widget.type,
                  level: 1,
                  owner: currentUserReference,
                  strength: 0.5,
                  image: getJsonField(
                    (_model.apiResultma3?.jsonBody ?? ''),
                    r'''$.output[0]''',
                  ).toString().toString(),
                  steps: 0,
                  name: '',
                  typeIcon: widget.typeIcon,
                ));

            await currentUserReference!.update(createUsersRecordData(
              hasGolem: true,
            ));

            context.goNamed('NameGolem');

            return;
          } else {
            while (valueOrDefault<bool>(currentUserDocument?.hasGolem, false) ==
                false) {
              await Future.delayed(const Duration(milliseconds: 5000));
              _model.apiResultfjb = await GetPredictionCall.call(
                prediction: getJsonField(
                  (_model.apiResultrqf?.jsonBody ?? ''),
                  r'''$.id''',
                ).toString().toString(),
              );
              if ((_model.apiResultfjb?.succeeded ?? true)) {
                setState(() {
                  FFAppState().predictionStatus = getJsonField(
                    (_model.apiResultfjb?.jsonBody ?? ''),
                    r'''$.status''',
                  ).toString().toString();
                });
                if (FFAppState().predictionStatus == 'succeeded') {
                  await GolemsRecord.collection
                      .doc()
                      .set(createGolemsRecordData(
                        type: widget.type,
                        level: 1,
                        owner: currentUserReference,
                        strength: 0.5,
                        image: getJsonField(
                          (_model.apiResultfjb?.jsonBody ?? ''),
                          r'''$.output[0]''',
                        ).toString().toString(),
                        steps: 0,
                        typeIcon: widget.typeIcon,
                      ));

                  await currentUserReference!.update(createUsersRecordData(
                    hasGolem: true,
                  ));

                  context.goNamed('NameGolem');

                  return;
                }
              }
            }
          }
        } else {
          await showDialog(
            context: context,
            builder: (alertDialogContext) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Can\'t obtain image... try again later.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(alertDialogContext),
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );

          context.pushNamed('Dashboard');

          return;
        }
      } else {
        await showDialog(
          context: context,
          builder: (alertDialogContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Can\'t generate image... try again later.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(alertDialogContext),
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );

        context.pushNamed('Dashboard');

        return;
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(0.0, -1.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                      child: Text(
                        FFLocalizations.of(context).getText(
                          'a0jqqfum' /* Your golem is being summoned..... */,
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Manrope',
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                            ),
                      ),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        'd4zp66m4' /* Please wait a moment. */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Manrope',
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.asset(
                          'assets/images/loading.gif',
                          width: 300.0,
                          height: 273.0,
                          fit: BoxFit.cover,
                        ),
                      ).animateOnPageLoad(
                          animationsMap['imageOnPageLoadAnimation']!),
                    ),
                    Text(
                      FFLocalizations.of(context).getText(
                        '2kxqvet9' /* Floracandia Luminastra! */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Manrope',
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                    ).animateOnPageLoad(
                        animationsMap['textOnPageLoadAnimation']!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
