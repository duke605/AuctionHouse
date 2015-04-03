class CreateItems < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TABLE items (
            id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            local_name VARCHAR(50) NOT NULL,
            name VARCHAR(50) NOT NULL,
            metadata INTEGER NOT NULL CHECK (metadata >= 0),
            price INTEGER NOT NULL CHECK (price >= 1),
            offer_type VARCHAR(7) NOT NULL CHECK (offer_type IN ('selling', 'buying', 'removed')),
            quantity_initial INTEGER NOT NULL CHECK (quantity_initial >= 1),
            quantity_remaining INTEGER CHECK (quantity_remaining >= 0 AND quantity_remaining <= quantity_initial),
            quantity_stored INTEGER DEFAULT 0 CHECK (quantity_stored >= 0 AND quantity_stored <= quantity_initial),
            user_id INTEGER NOT NULL,
            created_at DATETIME NOT NULL,
            updated_at DATETIME NOT NULL,
            FOREIGN KEY (user_id) REFERENCES users
          );
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TABLE items;
        SQL
      end
    end
  end
end
