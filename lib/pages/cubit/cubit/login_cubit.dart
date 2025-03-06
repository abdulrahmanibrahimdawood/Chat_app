import 'package:bloc/bloc.dart';
import 'package:chat/helper/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found') {
        emit(LoginFailure(errmessage: 'no user found'));
      } else if (ex.code == 'wrong-password') {
        emit(LoginFailure(errmessage: 'wrong password'));
      } else if (ex.code == 'invalid-email') {
        emit(LoginFailure(errmessage: 'email is not valid'));
      } else if (ex.code == 'user-disabled') {
        emit(LoginFailure(errmessage: 'user is disabled'));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errmessage: 'there was an error'));
    }
  }
}
