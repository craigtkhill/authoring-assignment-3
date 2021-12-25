import rita.*;
import uibooster.*;
import java.util.*;

String query = ""; // The users search query

ArrayList<String> movies; // List of movies
ArrayList<String> characters; // List of characters

String movieChoices; // List of possible movie choices
String movieChoice = ""; // Users movie choice
String movieId; // used to connect the movies titles and movie lines tables
String characterChoice = ""; // Users character choice

Table movieTitles, movieLines; // Movie titles and movie lines tables
Table charactersTable; // table containing only the characters of the selected movie
Table linesTable; // table containing only the lines of a particular character in a movie

Integer percentagePersonalPronouns; // percentage of lines contain personal pronouns

void setup() {
  frameRate(12);
  size(1080, 720);
  background(213, 126, 126);
  textSize(36);
  textAlign(CENTER);

  // Datasets are loaded
  movieTitles = loadTable("movie_titles_metadata_header.csv", "header");
  movieLines = loadTable("movie_lines_header.csv", "header");
}

void draw() {
  background(213, 126, 126);

  // If no movie has been chosen
  if (movieChoice.equals("")) {
    // and the search query is empty the user is prompted to start typing
    if (query.length() == 0) {
      text("Type to search Movies - press enter to select top result", width/2, height/6);
      // Otherwise the users search query is displayed
    } else {
      text(query, width/2, height/6);
    }
    fill(255);

    // updateMovies returns a list of movies that match the first letters of the users query
    movies = updateMovies();
    // selection returns the list of movies as a string
    movieChoices = movieSelection(movies);
    // and this selection is printed to the display
    text(movieChoices, width/2, height/5);
    fill(0);

    // Once a movie is chosen but a character is yet to be chosen
  } else if (characterChoice == "") {
    // the user is prompted to chose a character from the movie
    text("select a character in " + movieChoice, width/2, height/6 );

    // The movie ID is found
    TableRow chars = movieTitles.findRow(movieChoice, "MovieName");
    movieId = chars.getString("MovieID");

    // this movie ID is used to update the characters table
    charactersTable = characterTable(movieId);
    // the choice of characters are updated to a list
    characters = updateCharacters(charactersTable);
    // Using UI booster the user is prompted to select a character
    characterChoice = chooseCharacter();

    // When a character has been chosen a table is created with the dialogue of that character
  } else {
    linesTable = dialogueTable(characterChoice);
    // The lines with personal pronouns and total number of lines are trackes
    percentagePersonalPronouns = personalPronounPercent(linesTable);
    // The result is printed to the display
    text(percentagePersonalPronouns
      + "% of" +
      characterChoice + "'s lines in "
      + movieChoice
      + "\ninclude a personal pronoun"
      , width/2, height/2);
    // the user reminded that they can use the backspace key to make another choice
    text("(<- BACKSPACE)", width/2, height/10);
  }
}

void keyPressed()
{  // if the user presses enter the movie choice is saved as the first item in the list
  if (key == ENTER || key == RETURN) {
    movieChoice = movies.get(0);
  }
  // if characters remain and the backspace key is pressed
  // the query is updated to remove one character from the end
  if (key == BACKSPACE && query.length() > 0) {
    query = query.substring(0, query.length() -1);
  }
  // if the key is a alphanumeric or space then the key is concatenated to the query
  if ((key >= 'A' && key <= 'z') || key == ' ' ||(key >= '0' && key <= '9')) {
    query += key;
  }
  // if backspace key is pressed after a character is selected
  // the movie, character and query choices are reset
  if (key == BACKSPACE && characterChoice != "") {
    movieChoice = "";
    characterChoice = "";
    query = "";
  }
}
