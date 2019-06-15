Grailed Backend Project by Bumsoo Kim

Set up:

rails new grailed_backend --database=sqlite3 --skip-turbolinks

Change database.yml so that database is pointing to db/grailed.sqlite3

bundle exec rails db:schema:dump

bundle exec rails c

cp grailed-exercise.sqlite3 db/grailed-exercise.sqlite3