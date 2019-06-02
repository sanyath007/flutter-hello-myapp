import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp2());

class MyApp extends StatelessWidget {
    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
        // final wordPair = WordPair.random();

        return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                // primarySwatch: Colors.blue,
                primaryColor: Colors.white,
            ),
            // home: RandomWords(),
            // home: MyScaffold(),
            home: TutorialHome(),
            // // home: MyButton(),
            // home: ShoppingList(
            //     products: <Product>[
            //         Product(name: 'Eggs'),
            //         Product(name: 'Flour'),
            //         Product(name: 'Chocolate chips'),
            //     ],
            // ),
        );
    }
}

class RandomWords extends StatefulWidget {
    @override
    createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
    final _suggestions = <WordPair>[];
    final _saved = Set<WordPair>();
    final _biggerFont = const TextStyle(fontSize: 18.0);

    @override
    Widget build(BuildContext context) {
        // final wordPair = WordPair.random();
        // return Text(wordPair.asPascalCase);
        return Scaffold(
            appBar: AppBar(
                title: Text('Startup Name Generator'),
                actions: <Widget>[
                    IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
                ],
            ),
            body: _buildSuggestions(),
        );
    }

    Widget _buildSuggestions() {
        return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, i) {
                if(i.isOdd) return Divider();

                final index = i ~/ 2;

                if(index >=_suggestions.length) {
                    _suggestions.addAll(generateWordPairs().take(10));
                }

                return _buildRow(_suggestions[index]);
            },
        );
    }

    Widget _buildRow(WordPair pair) {
        final alreadySaved = _saved.contains(pair);

        return ListTile(
            title:Text(
                pair.asPascalCase,
                style:_biggerFont,
            ),
            trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color:alreadySaved ? Colors.red : null,
            ),
            onTap: () {
                setState(() {
                    if(alreadySaved) {
                        _saved.remove(pair);
                    } else {
                        _saved.add(pair);
                    }
                });
            },
        );
    }

    void _pushSaved() {
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) {
                    final tiles =_saved.map(
                        (pair) {
                            return ListTile(
                                title: Text(
                                    pair.asPascalCase,
                                    style:_biggerFont,
                                ),
                            );
                        },
                    );
                    final divided =ListTile
                        .divideTiles(
                            context: context,
                            tiles: tiles,
                        )
                        .toList();

                    return Scaffold(
                        appBar: AppBar(
                            title:Text('Saved Suggestions')
                        ),
                        body: ListView(children: divided),
                    );
                }
            )
        );
    }
}

class MyAppBar extends StatelessWidget {
  MyAppBar({this.title});

  // Fields in a Widget subclass are always marked "final".

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.blue[500]),
      // Row is a horizontal, linear layout.
      child: Row(
        // <Widget> is the type of items in the list.
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Navigation menu',
            onPressed: null, // null disables the button
          ),
          // Expanded expands its child to fill the available space.
          Expanded(
            child: title,
          ),
          IconButton(
            icon: Icon(Icons.search),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}

class MyScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Material is a conceptual piece of paper on which the UI appears.
    return Material(
      // Column is a vertical, linear layout.
      child: Column(
        children: <Widget>[
          MyAppBar(
            title: Text(
              'Example title',
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
          Expanded(
            child: Center(
              child: Text('Hello, world!'),
            ),
          ),
        ],
      ),
    );
  }
}

class TutorialHome extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    tooltip: 'Navigation menu',
                    onPressed: null,
                ),
                title: Text('Example Title'),
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.search),
                        tooltip: 'Search',
                        onPressed: null,
                    )
                ],
            ),
            body: Center(
                // child: Text('Hello World'),
            ),
            floatingActionButton: FloatingActionButton(
                tooltip: 'Add',
                child: Icon(Icons.add),
                onPressed: null,
            ),
        );
    }
}

class MyButton extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () {
                print('MyButton was tapped!');
            },
            child: Container(
                height: 36.0,
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.lightGreen[500],
                ),
                child: Center(
                    child: Text('Engage'),
                ),
            ),
        );
    }
}

class Product {
    const Product({this.name});
    final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
    ShoppingListItem({Product product, this.inCart, this.onCartChanged})
        : product = product,
          super(key:ObjectKey(product));
    
    final Product product;
    final bool inCart;
    final CartChangedCallback onCartChanged;

    Color _getColor(BuildContext context) {
        return inCart ? Colors.black54 : Theme.of(context).primaryColor;
    }

    TextStyle _getTextStyle(BuildContext context) {
        if(!inCart) return null;

        return TextStyle(
            color: Colors.black54,
            decoration: TextDecoration.lineThrough,
        );
    }

    @override
    Widget build(BuildContext context) {
        return ListTile(
            onTap: () {
                onCartChanged(product, !inCart);
            },
            leading: CircleAvatar(
                backgroundColor: _getColor(context),
                child: Text(product.name[0]),
            ),
            title: Text(product.name, style:_getTextStyle(context)),
        );
    }
}

class ShoppingList extends StatefulWidget {
    ShoppingList({Key key, this.products}) : super(key: key);

    final List<Product> products;

    @override
    _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
    Set<Product> _shoppingCart = Set<Product>();

    void _handleCartChanged(Product product, bool inCart) {
        setState(() {
            if(inCart)
                _shoppingCart.add(product);
            else
                _shoppingCart.remove(product);
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Shopping List'),
            ),
            body: ListView(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                children: widget.products.map((Product product) {
                    return ShoppingListItem(
                        product: product,
                        inCart: _shoppingCart.contains(product),
                        onCartChanged: _handleCartChanged,
                    );
                }).toList(),
            ),
        );
    }
}

class FavoriteWidget extends StatefulWidget {
    @override
    _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
    bool _isFavorited = true;
    int _favoriteCount = 41;

    void _toggleFavorite() {
        setState(() {
            if(_isFavorited) {
                _favoriteCount -= 1;
                _isFavorited = false;
            } else {
                _favoriteCount += 1;
                _isFavorited = true;
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
                Container(
                    padding: EdgeInsets.all(0),
                    child: IconButton(
                        icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
                        color: Colors.red[500],
                        onPressed: _toggleFavorite,
                    ),
                ),
                SizedBox(
                    child: Container(
                        child: Text('$_favoriteCount'),
                    ),
                )
            ],
        );
    }

}

class MyApp2 extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        Widget titleSection =Container(
            padding: const EdgeInsets.all(32),
            child: Row(
                children: [
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Container(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Text(
                                        'Oeschinen Lake Campground',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                        ),
                                    ),
                                ),
                                Text(
                                    'Kandersteg, Switzerland',
                                    style:TextStyle(
                                        color: Colors.grey[500],
                                    ),
                                ),
                            ],                  
                        ),
                    ),
                    FavoriteWidget(),
                ],
            ),
        );

        Color color = Theme.of(context).primaryColor;

        Widget buttonSection = Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    _buildButtonColumn(color, Icons.call, 'Call'),
                    _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
                    _buildButtonColumn(color, Icons.share, 'SHARE'),
                ],
            ),
        );

        Widget textSection = Container(
            padding: const EdgeInsets.all(32),
            child: Text(
                'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
            'Alps. Situated 1,578 meters above sea level, it is one of the '
            'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
            'half-hour walk through pastures and pine forest, leads you to the '
            'lake, which warms to 20 degrees Celsius in the summer. Activities '
            'enjoyed here include rowing, and riding the summer toboggan run.',
                softWrap: true,
            ),
        );

        return MaterialApp(
            title: 'Flutter layout demo',
            home: Scaffold(
                appBar: AppBar(
                    title: Text('Flutter layout demo'),
                ),
                body: ListView(
                    children: [
                        Image.asset(
                            'images/lake.jpg',
                            width: 600,
                            height: 240,
                            fit: BoxFit.cover,
                        ),
                        titleSection,
                        buttonSection,
                        textSection,
                    ],
                ),
            ),
        ); 
    }

    Column _buildButtonColumn(Color color, IconData icon, String label) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Icon(icon, color: color),
                Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                        label,
                        style:TextStyle(
                            fontSize: 12,
                            fontWeight:FontWeight.w400,
                            color: color,
                        ),
                    ),
                ),
            ],
        );
    }
}