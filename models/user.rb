require 'bcrypt'

# creating new user
def create_user(email, password)
    password_digest = BCrypt::Password.create(password)
    sql = "INSERT INTO users (email, password_digest) VALUES ('#{email}', '#{password_digest}');"
    run_sql(sql)
end


def find_one_user_by_id(id)
  sql = "SELECT * FROM users WHERE id = #{ id };"
  run_sql(sql)[0]
end

# when user logged in use this function to display email
def find_one_user_by_email(email)
    records = run_sql("SELECT * FROM users WHERE email = '#{ email }';")
    if records.count == 0
      return nil
    else
      return records[0]
    end
end
