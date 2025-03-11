import 'package:bloc/bloc.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/message_Model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  List<Message> messagesList = [];

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  void sendMessage({required String message, required String email}) {
    try {
      messages.add(
        {
          kMessagesCollection: message,
          kCreatedAt: DateTime.now(),
          kID: email,
        },
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessages() {
    messages
        .orderBy(
          kCreatedAt,
          descending: true,
        )
        .snapshots()
        .listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        messagesList.add(Message.fromJson(doc));
      }

      emit(ChatSuccess(messages: messagesList));
    });
  }
}
