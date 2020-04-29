def run_sql(sql)
    conn = PG.connect(dbname: 'wishlist')
    records = conn.exec(sql)
    conn.close
    records
end

# will use edit item details edit.erb
def find_one_item_by_id(id)
    sql = "SELECT * FROM items WHERE id = #{ id };"
    run_sql(sql)[0]
end

# will use for the display in mylist
def find_all_items_by_user_id(user_id)
    sql = "SELECT * FROM items WHERE user_id = #{ user_id } ORDER BY id;"
    run_sql(sql)
end


def create_item(name, image_url, price, reason, user_id)
    sql = "INSERT INTO items (name, image_url, price, reason, user_id) 
    VALUES ('#{ name }', '#{ image_url }', #{ price }, '#{ reason }', #{ user_id });"
    run_sql(sql)
end

def update_item(id, name, image_url, price, reason)
    sql = "UPDATE items SET name = '#{ name }', image_url = '#{ image_url }', price = #{ price }, reason = '#{ reason }' WHERE id = #{ id } ;"
    run_sql(sql)
end

def delete_item(id)
    sql = "DELETE FROM items WHERE id = #{ id };"
    run_sql(sql)
end