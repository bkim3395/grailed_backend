<p align="center">
  <img width="200" height="200" src="https://raw.githubusercontent.com/bkim3395/grailed_backend/master/app/assets/images/grailed_image.jpeg">
</p>

# Grailed Backend Project Submission

## Objectives
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

This Rails project implements Model components but neglects Controller and View components as only concern of this project is the manipulation of the database.

## Documentations of implemented methods

### User.find_disallowed_usernames

    This class method returns ActiveRecord:Relation object of all users that have
    forbidden usernames.

    DisallowedUsername.all returns 7 rows of forbidden usernames.
    Number of User rows with forbidden usernames (before db alterations): 25

### User.resolve_duplicates(dry_run)

    This class method resolves users that have same username with another user by concatenting 
    an incrementing integer to the username string. The first occurance of username
    value will be ignored.

    It accepts an argument called "dry_run". Its default value is false. 
    If it's false, the changes to the rows would be saved to the database. 
    If it's true, the changes to the rows won't be saved to the database
    and instead the app will print altered User rows on Rails console.

    The function will return an ActiveRecord:Relations object that will
    contain all altered User rows that had duplicate usernames with another User row.

    This function ignores duplicate usernames that are disallowed because that
    is handled by User.resolve_forbidden_usernames separately. 

    Number of User Rows that have duplicate allowed usernames (before db alterations): 681

### User.resolve_forbidden_usernames(dry_run)

    This class method resolves users that have forbidden usernames listed on
    disallowed_usernames table by concating an incrementing integer to the username string.
    By incrementing an integer, it also solves users that share same forbidden usernames.
    The difference between this function and User.resolve_duplicates is that the first occurance
    is not ignored and its username is concatinated with an integer so that no users have 
    disallowed usernames.   

    Like User.resolve_duplicates, it accepts an argument called "dry_run".
    If it's false, the changes to the rows would be saved to the database. 
    If it's true, the changes to the rows won't be saved to the database
    and instead the app will print altered User rows on Rails console.

    The function will return an ActiveRecord:Relations object that will
    contain all altered User rows that had disallowed usernames.

    Number of User Rows that have forbidden usernames (before db alterations): 25

### User.is_all_users_valid?

     This function returns false if any user share a same username with another user or
     if any user has a forbidden username. It returns true otherwise.

### User.resolve_all

    This function resolves both duplicate usernames and disallowed usernames for all users.
    It will return true if all conflicts has been successfully resolved. It will return
    false otherwise.

## Comments

This submission was made by Bumsoo Kim.

My experience with Ruby on rails is about 0 ~ 1 years.