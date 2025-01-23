import 'package:flutter/material.dart';

class FreightRatesScreen extends StatefulWidget {
  const FreightRatesScreen({super.key});

  @override
  _FreightRatesScreenState createState() => _FreightRatesScreenState();
}

class _FreightRatesScreenState extends State<FreightRatesScreen> {
  bool isOriginCheckboxChecked = false;
  bool isDestinationCheckboxChecked = false;
  bool isFCLChecked = false;
  bool isLCLChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6E9FA),
      appBar: AppBar(
        title: const Text(
          'Search the Best Freight Rates',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: false,
        backgroundColor: const Color(0XFFf2f5fc),
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0XFFE6EBFF),
                border: Border.all(color: const Color(0xff0139FF), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "History",
                style: TextStyle(
                    color: Color(0xff0139FF), fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 600;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 16),
                        isMobile
                            ? Column(
                          children: [
                            buildTextField(
                              'Origin',
                              description: "Include nearby origin ports",
                              showCheckbox: true,
                              checkboxValue: isOriginCheckboxChecked,
                              onCheckboxChanged: (value) {
                                setState(() {
                                  isOriginCheckboxChecked = value;
                                });
                              },
                            ),
                            const SizedBox(height: 8),
                            buildTextField(
                              'Destination',
                              description:
                              "Include nearby destination ports",
                              showCheckbox: true,
                              checkboxValue: isDestinationCheckboxChecked,
                              onCheckboxChanged: (value) {
                                setState(() {
                                  isDestinationCheckboxChecked = value;
                                });
                              },
                            ),
                          ],
                        )
                            : Row(
                          children: [
                            Expanded(
                              child: buildTextField(
                                'Origin',
                                description:
                                "Include nearby origin ports",
                                showCheckbox: true,
                                checkboxValue: isOriginCheckboxChecked,
                                onCheckboxChanged: (value) {
                                  setState(() {
                                    isOriginCheckboxChecked = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: buildTextField(
                                'Destination',
                                description:
                                "Include nearby destination ports",
                                showCheckbox: true,
                                checkboxValue: isDestinationCheckboxChecked,
                                onCheckboxChanged: (value) {
                                  setState(() {
                                    isDestinationCheckboxChecked = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: buildDropdown('Commodity', [
                                '10\'abc',
                                '20\'abc',
                              ]),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: buildDatePickerField(
                                'Cut Off Date',
                                DateTime(2025, 1, 1),
                                    (date) {
                                  setState(() {
                                  });
                                },
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 16),
                        buildCheckboxOptions(
                          'Shipment Type',
                          [
                            CheckboxOption(
                              label: 'FCL',
                              value: isFCLChecked,
                              onChanged: (value) {
                                setState(() {
                                  isFCLChecked = value;
                                });
                              },
                            ),
                            CheckboxOption(
                              label: 'LCL',
                              value: isLCLChecked,
                              onChanged: (value) {
                                setState(() {
                                  isLCLChecked = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: buildDropdown('Container Size', [
                                '20\' Standard',
                                '40\' Standard',
                              ]),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: buildTextField('No. of Boxes'),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: buildTextField('Weight (Kg)'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        buildDimensionSection(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(
      String label, {
        String? hintText,
        String? description,
        bool? showCheckbox,
        ValueChanged<bool>? onCheckboxChanged,
        bool checkboxValue = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: (label == 'Origin' || label == 'Destination')
                ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Image.asset(
                "assets/location.png",
                width: 24,
                height: 24,
                fit: BoxFit.contain,
              ),
            )
                : null,
            labelText: label,
            hintText: hintText,
            labelStyle: const TextStyle(fontSize: 14),
            border: OutlineInputBorder(),
          ),
        ),
        if (description != null && showCheckbox == true) ...[
          const SizedBox(height: 8),
          Row(
            children: [
              Checkbox(
                value: checkboxValue,
                onChanged: (value) {
                  if (onCheckboxChanged != null) {
                    onCheckboxChanged(value ?? false);
                  }
                },
              ),
              Expanded(
                child: Text(
                  description,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget buildDatePickerField(String label, DateTime? selectedDate, ValueChanged<DateTime?> onDateSelected) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          onDateSelected(pickedDate);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null
                  ? 'Select $label'
                  : "${selectedDate.toLocal()}".split(' ')[0],
              style: const TextStyle(fontSize: 14),
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }


  Widget buildDropdown(String label, List<String> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 14),
        border: OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        ),
      )
          .toList(),
      onChanged: (value) {},
    );
  }

  Widget buildCheckboxOptions(String label, List<CheckboxOption> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 16,
          children: options
              .map(
                (option) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                  value: option.value,
                  onChanged: (bool? newValue) {
                    option.onChanged(newValue!);
                  },
                ),
                Text(option.label),
              ],
            ),
          )
              .toList(),
        ),
      ],
    );
  }

  Widget buildDimensionSection() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: const [
                    Text(
                      'Length:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text('39.46 ft'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Text(
                      'Width:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text('7.70 ft'),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: const [
                    Text(
                      'Height:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 8),
                    Text('7.84 ft'),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 24),
            Image.asset(
              'assets/graph.png',
              width: 300,
              height: 140,
              fit: BoxFit.contain,
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () {},
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0XFFE6EBFF),
                border: Border.all(color: const Color(0xff0139FF), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Search",
                style: TextStyle(
                    color: Color(0xff0139FF), fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class CheckboxOption {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  CheckboxOption({
    required this.label,
    required this.value,
    required this.onChanged,
  });
}
