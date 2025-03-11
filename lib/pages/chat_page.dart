import 'package:chat/constants.dart';
import 'package:chat/models/message_Model.dart';
import 'package:chat/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat/widget/chat_buble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kLogo,
              height: 50,
            ),
            const Text('Chat'),
          ],
        ),
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              var messagesList =
                  BlocProvider.of<ChatCubit>(context).messagesList;
              return ListView.builder(
                reverse: true,
                controller: _controller,
                itemCount: messagesList.length,
                itemBuilder: (context, index) {
                  return messagesList[index].id == email
                      ? ChatBuble(
                          message: messagesList[index],
                        )
                      : ChatBubleForFriend(message: messagesList[index]);
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                controller.clear();
                _controller.animateTo(
                  0,
                  curve: Curves.easeIn,
                  duration: const Duration(milliseconds: 500),
                );
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: kPrimaryColor),
                  ),
                  hintText: 'Sent Message',
                  suffixIcon: const Icon(
                    Icons.send,
                    color: kPrimaryColor,
                  )),
            ),
          )
        ],
      ),
    );
  }
}
