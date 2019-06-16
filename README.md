<p align="center">
  <img width="200" height="200" src="https://raw.githubusercontent.com/bkim3395/grailed_backend/master/app/assets/images/grailed_image.jpeg">
</p>

# Grailed Backend Project Submission by Bumsoo Kim

## Functions
+ Find all users with disallowed usernames noted on disallowed_username table.
+ Resolve all username collisions and alter the database accordingly.
+ Resolve all disallowed usernames and alter the database accordingly.

## Usage

To get started, open a terminal and type:

``` 
    bundle exec rails c
```

On Rails console, you can run User class methods such as:

``` Ruby
    User.find_disallowed_usernames

    User.resolve_duplicates(dry_run)

    User.resolve_forbidden_usernames(dry_run)

    User.is_all_users_valid?

    User.resolve_all

```

To restore the database to the unaltered state: exit the Rails console and type:

```
    cp grailed-exercise.sqlite3 db/grailed-exercise.sqlite3
```

This will overwrite the database being used with the backup.


## The Points of Interest

Some of the codes have been generated by Ruby on Rails. The following files below have been manually created or altered:

+ grailed-exercise.sqlite3
+ app/models/disallowed_username.rb
+ app/models/user.rb
+ config/database.yml
+ db/grailed-exercise.sqlite3
+ db/schema.rb

This Rails projects implements Model components but neglects controller and view component as only concern of this project has been the manipulation of the database.

## Documentations of implemented functions

### User.find_disallowed_usernames

    This class methods returns ActiveRecord:Relation of all users that have
    forbidden usernames.

    DisallowedUsername.all returns 7 rows of forbidden usernames.
    Number of User rows with forbidden usernames (before altering db): 25

### User.resolve_duplicates(dry_run)

    This class method resolves users that share same username by concatenting 
    an incrementing integer to the username string. The first occurance of username
    value will be ignored.

    It accepts one argument called "dry_run". Its default value is false. 
    If dry_run is false, then the function will alter the rows to resolve the 
    conflicts and update the database. If it is true, no alternation to the 
    database would be made.

    The function will return an ActiveRecord:Relations object that will
    contain all User rows that have duplicate usernames with another User row.
    If dry_run was true, it will show updated usernames for each user row.

    This function ignores duplicate usernames that are disallowed because that
    is handled by User.resolve_forbidden_usernames separately. 

    Number of User Rows that have duplicate usernames (before db alterncations): 681

### User.resolve_forbidden_usernames(dry_run)

    This class method resolves users that have forbidden usernames listed on
    disallowed_usernames table by concating an incrementing integer to the username.
    By incrementing an integer, it also solves users that share same forbidden usernames.
    The difference between this function and User.resolve_duplicates is that the first occurance
    is not ignored and its username is concatinated with an integer so that no user has 
    disallowed usernames.   

    Like User.resolve_duplicates, it accepts one argument called "dry_run".
    If dry_run is false, then the function will alter the rows to resolve the 
    conflicts and update the database. If it is true, no alternation to the 
    database would be made.

    The function will return an ActiveRecord:Relations object that will
    contain all User rows that have disallowed usernames.
    If dry_run was true, it will show updated usernames for each user row.

    Number of User Rows that have duplicate usernames (before db alterncations): 25

### User.is_all_users_valid?

     This function returns false if any user share a same username with another user or
     if any user has a forbidden username. It returns true otherwise.

### User.resolve.all

    This function resolves both duplicate usernames and disallowed usernames for all users.
    It will return true if all conflicts has been successfully resolved. It will return
    false otherwise.

## Comments

My experience with Ruby on rails is about 0 ~ 1 years.