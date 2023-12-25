import 'package:flutter/material.dart';
import 'package:rv_checklist/resources/colors.dart';

class CheckboxList extends StatefulWidget {
  @override
  _CheckboxListState createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  List<String> items = ['Water', 'Close Cabinets', 'Turn off Generator', 'Pack up Bed'];
  List<String> emojis = ['💧', '🚪', '⚡', '🛏️']; // Default emojis
  Map<String, bool> checked = {};
  TextEditingController titleController = TextEditingController();
  TextEditingController emojiController = TextEditingController();
  bool isAddingCheckbox = false;
  String defaultEmoji = '🔲'; // Default emoji if none is entered

  @override
  void initState() {
    super.initState();
    items.forEach((item) => checked[item] = false);
  }

  void _onCheckboxChanged(String itemValue, bool changedValue) {
    setState(() {
      checked[itemValue] = changedValue;
    });
  }

  double calculateProgress() {
    int totalChecked = checked.values.where((b) => b).length;
    return items.isNotEmpty ? totalChecked / items.length : 0;
  }

  void addCheckbox() {
    String emoji = emojiController.text.trim();
    String title = titleController.text.trim();
    if (title.isNotEmpty) {
      setState(() {
        items.add(title);
        emojis.add(emoji.isNotEmpty ? emoji : defaultEmoji); // Add default emoji if none provided
        checked[title] = false;
        emojiController.clear();
        titleController.clear();
      });
    }
    hideAddCheckbox();
  }

  void hideAddCheckbox() {
    setState(() {
      isAddingCheckbox = false;
    });
  }

  void handleTap() {
    if (isAddingCheckbox && titleController.text.trim().isEmpty) {
      hideAddCheckbox();  // Hide if empty when tapping away
    } else {
      setState(() {
        isAddingCheckbox = true;
      });
    }
  }

  void printCheckedItems() {
    checked.forEach((item, isChecked) {
      if (isChecked) {
        print(item); // Perform your action with the checked item
      }
    });
    Navigator.pop(context); // Go back to the previous screen
  }

  @override
  void dispose() {
    emojiController.dispose();
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = calculateProgress();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        iconTheme: IconThemeData(color: AppColors.secondaryColor), // Back arrow color
        actions: [
          IconButton(
            icon: Icon(Icons.check, color: AppColors.secondaryColor), // Checkmark color
            onPressed: printCheckedItems,
          ),
        ],
        title: const Text('Todo List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
            fontSize: 24,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(6.0),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.primaryColor,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentTwo),
            minHeight: 6,
          ),
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: GestureDetector(
        onTap: handleTap,
        behavior: HitTestBehavior.opaque, // Ensure the gesture detector is always hit
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: items.length + (isAddingCheckbox ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isAddingCheckbox && index == items.length) {
                    return ListTile(
                      leading: Container(
                        width: 40,
                        child: TextField(
                          controller: emojiController,
                          decoration: InputDecoration(hintText: defaultEmoji),
                          keyboardType: TextInputType.text, // For emoji keyboard
                        ),
                      ),
                      title: TextField(
                        controller: titleController,
                        decoration: InputDecoration(hintText: 'Enter title'),
                        onSubmitted: (_) => addCheckbox(),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: addCheckbox,
                      ),
                    );
                  }

                  String item = items[index];
                  String emoji = emojis[index];
                  return Dismissible(
                    key: Key(item),
                    background: Container(color: Colors.red),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        items.removeAt(index);
                        emojis.removeAt(index);
                        checked.remove(item);
                      });
                    },
                    child: CheckboxListTile(
                      value: checked[item],
                      title: Text(
                        "$emoji $item",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF333333),
                        ),
                      ),
                      onChanged: (bool? value) {
                        _onCheckboxChanged(item, value!);
                      },
                    ),
                  );
                },
              ),
            ),
            LinearProgressIndicator(value: progress),
          ],
        ),
      ),
    );
  }
}
