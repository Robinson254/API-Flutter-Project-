class Team{
  int id;
  final String  abbreviation;//LAL
  final String city;//Los Angeles
  final String conference;
  final String division;
  final String full_name;
  final String name;


  Team(
    {
       required this.id,
      required  this.conference,
      required this.division,
      required this.full_name, 
      required  this.name, 
      required this.abbreviation,
      required this.city
    });
}