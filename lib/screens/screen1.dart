import 'package:applicatiocandidature/screens/screen2.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fl_chart/fl_chart.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  final List<Widget> _icons = [
    FaIcon(FontAwesomeIcons.binoculars, size: 40, color: Colors.blue),
    Icon(Icons.pause, size: 40, color: Colors.blue),
    Icon(Icons.av_timer_outlined, size: 40, color: Color.fromARGB(255, 247, 231, 17)),
    Icon(Icons.check_circle, size: 40, color: Color.fromARGB(255, 75, 245, 83)),
  ];

  final List<String> _texts = [
    '150',
    '4',
    '1',
    '2'
  ];
  int _selectedIndex = 0;

  void _onNavigationItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Screen2()),
        );
      }
    });
  }

  final List<String> _subtitles = [
    'My observations',
    'Pending',
    'Progress',
    'Resolved'
  ];

  List<String> _selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 236, 236),
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: const Color.fromARGB(255, 22, 108, 252),
        items: [
          Icon(Icons.dashboard, color: Colors.blue),
          Icon(Icons.add, color: Colors.blue),
          FaIcon(FontAwesomeIcons.binoculars, color: Colors.blue),
          Icon(Icons.image_search_outlined, color: Colors.blue)
        ],
        onTap: _onNavigationItemTapped,
        index: _selectedIndex,
      ),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              'Overview',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Spacer(),
            Icon(Icons.notifications),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: AssetImage('assets/ellipse.jpeg'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.15,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _icons.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: screenWidth * 0.6,
                    margin: EdgeInsets.all(screenWidth * 0.02),
                    child: Card(
                      color: Colors.white,
                      elevation: 5,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.005), // Réduit le padding
                              child: _icons[index],
                            ),
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.005), // Réduit le padding
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _texts[index],
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  SizedBox(height: screenHeight * 0.002), // Réduit la hauteur du SizedBox
                                  Text(
                                    _subtitles[index],
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );

                },
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
              ),
            ),

            if (_selectedFilters.isNotEmpty)
              Container(
                margin: EdgeInsets.all(screenWidth * 0.02),
                height: screenHeight * 0.07,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedFilters.length,
                  itemBuilder: (context, index) {
                    final filter = _selectedFilters[index];
                    return Container(
                      margin: EdgeInsets.only(right: screenWidth * 0.02),
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: Colors.transparent,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            filter,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedFilters.remove(filter);
                              });
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: screenWidth * 0.045,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            Container(
              width: double.infinity,
              height: screenHeight * 0.35,
              margin: EdgeInsets.all(screenWidth * 0.02),
              child: Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'My observations',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  'Statistics',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                _showFilterBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Expanded(
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 10,
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              topTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    const style = TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    );
                                    String text;
                                    switch (value.toInt()) {
                                      case 0: text = '18'; break;
                                      case 1: text = '19'; break;
                                      case 2: text = '20'; break;
                                      case 3: text = '21'; break;
                                      case 4: text = '22'; break;
                                      case 5: text = '23'; break;
                                      case 6: text = '24'; break;
                                      case 7: text = '25'; break;
                                      case 8: text = '26'; break;
                                      case 9: text = '27'; break;
                                      case 10: text = '28'; break;
                                      default: text = ''; break;
                                    }
                                    return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      space: 8.0,
                                      child: Text(text, style: style),
                                    );
                                  },
                                  reservedSize: screenWidth * 0.1,
                                ),
                              ),
                            ),
                            gridData: FlGridData(show: false),
                            borderData: FlBorderData(
                              show: false,
                            ),
                            barGroups: [
                              BarChartGroupData(
                                x: 0,
                                barRods: [
                                  BarChartRodData(toY: 5, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 1,
                                barRods: [
                                  BarChartRodData(toY: 8, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 2,
                                barRods: [
                                  BarChartRodData(toY: 3, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 3,
                                barRods: [
                                  BarChartRodData(toY: 7, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 4,
                                barRods: [
                                  BarChartRodData(toY: 6, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 5,
                                barRods: [
                                  BarChartRodData(toY: 4, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 6,
                                barRods: [
                                  BarChartRodData(toY: 9, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 7,
                                barRods: [
                                  BarChartRodData(toY: 3, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 8,
                                barRods: [
                                  BarChartRodData(toY: 6, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 9,
                                barRods: [
                                  BarChartRodData(toY: 7, color: Colors.blue),
                                ],
                              ),
                              BarChartGroupData(
                                x: 10,
                                barRods: [
                                  BarChartRodData(toY: 4, color: Colors.blue),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(screenWidth * 0.02),
              child: Card(
                color: Colors.white,
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Progress',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                Text(
                                  'Today',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Row(
                        children: [
                          Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  sections: [
                                    PieChartSectionData(
                                      value: 35,
                                      color: Colors.blue,
                                      title: '10',
                                      radius: screenWidth * 0.15,
                                      titleStyle: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: Colors.yellow,
                                      radius: screenWidth * 0.15,
                                      titleStyle: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: Colors.green,
                                      radius: screenWidth * 0.15,
                                      titleStyle: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: Colors.grey,
                                      radius: screenWidth * 0.15,
                                      titleStyle: TextStyle(
                                        fontSize: screenWidth * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                  sectionsSpace: screenWidth * 0.005,
                                  centerSpaceRadius: screenWidth * 0.1,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildLegendItem(Colors.blue, 'Pending'),
                              _buildLegendItem(Colors.yellow, 'Progress'),
                              _buildLegendItem(Colors.green, 'Resolved'),
                              _buildLegendItem(Colors.grey, 'Closed'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    'Filter by',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedFilters.clear();
                      });
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Clear',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildFilterOption(Icons.date_range, 'Date', ['Daily', 'Monthly', 'Yearly']),
              _buildFilterOption(Icons.type_specimen, 'Type', ['Type1', 'Type2', 'Type3']),
              _buildFilterOption(Icons.stacked_bar_chart, 'Status', ['Status1', 'Status2']),
              _buildFilterOption(Icons.category, 'Category', ['Category1', 'Category2', 'Category3']),
              _buildFilterOption(Icons.category_outlined, 'Subcategory', ['Subcategory1', 'Subcategory2']),
              _buildFilterOption(Icons.tag, 'Tags', ['Tag1', 'Tag2']),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterOption(IconData icon, String text, List<String> choices) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(text),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {
        _showFilterDialog(context, choices);
      },
    );
  }

  void _showFilterDialog(BuildContext context, List<String> choices) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select an option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: choices.map((choice) {
              return ListTile(
                leading: Icon(Icons.label),
                title: Text(choice),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _selectedFilters.add(choice);
                  });
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
