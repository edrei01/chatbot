import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class ChatHistoryManager {
  // Guardar el historial de mensajes como JSON en SharedPreferences
  Future<void> saveChatHistory(List<ChatMessage> messages) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> messageStrings = messages.map((message) => jsonEncode(message.toJson())).toList();
    await prefs.setStringList('chatHistory', messageStrings);
  }

  // Cargar el historial de mensajes desde SharedPreferences
  Future<List<ChatMessage>> loadChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? messageStrings = prefs.getStringList('chatHistory');
    if (messageStrings != null) {
      return messageStrings.map((messageString) => ChatMessage.fromJson(jsonDecode(messageString))).toList();
    } else {
      return [];
    }
  }

  // Limpiar el historial de mensajes
  Future<void> clearChatHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('chatHistory');
  }
}
