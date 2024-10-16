import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wrenchmate_user_app/app/modules/support/widgets/socialmediatabs.dart';
import '../../controllers/support_controller.dart';
import '../booking/widgets/tabButton.dart';

class SupportPage extends StatefulWidget {
  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  String selectedTab = 'FAQ';
  
  // Sample FAQ data
  final List<Map<String, String>> faqs = [
    {'question': 'What is your return policy?', 'answer': 'You can return items within 30 days.'},
    {'question': 'How do I contact support?', 'answer': 'You can contact us via the chat option.'},
    {'question': 'What is your return policy?', 'answer': 'You can return items within 30 days.'},
    {'question': 'How do I contact support?', 'answer': 'You can contact us via the chat option.'},
    {'question': 'What is your return policy?', 'answer': 'You can return items within 30 days.'},
    {'question': 'How do I contact support?', 'answer': 'You can contact us via the chat option.'},
    // Add more FAQs as needed
  ];

  // Track visibility of each FAQ item
  List<bool> _isVisibleList = List.generate(6, (index) => false); // Adjust size based on FAQs

  @override
  Widget build(BuildContext context) {
    final SupportController controller = Get.find();
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Help and Support',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  18.0),
        child: Column(
          children: [
            //tabs
            Row(
              children: [
                // Current booking
                TabButton(
                  text: 'FAQ',
                  isSelected: selectedTab == 'FAQ',
                  onTap: () {
                    setState(() {
                      selectedTab = 'FAQ';
                    });
                  },
                ),
                SizedBox(width: 8),
                // History
                TabButton(
                  text: 'Contact Us',
                  isSelected: selectedTab == 'ContactUs',
                  onTap: () {
                    setState(() {
                      selectedTab = 'ContactUs';
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 8,),
            // Display content based on selected tab
            if (selectedTab == 'FAQ') 
              Expanded(child: ExpandingListFAQs()) // Call the FAQ list method
            else 
              Column(
                children: [
                  CustomContainer(imagePath: 'assets/socials/chatus.png', text: "Chat with Us", onTap: (){}), // Provide a valid function
                  CustomContainer(imagePath: 'assets/socials/facebook.png', text: "Facebook", onTap: (){}), // Provide a valid function
                  CustomContainer(imagePath: 'assets/socials/instagram.png', text: "Instagram", onTap: (){}), // Provide a valid function
                  CustomContainer(imagePath: 'assets/socials/twt.png', text: "Twitter", onTap: (){}), // Provide a valid function
                ],
              ),
          ],
        ),
      )
    );
  }

  Widget ExpandingListFAQs() {
    return ListView.builder(
      itemCount: faqs.length,
      itemBuilder: (context, serviceIndex) {
        var faq = faqs[serviceIndex];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0), // Add margin for spacing
          decoration: BoxDecoration(
            color: Colors.white, // Background color
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    faq['question']!, // Use FAQ model
                    style: TextStyle(
                        color: _isVisibleList[serviceIndex]
                            ? Color(0xff3778F2)
                            : Color(0xff7B7B7B),
                        fontSize: 16),
                  ),
                  trailing: _isVisibleList[serviceIndex]
                      ? Icon(Icons.arrow_drop_up, color: Color(0xff3778F2))
                      : Icon(Icons.arrow_drop_down, color: Color(0xff7B7B7B)),
                  onTap: () {
                    setState(() {
                      _isVisibleList[serviceIndex] = !_isVisibleList[serviceIndex];
                    });
                  },
                  tileColor: Colors.transparent, // Set tile color to transparent
                ),
                Visibility(
                  visible: _isVisibleList[serviceIndex],
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                      child: Text(
                        faq['answer']!, // Use FAQ model
                        style: TextStyle(color: Color(0xff6D6D6D), fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}