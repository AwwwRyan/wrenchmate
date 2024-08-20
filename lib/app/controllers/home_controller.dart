import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userData = {}.obs;
  var profileImageUrl = ''.obs;

  Future<Map?> fetchUserData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      print("aryan is great" + userId);

      DocumentSnapshot userDoc =
          await _firestore.collection('User').doc(userId).get();

      userData.value = userDoc.data() as Map<String, dynamic>;
      profileImageUrl.value = userData.value['profileImagePath'] ?? '';
      print("User data fetched successfully: ${userData.value}");
      return userData.value;
    } catch (e) {
      print("Failed to fetch user data: $e");
      Get.snackbar("Error", "Failed to fetch user data: ${e.toString()}");
      return null;
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updatedData) async {
    try {
      print("in update user profile");
      String userId = FirebaseAuth.instance.currentUser!.uid;
      String? profileImagePath;

      // Check if a new image was provided and upload it
      if (updatedData.containsKey('User_profile_image')) {
        profileImagePath = await uploadImageToStorage(updatedData['User_profile_image']);
        updatedData['User_profile_image'] = profileImagePath ?? '';
      }

      await _firestore.collection('User').doc(userId).update(updatedData);

      // Update the observable userData with changed fields
      userData.value.addAll(updatedData);

      print("User profile updated successfully.");
      Get.snackbar("Success", "Profile updated successfully.");
      fetchUserData(); // Fetch updated data
    } catch (e) {
      print("Failed to update user profile: $e");
      Get.snackbar("Error", "Failed to update profile: ${e.toString()}");
    }
  }

  Future<String?> uploadImageToStorage(File image) async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      final storageReference = FirebaseStorage.instance.ref('/Users');
      final fileName= image.path.split('/').last;
      final dateStamp = DateTime.now().microsecondsSinceEpoch;
      final uploadReference =  storageReference.child('$userId/ProfileImage/$dateStamp-$fileName');
      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      TaskSnapshot taskSnapshot = await uploadReference.putFile(image,metadata);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print("Failed to upload image: $e");
      return null;
    }
  }
}