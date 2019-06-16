class User < ApplicationRecord
    validates :username, presence: true

    # This class method returns ActiveRecord:Relation object of all users that have
    # forbidden usernames.

    # DisallowedUsername.all returns 7 rows of forbidden usernames.
    # Number of User rows with forbidden usernames (before db alterations): 25

    def self.find_disallowed_usernames
        found_disallowed_users = User.where(username: DisallowedUsername
                                     .select("invalid_username"));
        return(found_disallowed_users);
    end

    # This class method resolves users that share same username by concatenting 
    # an incrementing integer to the username string. The first occurance of username
    # value will be ignored.

    # It accepts an argument called "dry_run". Its default value is false. 
    # If it's false, then the function will alter the rows to resolve the 
    # conflicts and update the database. If it's true, no alteration to the 
    # rows and the database would be made and print the user row that have same usernames on console instead.

    # The function will return an ActiveRecord:Relations object that will
    # contain all User rows that have duplicate usernames with another User row.
    # If dry_run was false, it will show updated usernames for each User row.

    # This function ignores duplicate usernames that are disallowed because that
    # is handled by User.resolve_forbidden_usernames separately. 

    # Number of User Rows that have duplicate allowed usernames (before db alterations): 681

    def self.resolve_duplicates(dry_run = false)
        counter = {};
        
        duplicate_usernames = User.where("username IN (?) AND username NOT IN (?)", 
                            User.select("username").group("username").having("count(username) > ?", 1),
                            DisallowedUsername.select("invalid_username"));
        

        if(dry_run)
            duplicate_usernames.each do |user|
                puts "User ID: #{user.id}, Username: #{user.username}"
            end
        else

            duplicate_usernames.each do |user|
                username = user.username;

                if(!counter[username])
                    counter[username] = 1; 
                else
                    user.username = username + counter[username].to_s 
                    user.save!
                    counter[username] += 1;
                end

            end
        end

        return duplicate_usernames;

    end

    # This class method resolves users that have forbidden usernames listed on
    # disallowed_usernames table by concating an incrementing integer to the username string.
    # By incrementing an integer, it also solves users that share same forbidden usernames.
    # The difference between this function and User.resolve_duplicates is that the first occurance
    # is not ignored and its username is concatinated with an integer so that no user has 
    # disallowed usernames.   

    # Like User.resolve_duplicates, it accepts an argument called "dry_run".
    # If dry_run is false, then the function will alter the rows to resolve the 
    # conflicts and update the database. If it is true, no alteration to the 
    # rows and the database would be made and print the user row that have 
    # forbidden usernames on console instead.

    # The function will return an ActiveRecord:Relations object that will
    # contain all User rows that have disallowed usernames.
    # If dry_run was false, it will show updated usernames for each User row.

    # Number of User Rows that have forbidden usernames (before db alterations): 25

    def self.resolve_forbidden_usernames(dry_run = false)
        
        counter = {};
        forbidden_usernames = User.find_disallowed_usernames
        
        if(dry_run)
            forbidden_usernames.each do |user|
                puts "User ID: #{user.id}, Username: #{user.username}"
            end
        else

            forbidden_usernames.each do |user|

                username = user.username;

                if(!counter[username])
                    counter[username] = 1;
                end

                user.username = username + counter[username].to_s 
                user.save!
                counter[username] += 1;

            end
        end

        return forbidden_usernames;

    end

    #  This function returns false if any user share a same username with another user or
    #  if any user has a forbidden username. It returns true otherwise.

    def self.is_all_users_valid?
        return User.where("username IN (?) OR username IN (?)", 
                        User.select("username").group("username").having("count(username) > ?", 1),
                        DisallowedUsername.select("invalid_username")).empty?;
    end

    # This function resolves both duplicate usernames and disallowed usernames for all users.
    # It will return true if all conflicts has been successfully resolved. It will return
    # false otherwise.

    def self.resolve_all
        self.resolve_duplicates;
        self.resolve_forbidden_usernames;
        return self.is_all_users_valid?
    end


end