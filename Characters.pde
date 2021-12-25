Table characterTable(String movieId) {
  // creates a table of characters with matching row to the movie id
  Table characters = new Table();
  for (TableRow characterRow : movieLines.matchRows(movieId, "MovieID")) {
    characters.addRow(characterRow);
  }
  return characters;
}

ArrayList updateCharacters(Table characterTable) {
  // adds a set of the characters names a list 
  ArrayList<String> characters = new ArrayList<>();
  for (String character : characterTable.getStringColumn(3)) {
    if (!characters.contains(character.toLowerCase())) {
      characters.add(character.toLowerCase());
    }
  }
  return characters;
}

String chooseCharacter() {
  // using UI booster the user selects a character from the chosen movie
  Object[] array = characters.toArray();
  String[] stringArray = Arrays.copyOf(array, array.length, String[].class);
  String selection = new UiBooster().showSelectionDialog(
    "Choose a character in " + movieChoice,
    movieChoice,
    stringArray);
  return selection;
}
