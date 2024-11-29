import 'package:flutter/material.dart';
import 'package:starbhakmart/pages/add_page.dart';
import 'package:starbhakmart/pages/cart_page.dart';
import 'package:starbhakmart/theme.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: _buildAppBarIcon(
          Icons.menu,
          () {},
        ),
        leadingWidth: 56,
        actions: [
          _buildAppBarIcon(
            Icons.person_outline,
            () {},
          ),
          const SizedBox(width: 2), 
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCategoryItem(Icons.store_mall_directory, 'All', true),
                _buildCategoryItem(Icons.lunch_dining, 'Makanan', false),
                _buildCategoryItem(Icons.local_drink, 'Minuman', false),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'All Food',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                if(index == 0){
                  return _buildFoodItem(
                  'Burger King Medium',
                  'Rp. 50.000,00',
                  'assets/images/Burger.jpeg',
                );
                }else if(index == 1) {
                   return _buildFoodItem(
                  'Burger King Large',
                  'Rp. 100.000,00',
                  'assets/images/Burger.jpeg',
                );
                }else if(index == 2) {
                   return _buildFoodItem(
                  'Teh Botol',
                  'Rp. 5.000,00',
                  'assets/images/teh-botol.jpeg',
                );
                }else if(index == 3) {
                  return _buildFoodItem(
                  'Paket Panas 1',
                  'Rp. 20.000,00',
                  'assets/images/paket-panas1.jpeg',
                );
                }else if(index == 4) {
                   return _buildFoodItem(
                  'Paket Panas 2',
                  'Rp. 22.000,00',
                  'assets/images/paket-panas2.jpeg',
                );
                }else if(index == 5) {
                  return _buildFoodItem(
                  'Bucket Ayam',
                  'Rp. 120.000,00',
                  'assets/images/bucket-ayam2.jpeg',
                );
                }

              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: birubg,),
            label: 'Home',
          ),

BottomNavigationBarItem(
  icon: InkWell( 
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartPage()), 
      );
    },
    child: Stack(
      children: [
        Icon(Icons.shopping_cart),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(6),
            ),
            constraints: BoxConstraints(
              minWidth: 12,
              minHeight: 12,
            ),
            child: Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  ),
  label: 'Cart',
),

          BottomNavigationBarItem(
            icon: InkWell( 
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddPage()), 
      );
    },
    child: Stack(
      children: [
        Icon(Icons.list_alt),
      ],
    ),
  ),

             label: 'Add'
          ),
        ],
              ),
    );
  }

  Widget _buildAppBarIcon(IconData icon, VoidCallback onPressed) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.2),  // Shadow color
        //     spreadRadius: 2,  // How far the shadow spreads
        //     blurRadius: 8,   // How blurry the shadow is
        //     offset: const Offset(0, 2),  // Shadow position
        //   ),
        // ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 20),
        onPressed: onPressed,
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? birubg : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
              ),
            ],
          ),
          child: Icon(
            icon,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? birubg : Colors.black,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildFoodItem(String name, String price, String imageUrl) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                image: DecorationImage(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}