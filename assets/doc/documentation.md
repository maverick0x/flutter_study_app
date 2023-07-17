# How to get all json file names in a specific path
## Step 1: Load the all the file names in the assets folder
```final manifestContent = await DefaultAssetBundle.of(Get.context!).loadString('AssetManifest.json');```

## Step 2: Decode the manifestContent to access the text part of it.
```final Map<String, dynamic> manifestMap = json.decode(manifestContent);```

## Step 3: Filter for the path and the type of file to access within the path
```final papersInAssets = manifestMap.keys.where((element) => element.startsWith('assets/DB/papers') && element.contains('.json')).toList();```

## Step 4: Then use the file names where they are required
```print(papersInAssets);```


**Use jsontodart.com to build model from a json text.**
Copy the content of a json file to to the website then copy the dart code provided.
Put the code in a file as your model and make changes where necessary.
After that you have a model to work with that structure contained within the json file.