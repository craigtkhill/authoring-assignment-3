ArrayList updateMovies() {
  ArrayList<String> movies = new ArrayList<>();
  // For each movie in the movie titles column
  // if the query is least than the movie title length but greater than zero
  // and if the the substring of the movie is equal to the query of the same length
  // then the movie is added to the list
  for (String movie : movieTitles.getStringColumn("MovieName")) {
    if (query.length() <= movie.length() && query.length() >= 0) {
      if (movie.toLowerCase().substring(0, query.length()).equals(query.toLowerCase())) {
        movies.add(movie.toLowerCase());
      }
    }
  }
  return movies;
}

String movieSelection(ArrayList<String> movies) {
  // converts the list of movies into a string
  String possibleMovieChoices = "";
  for (String movie : movies) {
    possibleMovieChoices += "\n" + movie ;
  }
  return possibleMovieChoices;
}
