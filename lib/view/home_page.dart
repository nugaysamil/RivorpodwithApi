import 'package:apiwithriverpod/view/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:apiwithriverpod/controller/controller.dart';

final controller = ChangeNotifierProvider((ref) => Controller());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(controller).getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var read = ref.read(controller);
    var watch = ref.watch(controller);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text(
          'Riverpod',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: LoadingWidget(
        isLoading: watch.isLoading,
        child: Padding(
          padding: EdgeInsetsDirectional.all(15),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                      onPressed: () {
                        read.notSavedButton();
                      },
                      child: Text("Kullanıcılar ${watch.users.length}"),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 6,
                    child: OutlinedButton(
                      onPressed: () {
                        read.savedButton();
                      },
                      child: Text("Kaydedilenler ${watch.saved.length}"),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView(
                  controller: watch.pageController,
                  children: [
                    notSave(watch),
                    saved(watch),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView saved(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.saved.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 15,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(watch.saved[index].avatar),
            ),
            title: Text(
              "${watch.saved[index].firstName} ${watch.saved[index].lastName}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              watch.saved[index].email,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade400),
            ),
          ),
        );
      },
    );
  }

  ListView notSave(Controller watch) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: watch.users.length,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 15,
        );
      },
      itemBuilder: (BuildContext context, int index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(watch.users[index].avatar),
              radius: 20,
            ),
            title: Text(
              "${watch.users[index].firstName} ${watch.users[index].lastName}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              watch.users[index].email,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.grey.shade400),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.send_and_archive_outlined),
              onPressed: () {
                watch.addSaved(watch.users[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
