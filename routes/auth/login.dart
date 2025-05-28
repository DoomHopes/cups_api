import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  
  if (context.request.method == HttpMethod.get) {
    return Response.json(
      body: {'message': 'Login'},
    );
  }

  return Response(
    statusCode: 405,
    body: 'Method Not Allowed',
  );
}
