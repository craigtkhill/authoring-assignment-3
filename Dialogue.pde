Table dialogueTable(String characterName) {
  // creates a table of dialogue in the character table with the matching characters name
  Table Dialogue = new Table();
  for (TableRow dialogueRow : charactersTable.matchRows(characterName.toUpperCase(), 3)) {
    Dialogue.addRow(dialogueRow);
  }
  return Dialogue;
}

Integer personalPronounPercent(Table dialogue) {
  float linesWithPersonalPronouns = 0;
  float totalNumberOfLines = 0;
  // the lines of dialogue are iterated through
  for (String lines : dialogue.getStringColumn(4)) {
    // An array of the parts of speech are created for each line of dialogue
    String [] partsOfSpeech = RiTa.pos(lines);
    // if any of the items in the array contain personal pronouns
    // the lines with personal pronouns are incremented by one
    if (Arrays.asList(partsOfSpeech).contains("prp")) {
      linesWithPersonalPronouns += 1;
    }
    // the total number of lines are incremented
    totalNumberOfLines += 1;
  }
  return round(linesWithPersonalPronouns / totalNumberOfLines * 100);
}
