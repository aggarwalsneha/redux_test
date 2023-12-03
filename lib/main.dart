import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
void main() {
  runApp(MyApp());
}

class AppState{
  final counter;
  AppState(this.counter);
}

enum Actions{increment}

int reducer(int state,action){
  if(action==Actions.increment) {
    return state+1;
  }
  return state;
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final store = Store<int>(reducer, initialState: 0);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(store),
    );
  }
}

class MyHomePage extends StatelessWidget {

  final Store<int> store;

  MyHomePage(this.store);

  @override
  Widget build(BuildContext context) {

    return StoreProvider<int>(store: store, child:
      Scaffold(
      appBar: AppBar(
        title: Text('Redux App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            StoreConnector<int,String>( converter: (store)=>store.state.toString(),
              builder: (context,counter)=>Text('$counter',
              style: Theme.of(context).textTheme.headline4,
            ),)
          ],
        ),
      ),
      floatingActionButton: StoreConnector<int,VoidCallback>(
        converter: (store) {
          return ()=> store.dispatch(Actions.increment);
          },
        builder: (context,callback)=>
            FloatingActionButton(
              onPressed: callback,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    )
    );
  }
}
