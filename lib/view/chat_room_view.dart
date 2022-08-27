import 'dart:async';

import 'package:donghaeng/model/chat.dart';
import 'package:donghaeng/viewmodel/chat_room_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/di/locator.dart';

class ChatroomView extends StatefulWidget {
  const ChatroomView({Key? key}) : super(key: key);

  @override
  State<ChatroomView> createState() => _ChatroomViewState();
}

class _ChatroomViewState extends State<ChatroomView> {
  final viewModel = sl<ChatroomViewModel>();
  late Future<ChatRoom?> chatroom = viewModel.getChatroom();
  late List<Chat> chats = viewModel.getRealtimeChats();
  late User user;

  // text edit
  late TextEditingController _textController;

  sendMessage(String text) async {
    viewModel.addChat(user.uid, text);

    _textController.clear();
  }

  @override
  void initState() {
    _textController = TextEditingController();

    user = FirebaseAuth.instance.currentUser!;
    print('user $user');

    super.initState();
  }

  @override
  void dispose() {
    _textController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatroomViewModel>(
      builder: (_, __, ___) => Scaffold(
        appBar: _appBar,
        body: Column(
          children: <Widget>[
            _chatMain,
            _sendBar,
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget get _appBar => AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: FutureBuilder(
                      future: chatroom,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          ChatRoom? chatroom = snapshot.data as ChatRoom?;
                          return Center(child: Text(chatroom?.title ?? 'Fail'));
                        } else if (snapshot.hasError) {
                          print(
                              'error : chatroom_view : FutureBuilder : ${snapshot.error}');
                          return const Center(child: Text("Fail"));
                        }
                        return const Center(child: Text("loading"));
                      }),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.more_horiz,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.share,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget get _chatMain => Expanded(
        child: ListView.builder(
            itemCount: chats.length,
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Row(
                  mainAxisAlignment: (chats[index].owner == user.uid
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start),
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(
                            left: 16, right: 12, top: 10, bottom: 10),
                        child: (chats[index].owner != user.uid)
                            ? const CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "https://avatars.githubusercontent.com/u/38811086?v=4"),
                                maxRadius: 20,
                              )
                            : null),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 10, bottom: 10),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 299),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey.shade200),
                          color: (chats[index].owner == user.uid
                              ? Colors.grey.shade200
                              : Colors.white),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          chats[index].content,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ]);
            }),
      );

  Widget get _sendBar => Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
          height: 60,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              GestureDetector(
                // todo : 정해지면 수정
                onTap: () {},
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  onSubmitted: (text) {
                    sendMessage(text);
                  },
                  decoration: const InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  sendMessage(_textController.text);
                },
                style: ElevatedButton.styleFrom(
                  // Foreground color
                  onPrimary: Theme.of(context).colorScheme.onPrimary,
                  // Background color
                  primary: const Color(0xFF7287EA).withOpacity(0.12), // 배경색
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 20), // 사이즈
                  shape: const StadiumBorder(),
                ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
                child: const Text(
                  "SEND",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff7287EA)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      );
}

// todo: 원형 표시 - 프로필
// const CircleAvatar(
// backgroundImage: NetworkImage(
// "<https://randomuser.me/api/portraits/men/5.jpg>"),
// maxRadius: 20,
// ),
